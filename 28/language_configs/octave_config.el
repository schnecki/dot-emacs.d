;;; octave_config.el ---
;;
;; Filename: octave_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Mi Mai 28 10:11:54 2014 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Tue Sep 16 09:48:44 2014 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 28
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


;; associate .m files with octave
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; Create and set tags table
(defun make-octave-tags ()
  "This function reloads the tags by using the command 'make tags'."
  (interactive)
  (let ((dir (nth 0 (split-string default-directory "src"))))
    (setq esdir (replace-regexp-in-string " " "\\\\ " dir))
    (shell-command
     (concat "cd " esdir " && find . -name '*.m' -not -name '.#*' -print | etags - 1>/dev/null 2>/dev/null") nil)
    (visit-tags-table (concat dir "TAGS"))
    (start-process "delete_abrt_checker" nil "rm" "-f abrt_checker_* 1>/dev/null 2>/dev/null")
    ;; (shell-command "rm -f abrt_checker_* 1>/dev/null 2>/dev/null" nil)
    )
  )

;; needed for octave mode hook
;; (require 'ac-octave)

;; MINOR MODE HOOK
(defun my/octave-minor-mode ()
  "Minor mode hook for Octave."

  ;; auto complete mode

  ;; (add-to-list 'ac-sources 'ac-source-abbrev)          ;; edited
  ;; (add-to-list 'ac-sources 'ac-source-css-property)
  ;; (add-to-list 'ac-sources 'ac-source-dictionary)
  ;; (add-to-list 'ac-sources 'ac-source-eclim)
  (add-to-list 'ac-sources 'ac-source-yasnippet)
  ;; (add-to-list 'ac-sources 'ac-source-symbols)
  ;; (add-to-list 'ac-sources 'ac-source-filename)
  ;; (add-to-list 'ac-sources 'ac-source-files-in-current-dir)
  ;; (add-to-list 'ac-sources 'ac-source-gtags)
  (add-to-list 'ac-sources 'ac-source-etags)
  ;; (add-to-list 'ac-sources 'ac-source-octave)
  ;; (add-to-list 'ac-sources 'ac-source-imenu)
  ;; (add-to-list 'ac-sources 'ac-source-semantic ;; slows down auto complete)
  ;; (add-to-list 'ac-sources 'ac-source-semantic-raw ;; slows down auto complete)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-buffer)
  (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)

  ;; auto complete (if it doesn't work try to disable flyspell mode!)
  (auto-complete-mode)
  (setq ac-delay 0.4)

  ;; use programming flyspell mode
  (flyspell-prog-mode)


  (local-set-key (kbd "C-c C-l") 'octave-send-defun)

  (setq c-basic-offset 2)

  ;; CREATE AND SET TAGS FILE
  (add-hook 'after-save-hook 'make-octave-tags nil t)
  )


(add-hook 'octave-mode-hook 'my/octave-minor-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; octave_config.el ends here
