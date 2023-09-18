;;; languagetool-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "languagetool" "languagetool.el" (0 0 0 0))
;;; Generated autoloads from languagetool.el

(autoload 'languagetool-set-language "languagetool" "\
Set LanguageTool correction language to LANG.

\(fn LANG)" t nil)

(autoload 'languagetool-clear-suggestions "languagetool" "\
Clear all the buffer suggestions.

If `languagetool-server-mode' is active, it would rise an error,
as you are not suppose to call this function." t nil)

(autoload 'languagetool-check "languagetool" "\
Correct the current buffer and highlight errors.

If region is selected before calling this function, that would be
the region passed as an argument. The region is delimited by
BEGIN and END.

If `languagetool-server-mode' is active, send a request to the
server and ends. The parameters BEGIN and END did not make any
difference, as in this mode, the whole buffer needs to be
checked.

\(fn BEGIN END)" t nil)

(autoload 'languagetool-correct-at-point "languagetool" "\
Pops up transient buffer to do correction at point." t nil)

(autoload 'languagetool-correct-buffer "languagetool" "\
Pops up transient buffer to do correction in the whole buffer." t nil)

;;;***

;;;### (autoloads nil "languagetool-console" "languagetool-console.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from languagetool-console.el

(register-definition-prefixes "languagetool-console" '("languagetool-console-"))

;;;***

;;;### (autoloads nil "languagetool-core" "languagetool-core.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from languagetool-core.el

(register-definition-prefixes "languagetool-core" '("languagetool-"))

;;;***

;;;### (autoloads nil "languagetool-correction" "languagetool-correction.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from languagetool-correction.el

(register-definition-prefixes "languagetool-correction" '("languagetool-correction-"))

;;;***

;;;### (autoloads nil "languagetool-issue" "languagetool-issue.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from languagetool-issue.el

(register-definition-prefixes "languagetool-issue" '("languagetool-issue-"))

;;;***

;;;### (autoloads nil "languagetool-java" "languagetool-java.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from languagetool-java.el

(register-definition-prefixes "languagetool-java" '("languagetool-java-"))

;;;***

;;;### (autoloads nil "languagetool-server" "languagetool-server.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from languagetool-server.el

(autoload 'languagetool-server-mode "languagetool-server" "\
Toggle LanguageTool issue highlighting.

This is a minor mode.  If called interactively, toggle the
`Languagetool-Server mode' mode.  If the prefix argument is
positive, enable the mode, and if it is zero or negative, disable
the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `languagetool-server-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(autoload 'languagetool-server-start "languagetool-server" "\
Start the LanguageTool Server.

It's not recommended to run this function more than once." t nil)

(autoload 'languagetool-server-stop "languagetool-server" "\
Stops the LanguageTool Server." t nil)

(register-definition-prefixes "languagetool-server" '("languagetool-server-"))

;;;***

;;;### (autoloads nil nil ("languagetool-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; languagetool-autoloads.el ends here
