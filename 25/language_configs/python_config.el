;;; python_config.el ---
;;
;; Filename: python_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Sun Oct 12 21:01:25 2014 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Fri Jul 23 13:48:44 2021 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 58
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
  (let* ((dir (loop as d = default-directory then (expand-file-name ".." d)
                    if (or (file-exists-p (expand-file-name ".venv" d))
                           (file-exists-p (expand-file-name "setup.py" d)))
                    return d))
         (esdir (replace-regexp-in-string " " "\\\\ " (concat dir "/"))))
    (shell-command
     (concat "cd " esdir " && find . -name \"*.py\" -not -name \".#*\" -not -name \"flycheck_*\" -not -path \"./venv/*\"  -not -path \"./.venv/*\"  -not -path \"./.eggs/*\"  -not -path \"./build/*\" -not -name \".*flycheck.*\" "
             "| etags - 1>/dev/null 2>/dev/null") nil)
    (visit-tags-table (concat esdir "TAGS"))))


(defun set-python-virtualenv ()
  "Set (or create) the virtualenv environment for pylint."
  (interactive)
  (let* ((dir (loop as d = default-directory then (expand-file-name ".." d)
                    if (or (file-exists-p (expand-file-name "venv" d))
                           (or (file-exists-p (expand-file-name ".venv" d))
                               (file-exists-p (expand-file-name "setup.py" d))))
                    return d))
         (esdir (replace-regexp-in-string " " "\\\\ " (concat dir "/")))
         (paths (split-string default-directory esdir))
         (vdir  (concat esdir (if (file-exists-p (concat esdir "/.venv")) ".venv" "venv")))
         (pylintdir (concat esdir "/" vdir "/bin/pylint"))
         (mypydir (concat esdir "/" vdir "/bin/mypy")))
    (message (concat "virtual env directory: " vdir))
    (if (and (file-exists-p vdir) (file-exists-p pylintdir))
        ((lambda () (interactive)
           (message "virtualenv found, setting pylint executable path of virtualenv!")
           (setq flycheck-python-pylint-executable (concat vdir "/bin/pylint")))))
    (if (and (file-exists-p vdir) (file-exists-p mypydir))
        ((lambda () (interactive)
           (message "virtualenv found, setting mypy executable path of virtualenv!")
           (setq flycheck-python-mypy-executable (concat vdir "/bin/mypy")))
         (shell-command (concat "virtualenv " vdir " && pip install mypy")))
      )))


;; C MODE
(defun my-python-mode-hook ()


  ;; ;; add auto-complete mode
  ;; (add-to-list 'ac-sources 'ac-source-semantic) ;; slows down auto complete)
  (add-to-list 'ac-sources 'ac-source-abbrev)
  ;; ;; (add-to-list 'ac-sources 'ac-source-css-property)
  ;; (add-to-list 'ac-sources 'ac-source-dictionary)
  ;; ;; (add-to-list 'ac-sources 'ac-source-eclim)
  (add-to-list 'ac-sources 'ac-source-yasnippet)
  ;; ;; (add-to-list 'ac-sources 'ac-source-c-headers)
  ;; ;; (add-to-list 'ac-sources 'ac-source-symbols)
  ;; ;; (add-to-list 'ac-sources 'ac-source-filename)
  ;; ;; (add-to-list 'ac-sources 'ac-source-files-in-current-dir)
  ;; ;; (add-to-list 'ac-sources 'ac-source-gtags)
  (add-to-list 'ac-sources 'ac-source-etags)
  (add-to-list 'ac-sources 'ac-source-imenu)


  ;; ;; (add-to-list 'ac-sources 'ac-source-semantic-raw) ;; slows down auto complete)
  ;; ;; (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  ;; ;; (add-to-list 'ac-sources 'ac-source-words-in-buffer)
  ;; ;; (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)


  ;; ;; enable semantic for auto complete mode
  ;; (semantic-mode t)

  ;; enable auto completion. If it doesn't work try to disable flyspell mode.
                                        ; (auto-complete-mode)
  (company-mode)

  ;; custom function to install and set virtualenv binaries
  (set-python-virtualenv)

  ;; use programming flyspell mode
  ;; (flyspell-prog-mode)
  (flyspell-mode-off)

  (add-hook 'after-save-hook 'make-python-tags nil t)

  (local-set-key (kbd "C-c C-l") 'python-shell-send-buffer)
  ;; (flymake-mode)
  )


(add-to-list 'process-coding-system-alist '("python" . (utf-8 . utf-8)))
(setq elpy-rpc-python-command "python3")

(require 'jupyter)
(require 'elpy)
(elpy-enable)
(when (load "flycheck" t t)
  ;; (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))


(setq flycheck-python-pycompile-executable "python3")
;; (add-to-list 'flycheck-disabled-checkers 'python-flake8)
(setq-default flycheck-disabled-checkers '(python-pylint))

;; add hook
(add-hook 'python-mode-hook 'my-python-mode-hook)
                                        ; (add-hook 'python-mode-hook 'flycheck-mode)

;; sort imports
;; (require 'py-isort)
;; (add-hook 'before-save-hook 'py-isort-before-save)

;; flymake
;; (require 'flymake)

;; (set-variable 'flymake-log-level 0)
;; (setq flymake-start-syntax-check-on-newline t)
;; (setq flymake-no-changes-timeout 5)
;; (add-hook 'python-mode-hook 'flymake-mode-on)
;; (add-to-list 'flymake-allowed-file-name-masks
;;              '("\\.py\\'" flymake-simple-make-init))


;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)                 ; optional

;; jedi for autocompletion, etc
;; (add-hook 'python-mode-hook 'jedi:setup)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; python_config.el ends here
