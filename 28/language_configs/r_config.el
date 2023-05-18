;;; Code:

(when (memq system-type '(windows-nt ms-dos))
  (setq-default inferior-R-program-name
                "c:/Users/M.SCHNECKENREITHER/AppData/Local/Programs/R/R-4.2.2/bin/x64/Rterm.exe"))
;; (setenv "PATH" (concat "C:\\Program Files\\R\\R-2.15.1\\bin\\x64" ";"
;;     (getenv "PATH")))

(require 'ess-site)

(defun my/ess-minor-mode ()
  "Minor mode hook for ESS."
  (local-set-key [f1] 'ess-display-help-on-object))


(add-hook 'ess-mode-hook 'my/ess-minor-mode)
