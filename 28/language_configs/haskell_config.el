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
;;     Update #: 879
;; URL:
;; Description:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(require 'intero)
(require 'haskell-mode)
;; (require 'haskell-indent)


;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; +++++++++++++++++++++++++++ HASKELL CONFIGS ++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; ;; (eval-after-load "which-func"
;; ;;   '(add-to-list 'which-func-modes 'haskell-mode))

;; ;; (autoload 'haskell-refac-mode "haskell-refac"
;; ;;   "Minor mode for refactoring Haskell programs" t)
;; ;; (add-hook 'haskell-mode-hook 'turn-on-font-lock)
;; ;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;; ;; (remove-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
;; ;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; ;; (add-hook 'haskell-mode-hook 'haskell-refac-mode)
;; ;; (add-hook 'haskell-mode-hook 'hs-lint-mode-hook)

;; ;; set DEBUG constant in haskell interpreter
;; ;; (setq haskell-program-name "ghci -DDEBUG ")
;; ;; (haskell-process-type (quote cabal-repl))

(add-hook 'haskell-mode-hook 'intero-mode)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
;; (add-hook 'haskell-mode-hook 'interactive-haskell-mode)


;; (setq haskell-process-type 'stack-ghci)
;; (setq haskell-process-path-ghci "stack")
;; (setq haskell-process-args-ghci "ghci")


;; ;; (setq haskell-program-name "stack ghci -DDEBUG")
;; ;; (setq haskell-process-args-cabal-repl
;; ;;       '("-ferror-spans"
;; ;;         "-cpp"                          ; enable cpp processing
;; ;;         "-DDEBUG"
;; ;;         "-pgmF loch"
;; ;;         "-fbreak-on-error"
;; ;;         "-fllvm"
;; ;;         "-fasm"

;; ;;         ;; "-fdefer-type-errors" ;;  Defer as many type errors as possible until runtime.
;; ;;         "-fhelpful-errors" ;; Make suggestions for mis-spelled names.
;; ;;         ;; "-fwarn-deprecated-flags" ;;  warn about uses of commandline flags that are deprecated
;; ;;         "-fwarn-duplicate-constraints" ;; warn when a constraint appears duplicated in a type signature
;; ;;         "-fwarn-duplicate-exports" ;; warn when an entity is exported multiple times
;; ;;         "-fwarn-hi-shadowing" ;;  warn when a .hi file in the current directory shadows a library
;; ;;         "-fwarn-identities" ;;  warn about uses of Prelude numeric conversions that are probably the identity (and hence could be omitted)
;; ;;         ;; "-fwarn-implicit-prelude" ;;  warn when the Prelude is implicitly imported
;; ;;         "-fwarn-incomplete-patterns" ;; warn when a pattern match could fail
;; ;;         "-fwarn-incomplete-uni-patterns" ;; warn when a pattern match in a lambda expression or pattern binding could fail
;; ;;         "-fwarn-incomplete-record-updates" ;; warn when a record update could fail
;; ;;         ;; "-fwarn-lazy-unlifted-bindings" ;;  (deprecated) warn when a pattern binding looks lazy but must be strict
;; ;;         "-fwarn-missing-fields" ;;  warn when fields of a record are uninitialised
;; ;;         ;; "-fwarn-missing-import-lists" ;;  warn when an import declaration does not explicitly list all the names brought into scope
;; ;;         "-fwarn-missing-methods" ;; warn when class methods are undefined
;; ;;         ;; "-fwarn-missing-signatures" ;;  warn about top-level functions without signatures
;; ;;         ;; "-fwarn-missing-local-sigs" ;;  warn about polymorphic local bindings without signatures
;; ;;         ;; "-fwarn-monomorphism-restriction" ;;  warn when the Monomorphism Restriction is applied
;; ;;         ;; "-fwarn-name-shadowing" ;;  warn when names are shadowed
;; ;;         ;; "-fwarn-orphans" ;; -fwarn-auto-orphans  warn when the module contains orphan instance declarations or rewrite rules
;; ;;         "-fwarn-overlapping-patterns" ;;  warn about overlapping patterns
;; ;;         "-fwarn-tabs" ;;  warn if there are tabs in the source file
;; ;;         "-fwarn-type-defaults" ;; warn when defaulting happens
;; ;;         "-fwarn-unrecognised-pragmas" ;;  warn about uses of pragmas that GHC doesn't recognise
;; ;;         ;; "-fwarn-unused-binds" ;;  warn about bindings that are unused
;; ;;         ;; "-fwarn-unused-imports" ;;  warn about unnecessary imports
;; ;;         ;; "-fwarn-unused-matches" ;;  warn about variables in patterns that aren't used
;; ;;         ;; "-fwarn-unused-do-bind" ;;  warn about do bindings that appear to throw away values of types other than ()
;; ;;         "-fwarn-wrong-do-bind" ;; warn about do bindings that appear to throw away monadic values that you should have bound instead
;; ;;         "-fwarn-unsafe" ;;  warn if the module being compiled is regarded to be unsafe. Should be used to check the safety status of modules when using safe inference.
;; ;;         ;; "-fwarn-safe" ;;  warn if the module being compiled is regarded to be safe. Should be used to check the safety status of modules when using safe inference.
;; ;;         "-fwarn-warnings-deprecations" ;; warn about uses of functions & types that have warnings or deprecated pragmas
;; ;;         "-fwarn-amp" ;; warn on definitions conflicting with the Applicative-Monad Proposal (AMP)
;; ;;         "-fwarn-typed-holes" ;; Enable holes in expressions.
;; ;;         ))


;; (require 'speedbar)
;; (speedbar-add-supported-extension ".hs")

;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++++++++ HADDOCK ++++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; ;; (require 'w3m-haddock)
;; ;; (add-hook 'w3m-display-hook 'w3m-haddock-display)

;; ;; (define-key haskell-mode-map (kbd "C-c C-d") 'haskell-w3m-open-haddock)

;; ;; (setq w3m-mode-map (make-sparse-keymap))

;; ;; (define-key w3m-mode-map (kbd "RET") 'w3m-view-this-url)
;; ;; (define-key w3m-mode-map (kbd "q") 'bury-buffer)
;; ;; (define-key w3m-mode-map (kbd "<mouse-1>") 'w3m-maybe-url)
;; ;; (define-key w3m-mode-map [f5] 'w3m-reload-this-page)
;; ;; (define-key w3m-mode-map (kbd "C-c C-d") 'haskell-w3m-open-haddock)
;; ;; (define-key w3m-mode-map (kbd "M-<left>") 'w3m-view-previous-page)
;; ;; (define-key w3m-mode-map (kbd "M-<right>") 'w3m-view-next-page)
;; ;; (define-key w3m-mode-map (kbd "M-.") 'w3m-haddock-find-tag)

;; ;; (defun w3m-maybe-url ()
;; ;;   (interactive)
;; ;;   (if (or (equal '(w3m-anchor) (get-text-property (point) 'face))
;; ;;           (equal '(w3m-arrived-anchor) (get-text-property (point) 'face)))
;; ;;       (w3m-view-this-url)))

;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++++++++ OTHER FEATURES ++++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(add-to-list 'load-path "~/.emacs.d/24/packages/hare")
(require 'hare)
(autoload 'hare-init "hare" nil t)

;; ;;(eval-after-load "haskell-mode"
;; ;;  (define-key haskell-mode-map (kbd "C-c v c") 'haskell-cabal-visit-file))


;; ;;(eval-after-load "haskell-mode"
;; ;;    '(define-key haskell-mode-map (kbd "C-x SPC") 'haskell-compile))

;; ;;(eval-after-load "haskell-cabal"
;; ;;    '(define-key haskell-cabal-mode-map (kbd "C-x SPC") 'haskell-compile))

;; ;; (add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)

;; (defadvice haskell-mode-stylish-buffer (around skip-if-flycheck-errors activate)
;;   (unless (flycheck-has-current-errors-p 'error)
;;     ad-do-it))
;; (setq haskell-stylish-on-save t)

;; ;; hindent
;; ;; (require 'hindent)
;; ;; (add-hook 'haskell-mode-hook #'hindent-mode)

;; ;; (eval-after-load "haskell-mode"
;; ;;   '(progn
;; ;;      (define-key haskell-mode-map (kbd "C-,") 'haskell-move-nested-left)
;; ;;      (define-key haskell-mode-map (kbd "C-.") 'haskell-move-nested-right)))

;; ;; let align know about haskell prefs
;; (eval-after-load "align"
;;   '(add-to-list 'align-rules-list
;;                 '(haskell-types
;;                    (regexp . "\\(\\s-+\\)\\(::\\|∷\\)\\s-+")
;;                    (modes quote (haskell-mode literate-haskell-mode interactive-haskell-mode)))))
;; (eval-after-load "align"
;;   '(add-to-list 'align-rules-list
;;                 '(haskell-assignment
;;                   (regexp . "\\(\\s-+\\)=\\s-+")
;;                   (modes quote (haskell-mode literate-haskell-mode interactive-haskell-mode)))))
;; (eval-after-load "align"
;;   '(add-to-list 'align-rules-list
;;                 '(haskell-arrows
;;                   (regexp . "\\(\\s-+\\)\\(->\\|→\\)\\s-+")
;;                   (modes quote (haskell-mode literate-haskell-mode interactive-haskell-mode)))))
;; (eval-after-load "align"
;;   '(add-to-list 'align-rules-list
;;                 '(haskell-left-arrows
;;                   (regexp . "\\(\\s-+\\)\\(<-\\|←\\)\\s-+")
;;                   (modes quote (haskell-mode literate-haskell-mode interactive-haskell-mode)))))

;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; +++++++++++++++++++++++++++ FLYCHECK MODE ++++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; ;; (eval-after-load 'flycheck '(require 'flycheck-hdevtools))

;; ;; (defun delete-hdevtools-socket-file ()
;; ;;   "Delete the socket file for hdevtools."
;; ;;   (interactive)
;; ;;   (shell-command "rm -f .hdevtools.sock" nil)
;; ;;   )

;; ;; (add-hook 'open-file 'delete-hdevtools-socket-file)

;; ;; (eval-after-load 'flycheck
;; ;;   '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))

;; ;; enable flycheck
;; (setq flycheck-ghc-args '("-DDEBUG"
;;                           "-DFLYCHECK"
;;                           ))


;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; +++++++++++++++++++++++++++++ MINOR MODE +++++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; Create and set tags table
(defun make-haskell-tags ()
  "This function reloads the tags by using the command 'make tags'."
  (interactive)
  (let ((dir (nth 0 (if (string-match "app/" default-directory)
                        (split-string default-directory "app")
                      (split-string default-directory "src")))))
    (setq esdir (replace-regexp-in-string " " "\\\\ " dir))
    (shell-command
     (concat "cd " esdir
             " && hasktags -e . 2>/dev/null 1>/dev/null") nil)
    (visit-tags-table (concat dir "TAGS")))
  )


(defun haskell-source-code-align()
  "Format souce code nicely."
  (interactive)
  (save-excursion
    (push-mark (point))
    (push-mark (point-max) nil t)
    (goto-char (point-min))
    (haskell-indent-align-def t 'guard)
    (haskell-indent-align-def t 'rhs)
    )
   (haskell-mode-format-imports)
  )


;; need to declare these two function
;; they do not seem to be imported with s
(defun s--truthy? (val)
  (not (null val)))
(defun s-contains? (needle s &optional ignore-case)
  "Does S contain NEEDLE?
If IGNORE-CASE is non-nil, the comparison is done without paying
attention to case differences."
  (let ((case-fold-search ignore-case))
    (s--truthy? (string-match-p (regexp-quote needle) s))))

(defun haskell-insert-equals ()
  "Insert and aligns equals sign."
  (interactive)

  (if (not (s-contains? (char-to-string (char-before (point))) "=/><(|" ))
      (progn
        (haskell-indent-insert-equal)
        (delete-backward-char 1 nil))
    ;; (if (s-contains? (char-to-string (char-before (- (point) 1))) " " )
    ;;     (delete-backward-char 1 nil))
    (insert "=")
    )
  )

(defun haskell-insert-guard ()
  "Insert and aligns guard sign."
  (interactive)

  (if (not (s-contains? (char-to-string (char-before (point))) "|><=()" ))
      (progn
        (haskell-indent-insert-guard)
        (delete-backward-char 1 nil))
    ;; (if (s-contains? (char-to-string (char-before (- (point) 1))) " " )
    ;;     (delete-backward-char 1 nil))
    (insert "|")
    ))


(defun haskell-newline ()
  "Enter for haskell with ; at beginning."
  (interactive)
  (newline-and-indent)
  (insert "; ")
  )


;; MINOR MODE HOOK
(defun my/haskell-minor-mode ()
  "Minor mode hook for Haskell."

  ;; add auto-complete mode
  (add-to-list 'ac-sources 'ac-source-abbrev)          ;; edited
  ;; (add-to-list 'ac-sources 'ac-source-css-property)
  (add-to-list 'ac-sources 'ac-source-dictionary)
  ;; (add-to-list 'ac-sources 'ac-source-eclim)
  (add-to-list 'ac-sources 'ac-source-yasnippet)
  ;; (add-to-list 'ac-sources 'ac-source-symbols)
  ;; (add-to-list 'ac-sources 'ac-source-filename)
  ;; (add-to-list 'ac-sources 'ac-source-files-in-current-dir)
  ;; (add-to-list 'ac-sources 'ac-source-gtags)
  (add-to-list 'ac-sources 'ac-source-etags)
  (add-to-list 'ac-sources 'ac-source-imenu) ;; broken !!!
  ;; (add-to-list 'ac-sources 'ac-source-semantic) ;; slows down auto complete)
  ;; (add-to-list 'ac-sources 'ac-source-semantic-raw ;; slows down auto complete)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  (add-to-list 'ac-sources 'ac-source-words-in-buffer)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)

  ;; (auto-complete-mode)

  ;; format source code in sensible way
  ;; (add-hook 'before-save-hook 'haskell-source-code-align nil t)

  ;; KEYS
  ;; fix return behavior
  ;; (define-key 'haskell-mode-map (kbd "C .") 'find-tag)
  ;; (define-key interactive-haskell-mode-map (kbd "C-c c") nil)

  ;; (Local-set-key (kbd "C-j")  'haskell-newline)
  (local-set-key (kbd "RET")  'newline-and-indent)

  ;; Disabled set special keys
  ;; (local-set-key (kbd "=")  'haskell-insert-equals)
  ;; (local-set-key (kbd "|") 'haskell-insert-guard)

  (local-set-key (kbd "C-c =") (defun insertEquals ()
                                 (interactive)
                                 (insert "=")))

  (local-set-key (kbd "C-c )") (defun insertClosingPar ()
                                 (interactive)
                                 (insert ")")))
  (local-set-key (kbd "C-c }") (defun insertClosingCur ()
                                 (interactive)
                                 (insert "}")))
  (local-set-key (kbd "C-c ]") (defun insertClosingBra ()
                                 (interactive)
                                 (insert "]")))

  (local-set-key (kbd "C-c C-u") (defun insertUndefined ()
                                 (interactive)
                                 (insert "undefined")))

  ;; (local-set-key (kbd "C-c |") (defun insertGuard ()
  ;;                                (interactive)
  ;;                                (insert "|")))

  (define-key intero-mode-map (kbd "M-.") nil)


  (define-key intero-mode-map (kbd "C-c i") 'intero-goto-definition)
  (define-key intero-mode-map (kbd "C-c C-b") 'intero-repl)

  (define-key haskell-mode-map (kbd "C-c h h") 'haskell-hoogle)

  ;; CREATE AND SET TAGS FILE
  (add-hook 'after-save-hook 'make-haskell-tags nil t)
  ;; (hare-init)
  )


(add-hook 'haskell-mode-hook 'my/haskell-minor-mode)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++++++ Hlint ++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(flycheck-add-next-checker 'intero
                           '(warning . haskell-hlint))

(require 'hlint-refactor)
(add-hook 'haskell-mode-hook 'hlint-refactor-mode)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ Other Modes +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; use programming flyspell mode
(add-hook 'haskell-mode-hook 'flyspell-prog-mode)

;; (add-hook 'haskell-mode-hook 'haskell-decl-scan-mode) ; Scans top-level
;;                                         ; declarations, and places
;;                                         ; them in a menu.

(add-hook 'haskell-mode-hook 'haskell-doc-mode) ; Echoes types of functions or
                                        ; syntax of keywords when the
                                        ; cursor is idle.

;; ;; disable pop-ups
;; (setq haskell-interactive-popup-errors nil)


;; ;; modules to add
;; ;; (add-hook 'haskell-mode-hook 'turn-on-haskell-unicode-input-method)
;; (setq haskell-font-lock-symbols t)

;; ;; Ignore compiled Haskell files in filename completions
;; (add-to-list 'completion-ignored-extensions ".hi")


;; ;; subword mode ; M-f/r moves camel case wise
;; (add-hook 'haskell-mode-hook 'subword-mode)

;; ;; load ghc mod - you need ghc-mod for this: cabal install ghc-mod
;; ;; (autoload 'ghc-init "ghc" nil t)
;; ;; (autoload 'ghc-debug "ghc" nil t)
;; ;; (add-hook 'haskell-mode-hook (lambda () (ghc-init)))


;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; +++++++++++++++ OVERWRITE FUNCTIONS TO CHANGE BEHAVIOR +++++++++++++++
;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; ;; (defun haskell-mode-buffer-apply-command (cmd)
;; ;;   "Execute shell command CMD with current buffer as input and
;; ;; replace the whole buffer with the output. If CMD fails the buffer
;; ;; remains unchanged."
;; ;;   (set-buffer-modified-p t)
;; ;;   (let* ((chomp (lambda (str)
;; ;;                   (while (string-match "\\`\n+\\|^\\s-+\\|\\s-+$\\|\n+\\'" str)
;; ;;                     (setq str (replace-match "" t t str)))
;; ;;                   str))
;; ;;          (errout (lambda (fmt &rest args)
;; ;;                    (let* ((warning-fill-prefix " "))
;; ;;                      (display-warning cmd (apply 'format fmt args) :warning))))
;; ;;          (filename (buffer-file-name (current-buffer)))
;; ;;          (cmd-prefix (replace-regexp-in-string " .*" "" cmd))
;; ;;          (tmp-file (make-temp-file cmd-prefix))
;; ;;          (err-file (make-temp-file cmd-prefix))
;; ;;          (default-directory (if (and (boundp 'haskell-session)
;; ;;                                      haskell-session)
;; ;;                                 (haskell-session-cabal-dir haskell-session)
;; ;;                               default-directory))
;; ;;          (errcode (with-temp-file tmp-file
;; ;;                     (call-process cmd filename
;; ;;                                   (list (current-buffer) err-file) nil)))
;; ;;          (stderr-output ""
;; ;;                         ;; (with-temp-buffer
;; ;;                         ;;   (insert-file-contents err-file)
;; ;;                         ;;   (funcall chomp (buffer-substring-no-properties (point-min) (point-max))))
;; ;;                         )
;; ;;          (stdout-output
;; ;;           (with-temp-buffer
;; ;;             (insert-file-contents tmp-file)
;; ;;             (buffer-substring-no-properties (point-min) (point-max)))))
;; ;;     (if (string= "" stderr-output)
;; ;;         (if (string= "" stdout-output)
;; ;;             (funcall errout
;; ;;                      "Error: %s produced no output, leaving buffer alone" cmd)
;; ;;           (save-restriction
;; ;;             (widen)
;; ;;             ;; command successful, insert file with replacement to preserve
;; ;;             ;; markers.
;; ;;             (insert-file-contents tmp-file nil nil nil t)))
;; ;;       ;; non-null stderr, command must have failed
;; ;;       (funcall errout "%s failed: %s" cmd stderr-output)
;; ;;       )
;; ;;     (delete-file tmp-file)
;; ;;     (delete-file err-file)
;; ;;     ))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; haskell_config.el ends here
