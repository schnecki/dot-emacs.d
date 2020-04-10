;;; abs-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "abs-mode" "abs-mode.el" (0 0 0 0))
;;; Generated autoloads from abs-mode.el

(autoload 'abs-mode "abs-mode" "\
Major mode for editing Abs files.

The hooks `prog-mode-hook' and `c-mode-common-hook' are run at
mode initialization, then `abs-mode-hook'.

The following keys are set:
\\{abs-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.abs\\'" . abs-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "abs-mode" '("abs-" "inferior-maude-buffer")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; abs-mode-autoloads.el ends here
