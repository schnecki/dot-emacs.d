;;; dired_config.el ---
;;
;; Filename: dired_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Di Mär  4 06:35:38 2014 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Fri Nov 21 09:13:03 2014 (+0100)
;;           By: Firstname Lastname
;;     Update #: 24
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


(require 'dired)

;; reuse the same buffer

(put 'dired-find-alternate-file 'disabled nil)

(global-set-key (kbd "C-x C-d") 'diredp-dired-files)

;; distinguishing dired mode buffers from others
(add-hook 'dired-mode-hook 'ensure-buffer-name-ends-in-slash)
(defun ensure-buffer-name-ends-in-slash ()
  "change buffer name to end with slash"
  (let ((name (buffer-name)))
    (if (not (string-match "/$" name))
        (rename-buffer (concat name "/") t))))


(defun dired-open-in-external-app ()
  "Open the current file or dired marked files in external app."
  (interactive)
  (let ( doIt
         (myFileList
          (cond
           ((string-equal major-mode "dired-mode") (dired-get-marked-files))
           (t (list (buffer-file-name))) ) ) )

    (setq doIt (if (<= (length myFileList) 5)
                   t
                 (y-or-n-p "Open more than 5 files?") ) )

    (when doIt
      (cond
       ((string-equal system-type "windows-nt")
        (mapc (lambda (fPath) (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" fPath t t)) ) myFileList)
        )
       ((string-equal system-type "darwin")
        (mapc (lambda (fPath) (shell-command (format "open \"%s\"" fPath)) )  myFileList) )
       ((string-equal system-type "gnu/linux")
        (mapc (lambda (fPath) (let ((process-connection-type
                                     nil)) (start-process "" nil "xdg-open" fPath)) )
              myFileList))))))


;; local hook
(add-hook 'dired-mode-hook
          (lambda ()
            ;; When moving to parent directory by `^´, Dired by
            ;; default creates a new buffer for each movement up. The
            ;; following rebinds `^´ to use the same buffer.

            (define-key dired-mode-map (kbd "^")
              (lambda () (interactive) (find-alternate-file "..")))
                                        ; was dired-up-directory
            (define-key dired-mode-map (kbd "o") 'dired-open-in-external-app)
            ))

;; WDired settings

(setq wdired-allow-to-change-permissions t)

(setq dired-hide-details nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; dired_config.el ends here
