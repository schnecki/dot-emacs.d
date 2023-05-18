;;; python_config.el ---
;;
;; Filename: python_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Sun Oct 12 21:01:25 2014 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Wed Oct 22 13:53:20 2014 (+0200)
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
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


;; Create and set tags table
(defun make-python-tags ()
  "This function reloads the tags by using the command 'make tags'."
  (interactive)
  (let ((dir (nth 0 (split-string default-directory "src"))))
    (setq esdir (replace-regexp-in-string " " "\\\\ " dir))
    (shell-command
     (concat "cd " esdir " && find . -name \"*.py\" -not -name \".#*\" "
             "| etags - 1>/dev/null 2>/dev/null") nil)
    (visit-tags-table (concat dir "TAGS"))))


;; C MODE
(defun my-python-mode-hook ()


  ;; add auto-complete mode
  (add-to-list 'ac-sources 'ac-source-semantic) ;; slows down auto complete)
  (add-to-list 'ac-sources 'ac-source-abbrev)
  ;; (add-to-list 'ac-sources 'ac-source-css-property)
  (add-to-list 'ac-sources 'ac-source-dictionary)
  ;; (add-to-list 'ac-sources 'ac-source-eclim)
  (add-to-list 'ac-sources 'ac-source-yasnippet)
  ;; (add-to-list 'ac-sources 'ac-source-c-headers)
  ;; (add-to-list 'ac-sources 'ac-source-symbols)
  ;; (add-to-list 'ac-sources 'ac-source-filename)
  ;; (add-to-list 'ac-sources 'ac-source-files-in-current-dir)
  ;; (add-to-list 'ac-sources 'ac-source-gtags)
  (add-to-list 'ac-sources 'ac-source-etags)
  (add-to-list 'ac-sources 'ac-source-imenu)


  ;; (add-to-list 'ac-sources 'ac-source-semantic-raw) ;; slows down auto complete)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-buffer)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)


  ;; enable semantic for auto complete mode
  (semantic-mode t)

  ;; enable auto completion. If it doesn't work try to disable flyspell mode.
  (auto-complete-mode)

  ;; use programming flyspell mode
  (flyspell-prog-mode)

  (add-hook 'after-save-hook 'make-python-tags nil t)

  (local-set-key (kbd "C-c C-l") 'python-shell-send-buffer)
  )

;; add hook
(add-hook 'python-mode-hook 'my-python-mode-hook)

;; jedi for autocompletion, etc
(add-hook 'python-mode-hook 'jedi:setup)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; python_config.el ends here
