;;; company-shell-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (or (and load-file-name (directory-file-name (file-name-directory load-file-name))) (car load-path)))



;;; Generated autoloads from company-shell.el

(autoload 'company-shell-rebuild-cache "company-shell" "\
Builds the cache of all completions found on the $PATH and all fish functions." t)
(autoload 'company-fish-shell "company-shell" "\
Company backend for fish shell functions.

(fn COMMAND &optional ARG &rest IGNORED)" t)
(autoload 'company-shell "company-shell" "\
Company mode backend for binaries found on the $PATH.

(fn COMMAND &optional ARG &rest IGNORED)" t)
(autoload 'company-shell-env "company-shell" "\
Company backend for environment variables.

(fn COMMAND &optional ARG &rest IGNORED)" t)
(register-definition-prefixes "company-shell" '("company-"))

;;; End of scraped data

(provide 'company-shell-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; company-shell-autoloads.el ends here