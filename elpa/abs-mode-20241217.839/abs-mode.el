;;; abs-mode.el --- Major mode for the modeling language Abs -*- lexical-binding: t; -*-

;; Copyright (C) 2010-2022  Rudolf Schlatte

;; Author: Rudi Schlatte <rudi@constantly.at>
;; URL: https://github.com/abstools/abs-mode
;; Package-Version: 20241217.839
;; Package-Revision: debb48caef33
;; Package-Requires: ((emacs "26.1") (erlang "2.8") (maude-mode "0.3") (flymake "1.0") (yasnippet "0.14.0"))
;; Keywords: languages

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, version 3.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; A major mode for editing files for the modeling language Abs.
;;
;; Documentation for the Abs language is at http://docs.abs-models.org/.
;;

(require 'compile)
(require 'custom)
(require 'easymenu)
(eval-when-compile (require 'rx))
(require 'flymake-proc)
(require 'cl-lib)
(require 'cc-mode)
(require 'cc-langs)
(require 'yasnippet nil t)              ; ignore if not installed
(require 'speedbar)
(autoload 'inferior-erlang "erlang-autoloads" nil t)
(autoload 'run-maude "maude-mode" nil t)

;;; Code:

;;; Customization
(defgroup abs nil
  "Major mode for editing files in the programming / modeling language Abs."
  :group 'languages)

(defconst abs--backends '(java erlang maude prolog)
  "List of ABS backends.")

(define-obsolete-variable-alias 'abs-target-language 'abs-backend "v1.8")
(defcustom abs-backend 'erlang
  "The default backend for code generation."
  :type `(radio ,@(mapcar (lambda (backend) (list 'const backend)) abs--backends))
  :group 'abs)
(put 'abs-backend 'safe-local-variable
     #'(lambda (x) (member x abs--backends)))

(defcustom abs-compiler-program "absc"
  "Command to invoke the Abs compiler.
This variable is also set by `abs-download-compiler'."
  :type 'string
  :group 'abs)
(put 'abs-compiler-program 'risky-local-variable t)

(defcustom abs-output-directory nil
  "The directory where compiled models are generated.
If non-NIL, the value of this variable will be passed to
`abs-compiler-program' via the `-d' command line switch.  Note
that a warning prompt will appear when opening a file that tries
to set this variable to a value above the current directory via
its file-local variables section.

If this variable is NIL, the erlang backend will create files
below `gen/erl/’ and the Java backend below `gen/', which is the
default behavior of the ABS compiler."
  :type 'directory
  :group 'abs)
(put 'abs-output-directory 'safe-local-variable
     #'(lambda (dir)
         (string-prefix-p default-directory (expand-file-name (file-name-as-directory dir)))))

(defcustom abs-java-classpath "absfrontend.jar"
  "The classpath for the Java backend.
The contents of this variable will be passed to the java
executable via the `-cp' argument."
  :type 'string
  :group 'abs)
(put 'abs-java-classpath 'risky-local-variable t)

(define-obsolete-variable-alias 'abs-indent 'c-basic-offset "v1.1")

(defcustom abs-use-timed-interpreter nil
  "Control whether Abs code uses the timed Maude interpreter by default.
This option influences the Maude backend only.  Note that if
`abs-clock-limit' is set as a buffer-local variable, for example
via \\[add-file-local-variable], the timed interpreter will be
used regardless of the value of `abs-use-timed-interpreter'."
  :type 'boolean
  :group 'abs)
(put 'abs-use-timed-interpreter 'safe-local-variable 'booleanp)

(defcustom abs-mode-hook (list 'imenu-add-menubar-index 'abs-flymake-mode-on 'abs-maybe-yasnippet-mode-on)
  "Hook for customizing `abs-mode'."
  :type 'hook
  :options (list 'imenu-add-menubar-index 'abs-flymake-mode-on 'abs-maybe-yasnippet-mode-on)
  :group 'abs)

(defcustom abs-clock-limit nil
  "Default limit value for the clock in the timed Abs interpreter.
Note that you can set this variable as a file-local variable as
well.  The Maude backend will use a default value of 100 in case
`abs-clock-limit' is NIL but `abs-use-timed-interpreter' is set."
  :type '(choice integer (const :tag "No limit" nil))
  :group 'abs)
(put 'abs-clock-limit 'safe-local-variable '(lambda (x) (or (integerp x) (null x))))

(defcustom abs-local-port nil
  "Port where to start the Model API.
If nil, do not start the Model API."
  :type 'integer
  :group 'abs)
(put 'abs-local-port 'safe-local-variable 'integerp)

(defcustom abs-compile-with-coverage-info nil
  "Control whether to generate erlang code with coverage info."
  :type 'boolean
  :group 'abs)
(put 'abs-compile-with-coverage-info 'safe-local-variable 'booleanp)

(defcustom abs-default-resourcecost 0
  "Default resource cost of executing one ABS statement in the timed interpreter.
Only effective for the Maude backend."
  :type 'integer
  :group 'abs)
(put 'abs-default-resourcecost 'safe-local-variable 'integerp)

(defcustom abs-link-source-path nil
  "Path to link the ABS runtime sources for the erlang backend.
This is a debugging aid for the erlang backend, symlinking the
erlang runtime library sources into the generated code so that
the model does not need to be recompiled when editing the Erlang
runtime library.  If nil, sources will not be linked."
  :type '(choice (const :tag "Do not link" nil)
                 directory)
  :group 'abs)
(put 'abs-link-source-path 'safe-local-variable '(lambda (x) (or (null x) (stringp x))))

(defcustom abs-directory (locate-user-emacs-file "abs-mode")
  "The directory where mode-internal files should be kept.
Location of absfrontend.jar when installed via
`abs-download-compiler'."
  :type 'directory
  :group 'abs)
(put 'abs-directory 'risky-local-variable t)

(defvar abs-product-name nil
  "The product to compile from the software product line.
When nil, ignore deltas and product declarations and compile the
base model.")
(put 'abs-product-name 'safe-local-variable 'stringp)

;;; Making faces

(defgroup abs-faces nil "Faces for abs mode."
  :group 'abs)

(defface abs-keyword-face '((default (:inherit font-lock-keyword-face)))
  "Face for Abs keywords."
  :group 'abs-faces)
(defvar abs-keyword-face 'abs-keyword-face
  "Face for Abs keywords.")

(defface abs-constant-face '((default (:inherit font-lock-constant-face)))
  "Face for Abs constants."
  :group 'abs-faces)
(defvar abs-constant-face 'abs-constant-face
  "Face for Abs constants.")

(defface abs-function-name-face
  '((default (:inherit font-lock-function-name-face)))
  "Face for Abs function-names."
  :group 'abs-faces)
(defvar abs-function-name-face 'abs-function-name-face
  "Face for Abs function-names.")

(defface abs-type-face '((default (:inherit font-lock-type-face)))
  "Face for Abs types."
  :group 'abs-faces)
(defvar abs-type-face 'abs-type-face
  "Face for Abs types.")

(defface abs-variable-name-face
  '((default (:inherit font-lock-variable-name-face)))
  "Face for Abs variables."
  :group 'abs-faces)
(defvar abs-variable-name-face 'abs-variable-name-face
  "Face for Abs variables.")

(defconst abs--cid-regexp "\\_<[[:upper:]]\\(?:\\sw\\|\\s_\\)*\\_>")
(defconst abs--id-regexp
  "\\_<\\(?:[[:lower:]]\\|_\\)\\(?:[[:alnum:]]\\|_\\|'\\)*\\_>")

;;; Font-lock for Abs.
;;;
(defconst abs-keywords
  (eval-when-compile
    (regexp-opt
     '("module" "import" "export" "from"              ; the top levels
       "data" "type" "def" "interface" "class" "trait" "exception"
       "case" "=>" "new" "local"                      ; the functionals
       "extends"                                      ; the interfaces
       "implements"                                   ; the class
       "recover"
       "delta" "adds" "modifies" "removes" "uses"
       "hasField" "hasMethod" "hasInterface"          ; Deltas
       "productline" "features" "core" "after" "when" ; productlines
       "root" "extension" "group" "opt"
       "oneof" "allof" "ifin" "ifout" "exclude" "require"
       "product"                                      ; product definition
       "let" "in"
       "if" "then" "else" "return" "while" "foreach"  ; the statements
       "await" "assert" "throw" "die" "get" "skip" "suspend"
       "original" "movecogto"
       "try" "catch" "finally"
       "duration"                       ; guard / statement
       ) 'symbols))
  "List of Abs keywords.")
(defconst abs-constants
  (eval-when-compile
    (regexp-opt
     '("True" "False" "null" "this" "Nil" "Cons")
     'words))
  "List of Abs special words.")

(defvar abs-font-lock-keywords
  (list
   ;; order is important here; earlier entries override later ones
   (cons abs-keywords 'abs-keyword-face)
   (cons abs-constants 'abs-constant-face)
   (cons (concat "\\(" abs--cid-regexp "\\)") 'abs-type-face)
   (list (concat "\\(" abs--id-regexp "\\)[[:space:]]*(") 1
         'abs-function-name-face)
   (cons (concat "\\(" abs--id-regexp "\\)") 'abs-variable-name-face)
   (list "\\<\\(# \w+\\)\\>" 1 'font-lock-warning-face t))
  "Abs keywords.")

;;; cc-mode wants different fontification levels, but we only offer one.
(defvar abs-font-lock-keywords-1 abs-font-lock-keywords)
(defvar abs-font-lock-keywords-2 abs-font-lock-keywords)
(defvar abs-font-lock-keywords-3 abs-font-lock-keywords)

;;; Keymap.  `define-derived-mode' would probably do this for us but we use
;;; `c-make-inherited-keymap' just to make sure cc-mode is happy.
(defvar abs-mode-map (c-make-inherited-keymap)
  "Keymap for `abs-mode'.")

;;; abbrev
(define-abbrev-table 'abs-mode-abbrev-table nil
  ;; defined separately for the benefit of elisp-int
  "Abbrev table for `abs-mode'.")
(c-define-abbrev-table 'abs-mode-abbrev-table
  '(("else" "else" c-electric-continued-statement 0)))

;;; Snippets
(defvar abs--yas-snippets-dir
  (expand-file-name
   "snippets"
   (file-name-directory
    (cond
     (load-in-progress
      load-file-name)
     ((and (boundp 'byte-compile-current-file)
           byte-compile-current-file)
      byte-compile-current-file)
     (t
      (buffer-file-name)))))
  "Directory containing yasnippet snippets for ABS.")

(defun abs-maybe-yasnippet-mode-on ()
  "Activate yasnippet-minor-mode in current buffer if available."
  (when (featurep 'yasnippet)
    (yas-minor-mode-on)))

;;; Abs syntax table
(defvar abs-mode-syntax-table (copy-syntax-table)
  "Syntax table for `abs-mode'.")
(modify-syntax-entry ?`   "\""    abs-mode-syntax-table)
(modify-syntax-entry ?+   "."     abs-mode-syntax-table)
(modify-syntax-entry ?-   "."     abs-mode-syntax-table)
(modify-syntax-entry ?=   "."     abs-mode-syntax-table)
(modify-syntax-entry ?%   "."     abs-mode-syntax-table)
(modify-syntax-entry ?<   "."     abs-mode-syntax-table)
(modify-syntax-entry ?>   "."     abs-mode-syntax-table)
(modify-syntax-entry ?&   "."     abs-mode-syntax-table)
(modify-syntax-entry ?|   "."     abs-mode-syntax-table)
(modify-syntax-entry ?$   "."     abs-mode-syntax-table)
(modify-syntax-entry ?/   ". 124" abs-mode-syntax-table)
(modify-syntax-entry ?*   ". 23b" abs-mode-syntax-table)
(modify-syntax-entry ?\n  ">"     abs-mode-syntax-table)
(modify-syntax-entry ?\^m ">"     abs-mode-syntax-table)

(defvar abs-imenu-syntax-alist
  ;; Treat dot as symbol constituent to handle qualified identifiers
  '(("." . "_")))

(defvar abs-imenu-generic-expression
  `(("Deltas"
     ,(rx bol (* whitespace) "delta" (1+ whitespace)
          (group (char upper) (* (char alnum))))
     1)
    ("Functions"
     ,(rx bol (* whitespace) "def" (1+ whitespace)
          (char upper) (* (or (char alnum) "<" ">"))
          (1+ whitespace)
          ;; not quite correct since the last part of a qualified name
          ;; should start with lowercase.
          (group (* (char alnum))))
     1)
    ("Datatypes"
     ,(rx bol (* whitespace) (or "data" "type") (1+ whitespace)
          (group (char upper) (* (char alnum))))
     1)
    ("Exceptions"
     ,(rx bol (* whitespace) "exception" (1+ whitespace)
          (group (char upper) (* (char alnum))))
     1)
    ("Classes"
     ,(rx bol (* whitespace) "class" (1+ whitespace)
          (group (char upper) (* (char alnum))))
     1)
    ("Interfaces"
     ,(rx bol (* whitespace) "interface" (1+ whitespace)
          (group (char upper) (* (char alnum))))
     1)
    ("Modules"
     ,(rx bol (* whitespace) "module" (1+ whitespace)
          (group (char upper) (* (or (char alnum) "."))))
     1))
  "Imenu expression for `abs-mode'.  See `imenu-generic-expression'.")

;;; Minimal outline (folding) support
(defvar abs--outline-regexp
  (rx bol (or "delta" "def" "data" "type" "exception" "class" "interface" "module")))
(defvar abs--outline-level (lambda () (1+ (/ (current-indentation) abs-indent))))

(defun abs--read-backend ()
  (interactive)
  (let ((backend-name (completing-read "Backend: " abs--backends nil t nil nil abs-backend)))
    (intern-soft backend-name)))
;;; Minimal auto-insert mode support
(define-auto-insert 'abs-mode '("Module name: " "module " str ";" ?\n ?\n))

;;; Flymake support: calculate all input files for the current buffer
(defun abs--current-buffer-referenced-modules ()
  "Calculate a list of all modules referenced by current buffer."
  (let ((imports (save-excursion
                   (goto-char (point-min))
                   (cl-loop
                    for match = (re-search-forward (rx bol (0+ blank) bow "import" eow (1+ any) bow "from" eow (1+ blank)
                                                       (group (1+ (or (syntax word) ".")))
                                                       (0+ blank) ";")
                                                   (point-max) t)
                    while match
                    collect (substring-no-properties (match-string 1)))))
        (uses (save-excursion
                (goto-char (point-min))
                (cl-loop
                 for match = (re-search-forward (rx bol (0+ blank) bow "uses" eow (1+ blank)
                                                    (group (1+ (or (syntax word) ".")))
                                                    (0+ blank) ";")
                                                (point-max) t)
                 while match
                 collect (substring-no-properties (match-string 1))))))
    (delete-dups (append imports uses))))

(defun abs--file-imports (file)
  "Calculate a list of all modules referenced by FILE."
  (with-temp-buffer
    (insert-file-contents file)
    (abs--current-buffer-referenced-modules)))

(defun abs--current-buffer-module-definitions ()
  "Calculate a list of all modules defined in current buffer."
  (save-excursion
    (goto-char (point-min))
    (cl-loop
     for match = (re-search-forward (rx bol (0+ blank) "module" (1+ blank)
                                        (group (1+ (or (syntax word) ".")))
                                        (0+ blank) ";")
                                    (point-max) t)
     while match
     collect (substring-no-properties (match-string 1)))))

(defun abs--file-module-definitions (file)
  "Calculate a list of all modules defined in FILE."
  (with-temp-buffer
    (insert-file-contents file)
    (abs--current-buffer-module-definitions)))

(defun abs--module-file-alist ()
  "Calculate alist of (file . (modules...)) for all abs files in current dir."
  ;; TODO: consider searching subdirectories, etc., maybe via `project.el' --
  ;; for now, special cases can be handled by the user via setting
  ;; `abs-input-files'.
  (let ((module-file-alist nil))
    (dolist (file (directory-files "." nil "\\.abs\\'" t))
      (dolist (module (abs--file-module-definitions file))
        (push (cons module file) module-file-alist)))
    module-file-alist))

(defun abs--calculate-input-files ()
  "Calculate the set of required input files to compile the current buffer.
This is used to invoke flymake properly."
  (let* ((module-locations-alist (abs--module-file-alist))
         (files (list (file-name-nondirectory (buffer-file-name))))
         (known-modules (abs--file-module-definitions buffer-file-name))
         (needed-modules (cl-set-difference (abs--current-buffer-referenced-modules) known-modules :test 'equal)))
    (while needed-modules
      (let* ((needed-module (pop needed-modules))
             (location (assoc needed-module module-locations-alist)))
        ;; "best-effort" results:
        ;;
        ;; - ignore modules that are not found; the compiler / syntax checker
        ;;   will complain anyway.  This also handles modules from the
        ;;   standard library “by accident”.
        ;;
        ;; - for modules defined in multiple files, use an arbitrary file and
        ;;   hope for the best.
        (when location
          (cl-pushnew (cdr location) files))))
    ;; have current buffer first in list; among others, the Maude backend
    ;; expects this.
    (nreverse files)))


;;; Compiling the current buffer.
;;;
(defvar abs-maude-output-file nil
  "The Maude file that will be generated or loaded by \\[abs-next-action].
Defaults to the buffer filename with a \".maude\" extension if
`abs-input-files' is unset, or to the name of the first element
in `abs-input-files' with a \".maude\" extension otherwise.

Add a file-local setting to override the default value.  Values
that name a file below the current directory are considered safe,
values outside the current directory have to be confirmed.")
(put 'abs-maude-output-file 'safe-local-variable
     #'(lambda (file) (string-prefix-p default-directory (file-name-directory (expand-file-name file)))))

(defvar abs-java-output-jar-file nil
  "The jar file that should be created by the Java backend.
When nil, no jar file will be created.  Regardless of this
setting, the Java backend will generate .java and .class files
below `gen/'.

Add a file-local setting to override the default value.  Values
that name a file below the current directory are considered safe,
values outside the current directory have to be confirmed.")
(put 'abs-java-output-jar-file 'safe-local-variable
     #'(lambda (file) (string-prefix-p default-directory (file-name-directory (expand-file-name file)))))

(defvar abs-input-files nil
  "List of Abs files to be compiled by \\[abs-next-action].
If nil, use the file visiting the current file, and any abs file
in the current directory that defines a module mentioned in an
`import' statement in any other file to be compiled.  When
multiple files in the current directory declare a needed module,
an arbitrary file among them is chosen.

If set, the first element determines the name of the generated
Maude file if generating Maude code and `abs-maude-output-file'
is not set.

It is possible to to explicitly set the list of files to be
compiled.  Put a section like the following at the end of your
buffer:

// Local Variables:
// abs-input-files: (\"file1.abs\" \"file2.abs\")
// End:")
(put 'abs-input-files 'safe-local-variable
     (lambda (list) (cl-every #'stringp list)))

(defvar abs-modelapi-index-file nil
  "The Model API index file to compile into this model, if any.")
(put 'abs-modelapi-index-file 'safe-local-variable #'stringp)

(defvar abs-modelapi-static-dir nil
  "The Model API static directory containing to compile into this model, if any.")
(put 'abs-modelapi-static-dir 'safe-local-variable #'stringp)


(defvar abs-compile-command nil
  "The compile command called by \\[abs-next-action].
The default behavior is to call \"make\" if a Makefile is in the
current directory, otherwise call the program named by
`abs-compiler-program' on the current file.  This behavior can be
changed by giving `abs-compile-comand' a file-local or dir-local
value.")
(put 'abs-compile-command 'safe-local-variable
     (lambda (a) (and (stringp a)
                      (or (not (boundp 'compilation-read-command))
                          compilation-read-command))))

;;; flymake support

;; By happy accident, an entry in `compilation-error-regexp-alist-alist'
;; already matches our error message format, including the difference between
;; errors and warnings, so we don't have to customize anything for
;; compilation-mode or flymake.
(defun abs-flymake-mode-on ()
  "Activate flymake in current buffer if possible.
Activate flymake if a file exists for the current buffer,
otherwise arrange to activate flymake upon save.

This function is meant to be added to `abs-mode-hook'."
  (cond ((file-exists-p buffer-file-name)
         (flymake-mode)
         (remove-hook 'after-save-hook 'abs-flymake-mode-on t))
        (t (add-hook 'after-save-hook 'abs-flymake-mode-on nil t))))

(defun abs-flymake-init ()
  "Run flymake in current buffer."
  (when abs-compiler-program
    (let* ((filename (file-name-nondirectory (buffer-file-name)))
           ;; TODO: use `abs--input-files' here, but take care with relative
           ;; vs absolute filenames
           (other-files (delete filename (abs--calculate-input-files)))
           (temp-filename
            (flymake-proc-init-create-temp-buffer-copy 'flymake-proc-create-temp-inplace)))
      (list
       abs-compiler-program
       (remove nil (cl-list* temp-filename other-files))))))

(add-to-list 'flymake-proc-allowed-file-name-masks
             '("\\.abs\\'" abs-flymake-init flymake-proc-simple-cleanup flymake-proc-get-real-file-name))


;;; Compilation support
(defun abs--file-date-< (d1 d2)
  "Compare file dates D1 and D2, as returned by `file-attributes'."
  (or (and (= (cl-first d1) (cl-first d2))
           (< (cl-second d1) (cl-second d2)))
      (< (cl-first d1) (cl-first d2))))

(defun abs--input-files ()
  "Return a list of files comprising a complete ABS model."
  (or abs-input-files
      (abs--calculate-input-files)
      (list (buffer-file-name))))

(defun abs--maude-filename ()
  "Return name of the Maude file to be generated from the ABS model."
  (or abs-maude-output-file
      (concat (file-name-sans-extension (car (abs--input-files))) ".maude")))

(defun abs--absolutify-filename (filename)
  "Return absolute path for FILENAME."
  (if (file-name-absolute-p filename)
      filename
    (concat (file-name-directory (buffer-file-name)) filename)))

(defun abs--real-output-directory ()
  "Return the output directory, suitable as the first arg to CONCAT.
Try to return the correct value both in case
`abs-output-directory' has a value and when we let the compiler
decide."
  (file-name-as-directory
   (or abs-output-directory
       (pcase abs-backend
         (`maude ".")
         ;; to be adjusted if the ABS compiler changes its default output dirs.
         (`erlang "gen/erl/")
         (`java "gen/")
         ;; FIXME Prolog backend can use -fn outfile
         (`prolog ".")))))

(defun abs--guess-module ()
  "Guess the name of a module."
  (save-excursion
    (goto-char (point-max))
    (re-search-backward (rx bol (* whitespace) "module" (1+ whitespace)
                            (group (char upper) (* (or (char alnum) "." "_")))))
    (buffer-substring-no-properties (match-beginning 1) (match-end 1))))

(defun abs--calculate-compile-command ()
  "Return the command to compile the current model.
Expects `abs-backend' to be bound to the desired backend."
  (cond (abs-compile-command)
        ((file-exists-p "Makefile") compile-command)
        (t (concat abs-compiler-program
                   " --" (symbol-name abs-backend)
                   " "
                   ;; FIXME: make it work with filenames with spaces
                   (mapconcat (lambda (s) (concat "\"" s "\""))
                              (abs--input-files) " ")
                   (when abs-modelapi-index-file
                     (concat " --modelapi-index-file \"" abs-modelapi-index-file "\""))
                   (when abs-modelapi-static-dir
                     (concat " --modelapi-static-dir \"" abs-modelapi-static-dir "\""))
                   (when (eql abs-backend 'maude)
                     (concat " -o \"" (abs--maude-filename) "\""))
                   (when (and abs-java-output-jar-file (eql abs-backend 'java))
                     (concat " -o \"" abs-java-output-jar-file "\""))
                   (when abs-output-directory
                     (concat " -d \"" abs-output-directory "\""))
                   (when abs-product-name
                     (concat " --product " abs-product-name))
                   (when (and (eql abs-backend 'maude)
                              (or abs-use-timed-interpreter
                                  (local-variable-p 'abs-clock-limit)))
                     (concat " --timed --limit="
                             (number-to-string (or abs-clock-limit 100))))
                   (when (and (eql abs-backend 'maude)
                              (< 0 abs-default-resourcecost))
                     (concat " --defaultcost "
                             (number-to-string abs-default-resourcecost)))
                   (when (and (eq abs-backend 'erlang) abs-compile-with-coverage-info)
                     " --debuginfo")
                   ;; this branch must be last since it invokes a second
                   ;; command after `absc'
                   (when (and (eq abs-backend 'erlang)
                              abs-link-source-path)
                     (concat " && cd \"" (abs--real-output-directory) "\" && ./link_sources " abs-link-source-path))
                   " "))))

(defun abs--needs-compilation ()
  "Return non-nil if current file needs to be (re)compiled.
Expects `abs-backend' to be bound to the desired backend."
  (let* ((abs-output-file
          (abs--absolutify-filename
           (pcase abs-backend
             (`maude (abs--maude-filename))
             (`erlang (concat (abs--real-output-directory) "absmodel/Emakefile"))
             (`java (concat (abs--real-output-directory) "ABS/StdLib/Bool.java"))
             ;; KLUDGE: Prolog backend can use -fn outfile, so this might be
             ;; wrong.  On the other hand, the output of the prolog backend
             ;; cannot be run anyway, so it doesn’t currently matter.
             (`prolog "abs.pl"))))
         (abs-modtime (nth 5 (file-attributes (buffer-file-name))))
         (output-modtime (nth 5 (file-attributes abs-output-file))))
    (or (not output-modtime)
        (abs--file-date-< output-modtime abs-modtime)
        (buffer-modified-p))))

(defun abs--compile-model ()
  "Compile the current buffer after prompting for a compile command.
The user will be shown a hopefull-correct compile command in the
minibuffer and can edit it before compilation starts.  Expects
`abs-backend' to be bound to the desired backend."
  (let ((compile-command (abs--calculate-compile-command)))
    (call-interactively 'compile)))

(defun abs--compile-model-no-prompt ()
  "Compile the current buffer.
Expects `abs-backend' to be bound to the desired backend."
  (compile (abs--calculate-compile-command)))

;;; Pacify the byte compiler.
(defvar inferior-maude-buffer)          ; defined in `maude-mode'
(defvar cov-coverage-file-paths)        ; defined in `cov'

(defun abs--run-model ()
  "Start the model.
Expects `abs-backend' to be bound to the desired backend."
  (pcase abs-backend
    (`maude (save-excursion (run-maude))
            (comint-send-string inferior-maude-buffer
                                (concat "in \""
                                        (abs--absolutify-filename
                                         (abs--maude-filename))
                                        "\"\n"))
            (with-current-buffer inferior-maude-buffer
              (sit-for 1)
              (goto-char (point-max))
              (insert "frew start .")
              (comint-send-input)))
    (`erlang (let* ((script (concat (abs--real-output-directory)
                                    (if (eq window-system 'w32)
                                        "run.bat"
                                      "run")))
                    (args (concat
                           (when abs-clock-limit (format " -l %d " abs-clock-limit))
                           (when abs-local-port (format " -p %d " abs-local-port))
                           ;; FIXME: reinstate `module' arg
                           ;; once abs--guess-module doesn't
                           ;; pick a module w/o main block
                           ))
                    (erl-command (concat script args)))
               (when (get-buffer "*erlang*")
                 (kill-buffer (get-buffer "*erlang*")))
               (if (eq window-system 'w32)
                   ;; `inferior-erlang' tries calling `/bin/sh' when
                   ;; given a parameter, even on windows; dodge the
                   ;; issue by calling our own `run.bat' script
                   ;; instead
                   (let ((buffer (get-buffer-create "*erlang*")))
                     (pop-to-buffer buffer)
                     (shell-command (expand-file-name erl-command) buffer))
                 (inferior-erlang erl-command))))
    (`java (let* ((module (abs--guess-module))
                  (buffer-name (concat "*abs java " module "*"))
                  (command (concat "java -cp gen:"
                                   (expand-file-name abs-java-classpath)
                                   " " module ".Main"
                                   (when abs-clock-limit (format " -l %d " abs-clock-limit))
                                   (when abs-local-port (format " -p %d " abs-local-port))
                                   " &")))
             (when (get-buffer buffer-name)
               (kill-buffer (get-buffer buffer-name)))
             (let ((buffer (get-buffer-create buffer-name)))
               (pop-to-buffer buffer)
               (shell-command command buffer))))
    (_ (error "Don't know how to run with target %s" abs-backend))))

(defun abs-next-action (flag)
  "Compile or execute the buffer.

The language backend for compilation can be chosen by giving a
`C-u' prefix to this command.  The default backend is set via
customizing or setting `abs-backend' and can be overridden for a
specific abs file by giving a file-local value via
`add-file-local-variable'.

To compile or run a model that consists of more than one file,
set `abs-input-files' to a list of filenames.

To execute on the Maude backend, make sure that Maude and the
Maude Emacs mode are installed.

To execute on the Java backend, set `abs-java-classpath' to
include the file absfrontend.jar.

To execute on the Erlang backend, make sure that Erlang and the
Erlang Emacs mode are installed.

Argument FLAG will prompt for language backend to use if 1, i.e.,
if the command was invoked with `C-u'."
  (interactive "p")
  (let ((abs-backend
         (if (= 1 flag) abs-backend (or (abs--read-backend) abs-backend))))
    (if (abs--needs-compilation)
        (abs--compile-model)
      (abs--run-model))))

;;; Movement

(defsubst abs--inside-string-or-comment-p ()
  "Return non-nil if point is inside a string or comment."
  (let ((state (save-excursion (syntax-ppss))))
    (or (nth 3 state) (nth 4 state))))

(defvar abs-definition-begin-re
  (rx (and (or "interface" "class" "def" "data" "type") blank))
  "Regex of beginning of Abs definition.")

(defun abs-beginning-of-definition ()
  "Move backward to the beginning of the current definition.

A definition can be interface, class, datatype or function."
  (interactive)
  (catch 'found
    (while (re-search-backward abs-definition-begin-re nil 'move)
      (unless (abs--inside-string-or-comment-p)
        (throw 'found t))))
  (move-beginning-of-line nil))

(defun abs-end-of-definition ()
  "Move forward to the end of the current definition."
  (interactive)
  (let ((startpos (point)))
    ;; FIXME: this is slightly buggy.
    (forward-char)
    (re-search-forward abs-definition-begin-re nil 'move)
    (re-search-forward abs-definition-begin-re nil 'move)
    (catch 'found
      (while (re-search-backward (rx (or "}" ";")) startpos)
        (unless (abs--inside-string-or-comment-p)
          (throw 'found t))))
    (forward-char)))

;;; Indentation
(c-add-style
 "abs" '("java"
         ;; to fix indentation, use `c-set-offset' then update this list
         (c-offsets-alist
          ;; don't indent a class definition preceded by an annotation
          (topmost-intro-cont . 0)
          ;; don’t outdent "case" (in Java it’s a label, for us it’s a
          ;; statement or expression)
          (case-label . +))))

;;; Set up the "Abs" pull-down menu
(easy-menu-define abs-mode-menu abs-mode-map
  "Abs mode menu."
  '("Abs"
    ["Compile" (abs--compile-model-no-prompt abs-backend) :active t]
    ["Run" (abs--run-model abs-backend)
     :active (not (abs--needs-compilation abs-backend))]
    "---"
    ("Select Backend"
     ["Maude" (setq abs-backend 'maude)
      :active t
      :style radio
      :selected (eq abs-backend 'maude)]
     ["Erlang" (setq abs-backend 'erlang)
      :active t
      :style radio
      :selected (eq abs-backend 'erlang)]
     ["Java" (setq abs-backend 'java)
      :active t
      :style radio
      :selected (eq abs-backend 'java)])
    ("Maude Backend Options"
     ["Timed interpreter"
      (setq abs-use-timed-interpreter (not abs-use-timed-interpreter))
      :active t :style toggle
      :selected abs-use-timed-interpreter])))

;;; Putting it all together.
(put 'abs-mode 'c-mode-prefix "abs-")

;;;###autoload
(define-derived-mode abs-mode prog-mode "Abs"
  "Major mode for editing Abs files.

The hooks `prog-mode-hook' and `c-mode-common-hook' are run at
mode initialization, then `abs-mode-hook'.

The following keys are set:
\\{abs-mode-map}"
  :group 'abs
  :syntax-table abs-mode-syntax-table
  :abbrev-table abs-mode-abbrev-table
  (c-initialize-cc-mode t)
  (c-init-language-vars abs-mode)
  (c-basic-common-init 'abs-mode "abs")
  (c-common-init 'abs-mode)
  (setq c-buffer-is-cc-mode 'abs-mode)
  (c-set-style "abs" 1)
  ;; This keybinding unfortunately overrides a cc-mode keybinding but was
  ;; established before we inherited from c-common-mode.  Keep it like this
  ;; for the benefit of the existing user base.
  (define-key abs-mode-map "\C-c\C-c" 'abs-next-action)
  (c-lang-setvar comment-start "//")
  (c-lang-setvar comment-end "")
  (c-lang-setvar comment-start-skip "//+\\s-*")
  (c-lang-setvar font-lock-defaults '(abs-font-lock-keywords))
  (setq c-opt-cpp-prefix nil)
  ;; Movement
  (c-lang-setvar beginning-of-defun-function 'abs-beginning-of-definition)
  (c-lang-setvar end-of-defun-function 'abs-end-of-definition)
  ;; imenu
  (setq imenu-generic-expression abs-imenu-generic-expression)
  (setq imenu-syntax-alist abs-imenu-syntax-alist)
  ;; outline (code folding)
  (setq-local outline-regexp abs--outline-regexp)
  (setq-local outline-level abs--outline-level)
  (outline-minor-mode)
  ;; speedbar support
  (when (fboundp 'speedbar-add-supported-extension)
    (speedbar-add-supported-extension ".abs"))
  ;; code coverage (https://github.com/AdamNiederer/cov/blob/master/cov.el)
  (when (featurep 'cov)
    (make-local-variable 'cov-coverage-file-paths)
    (push "gen/erl/absmodel" cov-coverage-file-paths))
  (c-run-mode-hooks 'c-mode-common-hook)
  ;; Snippet support
  (when (featurep 'yasnippet)
    ;; If yasnippet is not available, fail gracefully
    (unless (member abs--yas-snippets-dir yas-snippet-dirs)
      (add-to-list 'yas-snippet-dirs abs--yas-snippets-dir t)
      ;; we use an internal function here, but the `yasnippet-snippets' package
      ;; does the same; let's assume this is a de facto public API for now.
      (yas--load-snippet-dirs))))

(defun abs-check-installation ()
  "Display diagnostic information about the abs installation.
This is useful for bug reports."
  (interactive)
  (let ((shell-command-dont-erase-buffer t)
        (java-program (executable-find "java"))
        (erl-program (executable-find "erl"))
        (erlc-program (executable-find "erlc"))
        (abs-compiler-program-info
         (cond
          ((executable-find abs-compiler-program)
           (concat (executable-find abs-compiler-program) " (found in path)"))
          (abs-compiler-program
           (concat abs-compiler-program " (set)"))
          ("(not set)"))))
    (with-current-buffer-window
        "*ABS installation status check*" nil nil
      (insert (format "abs-compiler-program: %s\n" abs-compiler-program-info))
      (insert "\n")
      (insert (format "java: %s\n" (or java-program "(not found)")))
      (insert (format "erlc: %s\n" (or erlc-program "(not found)")))
      (insert (format "erl:  %s\n" (or erl-program "(not found)")))
      (insert "\n")
      (when abs-compiler-program
        (insert abs-compiler-program " -V says:\n")
        (shell-command (concat abs-compiler-program " -V") 4)
        (goto-char (point-max))
        (insert "\n"))
      (when java-program
        (insert java-program " -version says:\n")
        (shell-command (concat java-program " -version") 4)
        (goto-char (point-max))
        (insert "\n"))
      (when erl-program
        (insert erl-program " -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), \"releases\", erlang:system_info(otp_release), \"OTP_VERSION\"])), io:fwrite(Version), halt().' -noshell says:\n")
        (shell-command (concat erl-program " -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), \"releases\", erlang:system_info(otp_release), \"OTP_VERSION\"])), io:fwrite(Version), halt().' -noshell") 4)
        (goto-char (point-max))
        (insert "\n"))
      (help-mode))))

(defun abs-download-compiler ()
  "Download the latest released version of the abs compiler.
This command downloads absfrontend.jar from github, stores it in
`abs-directory' and sets `abs-compiler-program' to \"java -jar
<location-of-absfrontend.jar>\"."
  ;; https://stackoverflow.com/questions/24987542/is-there-a-link-to-github-for-downloading-a-file-in-the-latest-release-of-a-repo/26454035#26454035
  (interactive)
  (let* ((api-url "https://api.github.com/repos/abstools/abstools/releases/latest")
         ;; slowly and deliberately pick apart the json such that I can later
         ;; reconstruct what’s going on
         (release-info
          (with-current-buffer (url-retrieve-synchronously api-url)
            (json-read)))
         (assets (cdr (assoc 'assets release-info)))
         (absfrontend-jar-info
          (seq-find (lambda (asset)
                      (equal (cdr (assoc 'name asset)) "absfrontend.jar"))
                    assets))
         (url (cdr (assoc 'browser_download_url absfrontend-jar-info)))
         (jar-name (expand-file-name
                    (concat (file-name-as-directory abs-directory)
                            "absfrontend.jar"))))
    (make-directory (file-name-as-directory abs-directory) t)
    (url-copy-file url jar-name t)
    (customize-save-variable 'abs-compiler-program
                             (concat "java -jar " jar-name)
                             "Set via `abs-download-compiler'")))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.abs\\'" . abs-mode))


(provide 'abs-mode)
;;; abs-mode.el ends here
