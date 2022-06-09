;;; pine-script-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "pine-script-mode" "pine-script-mode.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from pine-script-mode.el

(autoload 'pine-script-mode "pine-script-mode" "\
A major mode for editing Trading View Pine scripts.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.pine\\'" . pine-script-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "pine-script-mode" '("pine-script-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; pine-script-mode-autoloads.el ends here
