;;; backup_each_save_config.el ---
;;
;; Filename: backup_each_save_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: So Okt 27 17:01:15 2013 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Di Jan 21 20:21:02 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 8
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


;; backup each save
;; (require 'backup-each-save)
;; (add-hook 'after-save-hook 'backup-each-save)

;; (defun backup-each-save-filter (filename)
;;   (let ((ignored-filenames
;;          '("^/tmp" "semantic.cache$" "\\.emacs-places$"
;;            "\\.recentf$" ".newsrc\\(\\.eld\\)?"))
;;         (matched-ignored-filename nil))
;;     (mapc
;;      (lambda (x)
;;        (when (string-match x filename)
;;          (setq matched-ignored-filename t)))
;;      ignored-filenames)
;;     (not matched-ignored-filename)))
;; (setq backup-each-save-filter-function 'backup-each-save-filter)

(add-hook 'before-save-hook 'force-backup-of-buffer)
(defun force-backup-of-buffer ()
  (setq buffer-backed-up nil))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; backup_each_save_config.el ends here
