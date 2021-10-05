;;; package -- haskell_config.el ---
;;; Commentary:
;;
;; Filename: haskell_config.el
;; Status:
;; Author: Manuel Schneckenreither
;; Created: Mo Sep  2 22:31:57 2013 (+0200)
;; Version:
;; Last-Updated:
;;           By:
;;     Update #: 1029
;; URL:
;; Description:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


(require 'haskell-mode)
(require 'haskell-interactive-mode)
(require 'haskell-process)
(require 'hindent)

;; (add-hook 'haskell-mode-hook 'haskell-indentation-mode)

(eval-after-load 'haskell-mode (load-library "haskell-mode"))
;; (add-hook 'haskell-mode-hook #'hindent-mode)

(custom-set-variables
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t))


;; (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
;; (define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
;; (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
;; (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
;; (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
;; (define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
;; (define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
(define-key haskell-mode-map (kbd "C-c h h") 'haskell-hoogle)
(define-key haskell-mode-map (kbd "C-.") nil)
(define-key haskell-mode-map (kbd "M-.") nil)

(custom-set-variables '(haskell-process-suggest-remove-import-lines t))
(custom-set-variables '(haskell-process-suggest-hoogle-imports t))
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)


;; ;; Create and set tags table
(defun make-haskell-tags ()
  "This function reloads the tags by using the command 'make tags'."
  (interactive)
  (let ((dir (nth 0 (if (string-match "app/" default-directory)
                        (split-string default-directory "app")
                      (if (string-match "src/" default-directory)
                          (split-string default-directory "src")
                        (if (string-match "shared/" default-directory)
                            (split-string default-directory "shared")
                          (if (string-match "exp/" default-directory)
                              (split-string default-directory "exp")
                            (if (string-match "fay/" default-directory)
                                (split-string default-directory "fay")
                              (if (string-match "fay-shared/" default-directory)
                                  (split-string default-directory "fay-shared")
                              (if (string-match "cbits/" default-directory)
                                  (split-string default-directory "cbits")
                                (if (string-match "examples/" default-directory)
                                    (split-string default-directory "examples/")
                                  (if (string-match "bench/" default-directory)
                                      (split-string default-directory "bench/")
                                    (split-string default-directory "test"))
                                  )))))))))))
    (setq esdir (replace-regexp-in-string " " "\\\\ " dir))
    ;; (message esdir)
    (setq tagslst '()) ;; '("."))
    (if (file-exists-p (concat esdir "src")) (add-to-list 'tagslst "src"))
    (if (file-exists-p (concat esdir "shared")) (add-to-list 'tagslst "shared"))
    (if (file-exists-p (concat esdir "test")) (add-to-list 'tagslst "test"))
    (if (file-exists-p (concat esdir "app")) (add-to-list 'tagslst "app"))
    (if (file-exists-p (concat esdir "exp")) (add-to-list 'tagslst "exp"))
    (if (file-exists-p (concat esdir "examples")) (add-to-list 'tagslst "examples"))
    (if (file-exists-p (concat esdir "fay")) (add-to-list 'tagslst "fay"))
    (if (file-exists-p (concat esdir "fay_shared")) (add-to-list 'tagslst "fay_shared"))
    (setq dirs (mapconcat 'identity tagslst " "))
    (message (concat "dirs: " dirs))
    (shell-command
     (concat "cd " esdir
             ;; " && hasktags --ignore-close-implementation -e --cache . 2>/dev/null 1>/dev/null") nil)
             ;; " && hasktags -e --ignore-close-implementation "
             " && hasktags -e "
             dirs
             ;; " 2>/dev/null 1>/dev/null"
             ) nil)
    (visit-tags-table (concat dir "TAGS")))
  )

(add-hook 'haskell-mode-hook 'haskell-doc-mode) ; Echoes types of functions or
                                        ; syntax of keywords when the
                                        ; cursor is idle.

(custom-set-variables '(haskell-stylish-on-save t))


;; ;; MINOR MODE HOOK
(defun my/haskell-minor-mode ()
  "Minor mode hook for Haskell."

  ;; (auto-complete-mode)
  (set (make-local-variable 'whitespace-style) nil)
  (set-fill-column 200)

  ;; (local-set-key (kbd "C-j")  'haskell-newline)
  (local-set-key (kbd "RET")  'newline-and-indent)

  (local-set-key (kbd "C-c C-u") (defun insertUndefined ()
                                   (interactive)
                                   (insert "undefined")))

  ;; CREATE AND SET TAGS FILE
  (add-hook 'after-save-hook 'make-haskell-tags nil t)
  ;; (hare-init)
  ;; (flyspell-pr-mode nil)
  (flyspell-prog-mode nil)
  (hindent-mode)
  (define-key haskell-mode-map (kbd "C-c h h") 'haskell-hoogle)
  (define-key haskell-mode-map (kbd "C-.") nil)
  (define-key interactive-haskell-mode-map (kbd "M-.") nil)

  )


(add-hook 'haskell-mode-hook 'my/haskell-minor-mode)


;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; +++++++++++++++++++++++++++++++ Hlint ++++++++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; (flycheck-add-next-checker 'intero
;;                            '(warning . haskell-hlint))

;; (require 'hlint-refactor)
;; (add-hook 'haskell-mode-hook 'hlint-refactor-mode)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; haskell_config.el ends here
