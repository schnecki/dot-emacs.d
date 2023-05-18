;;; cedet_config.el ---
;;
;; Filename: cedet_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: So Okt 13 11:05:43 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Sat May 28 16:02:09 2016 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 258
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ BUILD CEDET  ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; cedet
(setq cedet-root-path (file-name-as-directory (concat package-folder "cedet/")))
;; info files
(add-to-list 'Info-directory-list (concat package-folder "cedet/doc/info"))


(defun byte-compile-cedet ()
  (interactive)
  (shell-command (concat "cd " cedet-root-path " && make && make install-info"))
	(shell-command (concat "cd " cedet-root-path "/contrib && make"))
	)


;; DO ONLY IF NOT BUILT YET
(if (not (file-exists-p (concat cedet-root-path "lisp/cedet/cedet.elc")))
    (byte-compile-cedet))


;; Load CEDET.
;; IMPORTANT: Tou must place this *before* any CEDET component (including
;; EIEIO) gets activated by another package (Gnus, auth-source, ...).
(load-file (concat cedet-root-path "cedet-devel-load.el"))
(add-to-list 'load-path (concat cedet-root-path "contrib"))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ CEDET CONFIG ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; ;; java projects - TODO
;; (ede-java-root-project "MYPROJ" :file "/home/user/projects/myProj"
;;                        :srcroot '( "src" )
;;                        :classpath nil
;;                        )


(require 'cedet)
(require 'cedet-files)
(require 'cedet-cscope)
(require 'cedet-global)
(require 'cedet-idutils)
(require 'semantic)
;; (require 'eieio)

;; Load CEDET CONTRIB.
(load-file (concat package-folder "cedet/contrib/cedet-contrib-load.el"))


;; SRecode for code generation
(srecode-minor-mode 1)

;; C/C++ config

;; Disable system header parsing
;; (setq-mode-local c-mode
;;                  semanticdb-find-default-throttle
;;                  '(project unloaded system recursive))

;; Include files for c (semantic needs to know where to look for completions)
(setq semantic-c-dependency-system-include-path '("/usr/include"
                                                  "/usr/local/include"))
;; optional add system include paths like this:
;; (semantic-add-system-include "/usr/src/linux-2.4/include" 'c-mode)

;; enable generic projects
;; (ede-enable-generic-projects)


;; JAVA config
(setq cedet-java-command "java")
(setq cedet-javap-command "javap")


;; Using JAR files for semantic
(require 'semantic/db-javap)

;; -- Variable: cedet-java-classpath-extension
;;     List of extended classpath directories and Jar files to pass to
;;     java commands.  This will affect ALL calls to java and javap that
;;     CEDET makes so that java programs will use those libraries.  This
;;     path is ignored when semantic looks up files.
(setq cedet-java-classpath-extension
      '(;; "/usr/lib/jvm/java-default-runtime/src/"
        (concat (nth 0 (split-string default-directory "src")) "./lib/")
        (concat (nth 0 (split-string default-directory "src")) "./src/")
        (concat (nth 0 (split-string default-directory "src")) "../Common/src/")
        (concat (nth 0 (split-string default-directory "src")) "../Common/lib/")))

;; -- Variable: semanticdb-javap-classpath
;;     List of extended classpath directories and Jar files used by
;;     'semantic/db-javap' when searching for classes.  This classpath is
;;     NOT passed to java when invoking java commands.
(setq semanticdb-javap-classpath
      '("/usr/lib/jvm/default-runtime/src/"
        (concat (nth 0 (split-string default-directory "src")) "./lib/")
        (concat (nth 0 (split-string default-directory "src")) "./src/")
        (concat (nth 0 (split-string default-directory "src")) "../Common/src/")
        (concat (nth 0 (split-string default-directory "src")) "../Common/lib/")))

;; (eval (concat (nth 0 (split-string default-directory "src")) "src/"))
;;         (shell-command (concat "find " (concat (nth 0 (split-string default-directory "src")) "./src/") " -name \"*.java\" ;"))
;;         (shell-command (concat "find " (concat (nth 0 (split-string default-directory "src")) "./Common/src/") " -name \"*.java\" ;"))
;;         (shell-command (concat "find " (concat (nth 0 (split-string default-directory "src")) "./lib/") " -name \"*.jar\" ;"))
;;         (shell-command (concat "find " (concat (nth 0 (split-string default-directory "src")) "../Common/lib/") " -name \"*.jar\" ;"))
;;         ))


;;GNU Global - enhance and speed up CEDET
(setq cedet-global-command "global")

;; use gnu global if available
(when (cedet-gnu-global-version-check t)  ; Is it ok?
  ;; Configurations for GNU Global and CEDET
  (semanticdb-enable-gnu-global-databases 'c++-mode t)
  (semanticdb-enable-gnu-global-databases 'c-mode t)
  (semanticdb-enable-gnu-global-databases 'haskell-mode t)
  (semanticdb-enable-gnu-global-databases 'java-mode t)
  (semanticdb-enable-gnu-global-databases 'jde-mode t)

  ;; (setq ede-locate-setup-options
  ;;       '(ede-locate-global
  ;;         ede-locate-base))
  )


;; MANUALLY
;; Add further minor-modes to be enabled by semantic-mode.
;; See doc-string of `semantic-default-submodes' for other things
;; you can use here.
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode) ;; Maintain tag database.
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode) ;; Reparse buffer when idle.
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode) ;; Show summary of tag at point.
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode) ;; Show completions when idle.
(remove 'global-semantic-idle-completions-mode 'semantic-default-submodes)
;; (add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode) ;; Additional tag decorations.
(remove 'global-semantic-decoration-mode 'semantic-default-submodes)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode) ;; Highlight the current tag.
;; (add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode) ;; Show current fun in header line.
(remove 'global-semantic-stickyfunc-mode 'semantic-default-submodes)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode) ;; Provide `switch-to-buffer'-like keybinding for tag names.
;; (add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)' ;; A mouse 3 context menu.
(remove 'global-cedet-m3-minor-mode 'semantic-default-submodes)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode) ;; Highlight references

;; OR AUTOMATICALLY
(semantic-load-enable-code-helpers)  ;; either this
;;(semantic-load-enable-gaudy-code-helper) ;; or this
;; (semantic-load-enable-excessive-code-helpers) ;; or that


       ;; Enable Semantic

(semantic-mode 1)


;; Disable some semantic tools
(global-semantic-decoration-mode 0) ;; if enabled it throws warnings as hell!
(global-semantic-idle-completions-mode 0)
(global-semantic-highlight-func-mode t)
(setq global-semantic-idle-summary-mode nil)

;; customisation of modes
(defun cedet-minor-mode-hook ()
  ;;  (local-set-key "\C-c " 'cedet-m3-menu-kbd)
  ;; (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)

  (local-set-key "\C-cl" 'eassist-list-methods)
  (local-set-key "\C-c\C-r" 'semantic-symref)
  )

;; (add-hook 'c-mode-common-hook 'my/cedet-hook) ;; all common hooks load this
;; (add-hook 'lisp-mode-hook 'my/cedet-hook)
;; (add-hook 'scheme-mode-hook 'my/cedet-hook)
;; (add-hook 'emacs-lisp-mode-hook 'my/cedet-hook)
;; (add-hook 'erlang-mode-hook 'my/cedet-hook)


;; ################################################################################
;; ################################################################################
;; ################################################################################


;; ;; Semantic
;; (global-semantic-idle-completions-mode t) ;; might need to disable this!
;; ;; (global-semantic-decoration-mode t) ;; throws warnings as hell!
;; (global-semantic-highlight-func-mode t)
;; ;; (global-semantic-show-unmatched-syntax-mode nil)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;; load contrib library
;; (require 'eassist)


;; ;; c mode only
;; (defun my/c-mode-cedet-hook ()
;;   (local-set-key "\C-ct" 'eassist-switch-h-cpp)
;;   (local-set-key "\C-xt" 'eassist-switch-h-cpp)
;;   )

;; (add-hook 'c-mode-hook 'my/c-mode-cedet-hook)
;; (add-hook 'c++-mode-hook 'my/c-mode-cedet-hook)

;; (when (cedet-ectag-version-check t)
;;   (semantic-load-enable-primary-ectags-support))

;; ;; SRecode
;; (global-srecode-minor-mode 1)


;; ;; Setup JAVA....


;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; +++++++++++++++++++++++++++ GLOBAL KEYS ++++++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; ;; (global-set-key [(control return)] 'semantic-ia-complete-symbol)
;; ;; (global-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
;; ;; (global-set-key "\C-c>" 'semantic-complete-analyze-inline)
;; ;; (global-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)

;; ;; ;; bind eassist-list-message
;; ;; (global-set-key (kbd (concat prefix-command-key " h") 'semantic-analyze-proto-impl-toggle)
;; ;; (global-set-key (kbd (concat prefix-command-key " i") 'semantic-ia-fast-jump)
;; ;; (global-set-key (kbd (concat prefix-command-key " o") 'semantic-mrub-switch-tags)
;; ;; (global-set-key (kbd (concat prefix-command-key " l") 'semantic-decoration-include-visit)

;; ;; (global-set-key (kbd (concat prefix-command-key " f") 'eassist-list-methods)
;; ;; (global-set-key (kbd "C-c s") 'eassist-switch-h-cpp )
;; ;; (global-set-key (kbd "C-c u") 'speedbar-update-contents)
;; ;; (global-set-key (kbd "C-c f") 'speedbar-get-focus)

;; ;; (global-set-key (kbd (concat prefix-command-key " d") 'semantic-ia-show-doc)
;; ;; (global-set-key (kbd (concat prefix-command-key " s") 'semantic-ia-show-summary)
;; ;; (global-set-key (kbd (concat prefix-command-key " <left>") 'semantic-tag-folding-fold-block)
;; ;; (global-set-key (kbd (concat prefix-command-key " <right>") 'semantic-tag-folding-show-block)

;; (defun ac-semantic-construct-candidates (tags)
;;   "Construct candidates from the list inside of tags."
;;   (apply 'append
;;          (mapcar (lambda (tag)
;;                    (if (listp tag)
;;                        (let ((type (semantic-tag-type tag))
;;                              (class (semantic-tag-class tag))
;;                              (name (semantic-tag-name tag)))
;;                          (if (or (and (stringp type)
;;                                       (string= type "class"))
;;                                  (eq class 'function)
;;                                  (eq class 'variable))
;;                              (list (list name type class))))))
;;                  tags)))


;; (defvar ac-source-semantic-analysis nil)
;; (setq ac-source-semantic
;;       `((sigil . "b")
;;         (init . (lambda () (setq ac-source-semantic-analysis
;;                                  (condition-case nil
;;                                      (ac-semantic-construct-candidates (semantic-fetch-tags))))))
;;         (candidates . (lambda ()
;;                         (if ac-source-semantic-analysis
;;                             (all-completions ac-target (mapcar 'car ac-source-semantic-analysis)))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; cedet_config.el ends here
