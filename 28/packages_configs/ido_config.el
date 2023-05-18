;;; ido_config.el ---
;;
;; Filename: ido_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: So Okt 13 23:25:02 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Di Apr 15 15:26:28 2014 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 59
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
;;; Code:


;; NOTE: UNDO A MERGE WITH C-z


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ IDO COMPLETIONS ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(require 'ido)

;; enable ido mode
(ido-mode t)


;; DISPLAY IDO RESULTS VERTICALLY, RATHER THAN HORIZONTALLY
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))


(add-hook 'ido-setup-hook 'ido-define-keys)


;; LET IDO MODE COMPLETE ALMOST EVERYTHING
(defvar ido-enable-replace-completing-read t
  "If t, use ido-completing-read instead of completing-read if possible.

    Set it to nil using let in around-advice for functions where the
    original completing-read is required.  For example, if a function
    foo absolutely must use the original completing-read, define some
    advice like this:

    (defadvice foo (around original-completing-read-only activate)
      (let (ido-enable-replace-completing-read) ad-do-it))")

;; Replace completing-read wherever possible, unless directed otherwise
(defadvice completing-read
  (around use-ido-when-possible activate)
  (if (or (not ido-enable-replace-completing-read) ; Manual override disable ido
          (and (boundp 'ido-cur-list)
               ido-cur-list)) ; Avoid infinite loop from ido calling this
      ad-do-it
    (let ((allcomp (all-completions "" collection predicate)))
      (if allcomp
          (setq ad-return-value
                (ido-completing-read prompt
                                     allcomp
                                     nil require-match initial-input hist def))
        ad-do-it))))


;; DISABLE IDO IN SEVERAL MODES

;; (add-hook 'ediff-hook
;;           '(lambda ()
;;              (set (make-local-variable 'ido-enable-replace-completing-read) nil)))

;; (add-hook 'dired-mode-hook
;;           '(lambda ()
;;              (set (make-local-variable 'ido-enable-replace-completing-read) nil)))


;; SORT IDO FILELIST BY MTIME INSTEAD OF ALPHABETICALLY
;; (add-hook 'ido-make-file-list-hook 'ido-sort-mtime)
;; (add-hook 'ido-make-dir-list-hook 'ido-sort-mtime)


(defun ido-sort-mtime ()
  (setq ido-temp-list
        (sort ido-temp-list
              (lambda (a b)
                (let ((a-tramp-file-p (string-match-p ":\\'" a))
                      (b-tramp-file-p (string-match-p ":\\'" b)))
                  (cond
                   ((and a-tramp-file-p b-tramp-file-p)
                    (string< a b))
                   (a-tramp-file-p nil)
                   (b-tramp-file-p t)
                   (t (time-less-p
                       (sixth (file-attributes (concat ido-current-directory b)))
                       (sixth (file-attributes (concat ido-current-directory a))))))))))

  (ido-to-end  ;; move . files to end (again)
   (delq nil (mapcar
              (lambda (x) (and (char-equal (string-to-char x) ?.) x))
              ido-temp-list))))

;; enable flex matching
(setq ido-enable-flex-matching t)

;; (add-hook 'ido-setup-hook
;;           (lambda ()
;;             (define-key ido-completion-map [tab] 'ido-complete)))

;; IDO Everywhere
(ido-everywhere t)
(ido-ubiquitous-mode)
;; for find-file-at-point
;; (setq ido-use-filename-at-point 'guess)
;; look for URLs at point
;; (setq ido-use-url-at-point t)
;; stop asking me if I use a new name
(setq ido-create-new-buffer 'always)  ;'always, 'prompt or 'never

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++ EDIT FILES AS ROOT ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; ask for root password if file not writable
(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

;; find as root
(defun find-file-as-root ()
  "Like `ido-find-file, but automatically edit the file with
root-privileges (using tramp/sudo), if the file is not writable by
user."
  (interactive)
  (let ((file (ido-read-file-name "Edit as root: ")))
    (unless (file-writable-p file)
      (setq file (concat "/sudo:root@localhost:" file)))
    (find-file file)))
;; or some other keybinding...
(global-set-key (kbd "C-x F") 'find-file-as-root)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ido_config.el ends here
