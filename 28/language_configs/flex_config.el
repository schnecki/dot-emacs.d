;;; flex_config.el ---
;;
;; Filename: flex_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Mon Mar 28 15:44:07 2016 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Mon Mar 28 16:02:39 2016 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 10
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


;; load Flex mode
;; (load (concat package-folder "flex_mode.el"))


(require 'cc-mode);


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ Felx Configuration +++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; preferences
(c-set-offset 'substatement-open 0)
(c-set-offset 'case-label '+)
(c-set-offset 'arglist-cont-nonempty '+)
(c-set-offset 'arglist-intro '+)
(c-set-offset 'topmost-intro-cont '+)


;; (setq auto-mode-alist (cons '("\.l$" . flex-mode) auto-mode-alist)) ;; Flex files

;; (add-hook 'flex-mode-hook 'turn-on-eldoc-mode)

;; Create and set tags table
(defun make-flex-tags ()
  "This function reloads the tags by using the command 'make tags'."
  (interactive)
  (let ((dir (nth 0 (split-string default-directory "src"))))
    (setq esdir (replace-regexp-in-string " " "\\\\ " dir))
    (shell-command
     (concat "cd " esdir " && find . -name \"*.c\" -o -name \"*.h\" -o -name \"*.cpp\" -o -name \"*.hpp\" -o -name \"*.l\" | etags - 1>/dev/null 2>/dev/null") nil)
    (visit-tags-table (concat dir "TAGS"))))

(require 'auto-complete-config)
(require 'auto-complete-c-headers)
(require 'auto-complete)

;; C MODE
(defun my-flex-mode-hook ()


  ;; add auto-complete mode
  (add-to-list 'ac-sources 'ac-source-semantic) ;; slows down auto complete)
  (add-to-list 'ac-sources 'ac-source-abbrev)
  ;; (add-to-list 'ac-sources 'ac-source-css-property)
  ;; (add-to-list 'ac-sources 'ac-source-dictionary)
  ;; (add-to-list 'ac-sources 'ac-source-eclim)
  (add-to-list 'ac-sources 'ac-source-yasnippet)
  (add-to-list 'ac-sources 'ac-source-c-headers)
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


  ;; (setq ac-sources (append '(ac-source-semantic) ac-sources))

  ;; enable semantic for auto complete mode
  (semantic-mode t)

  ;; enable auto completion. If it doesn't work try to disable flyspell mode.
  (auto-complete-mode)

  ;; use programming flyspell mode
  (flyspell-prog-mode)

  ;; start auto completion after entering a dot: .
  (local-set-key (kbd ".") (lambda ()
                             (interactive)
                             (progn
                               (insert ".")
                               ;; (if (not (auto-complete-mode))
                               ;;     (auto-complete-mode t))
                               (auto-complete)
                               ;; (semantic-ia-complete-tip (point))
                               )))

  ;; start auto completion after entering >
  (local-set-key (kbd ">") (lambda ()
                             (interactive)
                             (progn
                               (insert ">")
                               ;; (if (not (auto-complete-mode))
                               ;;     (auto-complete-mode t))
                               (auto-complete)
                               ;; (semantic-ia-complete-tip (point))
                               )))

  (add-hook 'after-save-hook 'make-flex-tags nil t)

  )

;; add hook
;; (add-hook 'flex-mode-hook 'my-flex-mode-hook)
(add-hook 'bison-mode-hook 'my-flex-mode-hook)
;; (define-key 'c-mode-map (kbd "M-o")  'fa-show)


;;; flycheck
;; (add-hook 'flex-mode-hook (lambda () (setq flycheck-clang-language-standard "c99")))
(add-hook 'bison-mode-hook (lambda () (setq flycheck-clang-language-standard "c99")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; flex_config.el ends here
