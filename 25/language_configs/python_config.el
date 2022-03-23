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


(defun set-pylint-virutalenv ()
  "Set (or create) the virtualenv environment for pylint."
  (interactive)
  (let* ((dir (loop as d = default-directory then (expand-file-name ".." d)
                    if (or (file-exists-p (expand-file-name "venv" d))
                           (or (file-exists-p (expand-file-name ".venv" d))
                               (file-exists-p (expand-file-name "setup.py" d))))
                    return d))
         (esdir (replace-regexp-in-string " " "\\\\ " (concat dir "/")))
         (paths (split-string default-directory esdir))
         (vdir  (if (file-exists-p (concat esdir "/.venv")) ".venv" "venv")))
    (if (file-exists-p (concat esdir vdir))
        ((lambda () (interactive)
           (message "virtualenv found, setting pylint executable path of virtualenv!")
           (setq flycheck-python-pylint-executable (concat esdir "/" vdir "/bin/pylint"))))
      (shell-command (concat "cd " esdir " && virtualenv " vdir " && pip install pylint"))
      (set-pylint-virutalenv))))


;; C MODE
(defun my-python-mode-hook ()


  ;; ;; add auto-complete mode
  ;; (add-to-list 'ac-sources 'ac-source-semantic) ;; slows down auto complete)
  ;; (add-to-list 'ac-sources 'ac-source-abbrev)
  ;; ;; (add-to-list 'ac-sources 'ac-source-css-property)
  ;; (add-to-list 'ac-sources 'ac-source-dictionary)
  ;; ;; (add-to-list 'ac-sources 'ac-source-eclim)
  ;; (add-to-list 'ac-sources 'ac-source-yasnippet)
  ;; ;; (add-to-list 'ac-sources 'ac-source-c-headers)
  ;; ;; (add-to-list 'ac-sources 'ac-source-symbols)
  ;; ;; (add-to-list 'ac-sources 'ac-source-filename)
  ;; ;; (add-to-list 'ac-sources 'ac-source-files-in-current-dir)
  ;; ;; (add-to-list 'ac-sources 'ac-source-gtags)
  ;; (add-to-list 'ac-sources 'ac-source-etags)
  ;; (add-to-list 'ac-sources 'ac-source-imenu)


  ;; ;; (add-to-list 'ac-sources 'ac-source-semantic-raw) ;; slows down auto complete)
  ;; ;; (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  ;; ;; (add-to-list 'ac-sources 'ac-source-words-in-buffer)
  ;; ;; (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)


  ;; ;; enable semantic for auto complete mode
  ;; (semantic-mode t)

  ;; enable auto completion. If it doesn't work try to disable flyspell mode.
  ; (auto-complete-mode)
  (company-mode)

  (set-pylint-virutalenv)

  ;; use programming flyspell mode
  ;; (flyspell-prog-mode)

  (add-hook 'after-save-hook 'make-python-tags nil t)

  (local-set-key (kbd "C-c C-l") 'python-shell-send-buffer)
  )


(setq flycheck-python-pycompile-executable "python3")
;; (add-to-list 'flycheck-disabled-checkers 'python-flake8)
(setq-default flycheck-disabled-checkers '(python-pylint))

;; add hook
(add-hook 'python-mode-hook 'my-python-mode-hook)
; (add-hook 'python-mode-hook 'flycheck-mode)

;; sort imports
(require 'py-isort)
(add-hook 'before-save-hook 'py-isort-before-save)


;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)                 ; optional

;; jedi for autocompletion, etc
;; (add-hook 'python-mode-hook 'jedi:setup)


;; (defun set-flychecker-executables ()
;;   "Configure virtualenv for flake8 and lint."
;;   (when (get-current-buffer-flake8)
;;     (flycheck-set-checker-executable (quote python-flake8)
;;                                      (get-current-buffer-flake8)))
;;   (when (get-current-buffer-pylint)
;;     (flycheck-set-checker-executable (quote python-pylint)
;;                                      (get-current-buffer-pylint))))
;; (add-hook 'flycheck-before-syntax-check-hook
;;           #'set-flychecker-executables 'local)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; python_config.el ends here
