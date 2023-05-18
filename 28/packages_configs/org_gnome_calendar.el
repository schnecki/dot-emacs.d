;;; org-gnome-calendar.el --- Expose org-mode calendar to GNOME
;;
;; Copyright (C) 2012 Lluís Vilanova
;;
;; Author: Lluís Vilanova <vilanova@ac.upc.edu>
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of the
;; License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see http://www.gnu.org/licenses/.

;;; Commentary:
;;
;; Provides the global minor mode `global-org-gnome-calendar-mode' to export the
;; entries in the Org mode agenda to GNOME's calendar menu.
;;
;; If you also want to show an Org mode agenda when clicking into "Open
;; calendar" in GNOME's drop-down calendar menu, you can use "dconf-editor" to
;; set path "org.gnome.desktop.default-applications.office.calendar" into:
;;
;; emacs --eval '(progn (org-agenda nil "a" nil) (delete-other-windows))'

;;; Code:

(require 'org)
(require 'dbus)
(eval-when-compile
  (require 'cl))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Customizations

(defgroup org-gnome-calendar nil
  "Provide `org-mode' events to the GNOME calendar service."
  :group 'calendar)

(defcustom ogc:org-vars nil
  "Let-like form to override variables used by `org-agenda-get-day-entries'.
For example: `org-agenda-entry-types', `org-agenda-skip-function'
and `org-agenda-skip-regexp'."
  :group 'org-gnome-calendar)

(defcustom ogc:org-release-buffers nil
  "Whether to kill the used Org mode buffers when finished."
  :group 'org-gnome-calendar)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Get entries from Org mode

(defun ogc:--org-get-days-entries1 (day-numbers)
  (let* ((org-agenda-new-buffers nil)
         (files (org-agenda-files 'unrestricted))
         file entries)
    (org-agenda-prepare-buffers files)
    ;; For each file
    (while (setq file (pop files))
      ;; And each selected day
      (mapc
       (lambda (day-number)
         (let* ((time (time-subtract (days-to-time day-number)
                                     ;; day is at 1 AM
                                     (seconds-to-time (* 60 60))))
                (tim (decode-time time))
                (year (nth 5 tim))
                (month (nth 4 tim))
                (day (nth 3 tim))
                (date (list month day year))
                (org-agenda-buffer nil))
           (mapc
            (lambda (entry)
              (let* ((text (org-link-display-format
                            (substring-no-properties
                             (org-trim (or (get-text-property 1 'txt entry)
                                          "")))))
                     (dentry
                      (list
                       (cons 'day day-number)
                       (cons 'path file)
                       ;; Remove trailing tags from text
                       (cons 'text (replace-regexp-in-string
                                    "\\(.*[^\s]\\)\s+\\(:.+:\\)?" "\\1" text))
                       (cons 'time time)
                       (cons 'time-of-day (get-text-property 1 'time-of-day entry))
                       (cons 'duration (get-text-property 1 'duration entry)))))
                (add-to-list 'entries dentry t)))
            (apply 'org-agenda-get-day-entries
                   file date nil))))
       day-numbers))
    (when ogc:org-release-buffers
      (org-release-buffers org-agenda-new-buffers))
    entries))

(defun ogc:--org-get-days-entries (day-numbers)
  (progv (mapcar 'car ogc:org-vars) (mapcar 'cadr ogc:org-vars)
    (ogc:--org-get-days-entries1 day-numbers)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Calendar event cache

(defvar ogc:--event-cache nil
  "Cached mapping of day numbers to events.")

(defun ogc:--cache-outdated (entry)
  "Whether a cache entry is outdated."
  (let ((path (nth 0 entry))
        (time (nth 1 entry)))
    (and (file-exists-p path)
       (time-less-p
        (nth 5 (file-attributes path))
        time))))

(defun ogc:--cache-create (day)
  "Create space for entries."
  (add-to-list 'ogc:--event-cache (list day t)))

(defun ogc:--cache-add (day path entry)
  "Add an entry into the cache."
  (let ((entries (assoc day ogc:--event-cache))
        (centry (list path
                      (nth 5 (file-attributes path))
                      entry)))
    (if entries
        (nconc entries (list centry))
      (add-to-list 'ogc:--event-cache (append (list day)
                                              (list centry))))))

(defun ogc:--cache-get (day)
  "Get cached entries for DAY."
  (cdr (assoc day ogc:--event-cache)))

(defun ogc:--cache-delete (day)
  "Delete cached entries for DAY."
  (assq-delete-all day ogc:--event-cache))

(defun ogc:--cache-reset ()
  "Reset event cache."
  (setq ogc:--event-cache nil))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Main code

(defun ogc:--dbus-get-events (since until force-reload)
  "D-Bus callback for the `GetEvents' method."
  (let* ((day-since (floor (time-to-number-of-days (seconds-to-time since))))
         (day-until (floor (time-to-number-of-days (seconds-to-time until))))
         days
         result)

    ;; For each day in the range requested by D-Bus
    (loop for day from day-since to day-until do
          (let ((entries (ogc:--cache-get day)))
            (cond
             ((and force-reload (not entries))
              ;; Never seen this day
              (ogc:--cache-create day)
              (add-to-list 'days day t))
             ((and force-reload (some 'ogc:--cache-outdated (cdr entries)))
              ;; Remove outdated info from cache
              (ogc:--cache-delete day)
              (ogc:--cache-create day)
              (add-to-list 'days day t))
             (t
              ;; Use cached info
              (setq result (apply 'append result
                                  (mapcar (lambda (entry) (nth 3 entry))
                                          (cdr entries))))))))

    ;; Get entries for missing/outdated days
    (loop for entry in (ogc:--org-get-days-entries days) do
          (let* ((day (cdr (assoc 'day entry)))
                 (path (cdr (assoc 'path entry)))
                 (text (cdr (assoc 'text entry)))
                 (time (cdr (assoc 'time entry)))
                 (time-of-day (cdr (assoc 'time-of-day entry)))
                 (duration (cdr (assoc 'duration entry)))
                 (begin time)
                 (end (time-add begin (seconds-to-time 1)))
                 dentry)
            (when time-of-day
              (setq begin
                    (time-add begin
                              (seconds-to-time
                               (+ (* (mod time-of-day 100) 60)
                                  (* (floor (/ time-of-day 100)) 60 60)))))
              (setq end begin))
            (when duration
              (setq end
                    (time-add end
                              (seconds-to-time (* duration 60)))))
            (setq dentry
                  (list :struct
                        "" ;uid
                        text ;summary
                        "" ;description
                        :boolean (not time-of-day) ;all day
                        :int64 (floor (time-to-seconds begin)) ;start time
                        :int64 (floor (time-to-seconds end)) ;end time
                        (list :array :signature "{sv}")))
            (ogc:--cache-add day path dentry)
            (add-to-list 'result dentry)))

    ;; a(sssbxxa{sv})
    (if result
        (list :array result)
      nil)))


;;;###autoload
(define-global-minor-mode global-org-gnome-calendar-mode
  ogc:--org-gnome-calendar-mode
  ogc:--turn-on)

(defun ogc:--turn-on ()
  (ogc:--org-gnome-calendar-mode 1))

(defvar ogc:--dbus-service nil)
(defvar ogc:--dbus-object nil)

(define-minor-mode ogc:--org-gnome-calendar-mode
  "Provide `org-mode' events to the GNOME calendar service."
  :group org-gnome-calendar
  :init-value nil
  (if ogc:--org-gnome-calendar-mode
      (unless ogc:--dbus-object
        (setq ogc:--dbus-service (dbus-register-service :session
                                                        "org.gnome.Shell.CalendarServer"
                                                        :replace-existing)
              ogc:--dbus-object (dbus-register-method :session
                                                      "org.gnome.Shell.CalendarServer"
                                                      "/org/gnome/Shell/CalendarServer"
                                                      "org.gnome.Shell.CalendarServer"
                                                      "GetEvents"
                                                      'ogc:--dbus-get-events)))
    (when ogc:--dbus-object
      (dbus-unregister-object ogc:--dbus-object)
      (dbus-unregister-service :session "org.gnome.Shell.CalendarServer")
      (setq ogc:--dbus-service nil
            ogc:--dbus-object nil)
      (ogc:--cache-reset))))

(provide 'org-gnome-calendar)

(global-org-gnome-calendar-mode)

;; Local Variables:
;; byte-compile-warnings: (not cl-functions)
;; End:
;;; org-gnome-calendar.el ends here


