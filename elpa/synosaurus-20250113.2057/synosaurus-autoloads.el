;;; synosaurus-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (or (and load-file-name (directory-file-name (file-name-directory load-file-name))) (car load-path)))



;;; Generated autoloads from synosaurus.el

(autoload 'synosaurus-lookup "synosaurus" "\
Lookup `WORD' in the thesaurus.

Queries the user for a word and looks it up in a thesaurus using
`synosaurus-backend'.

The resulting synonym list will be shown in a new buffer, where
the words are clickable to look them up instead of the original
word.

(fn WORD)" t)
(autoload 'synosaurus-choose-and-replace "synosaurus" "\
Replace the word under the cursor by a synonym.

Look up the word in the thesaurus specified by
`synosaurus-backend', let the user choose an alternative
and replace the original word with that.

If the region is active, replace the region instead of the word
at point." t)
(autoload 'synosaurus-choose-and-insert "synosaurus" "\
Look up `WORD' in the thesaurus, choose a synonym for `WORD',
and insert it into the current buffer.

(fn WORD)" t)
(autoload 'synosaurus-mode "synosaurus" "\
Minor mode for thesaurus lookups.

When called interactively, toggle `synosaurus-mode'. With prefix
ARG, enable `synosaurus-mode' if ARG is positive, otherwise
disable it.

When called from Lisp, enable `synosaurus-mode', if ARG is
omitted, nil or positive. If ARG is `toggle', toggle
`synosaurus-mode'. Otherwise behave as if called interactively.

The thesaurus backend can be configured with
`synosaurus-backend'.

\\{synosaurus-mode-map}

(fn &optional ARG)" t)
(register-definition-prefixes "synosaurus" '("synosaurus-"))


;;; Generated autoloads from synosaurus-openthesaurus.el

(autoload 'synosaurus-backend-openthesaurus "synosaurus-openthesaurus" "\


(fn WORD)")
(register-definition-prefixes "synosaurus-openthesaurus" '("synosaurus-openthesaurus--"))


;;; Generated autoloads from synosaurus-wordnet.el

(autoload 'synosaurus-backend-wordnet "synosaurus-wordnet" "\


(fn WORD)")
(register-definition-prefixes "synosaurus-wordnet" '("synosaurus-wordnet--"))

;;; End of scraped data

(provide 'synosaurus-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; synosaurus-autoloads.el ends here
