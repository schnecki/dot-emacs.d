;;; emacs.el ---
;;
;; Filename: emacs.el
;; Status:
;; Author: Manuel Schneckenreither
;; Created: Tue Dec 11 00:43:14 2012 (+0100)
;; Version:
;; Last-Updated: Sun Feb  7 15:19:34 2021 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 498
;; URL:
;; Description:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++ BASICS ++++++++++++++++++++++++++++++++
;; ++++++++++++++ which means no extra package needed +++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(load (concat load-folder "basics.el"))
;; custom themes
(load (concat load-folder "custom_themes.el"))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ Special Packages ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; WINNER MODE - undo window configurations (needs to be done before ECB)
;; (load (concat package-conf-folder "winner_mode_config.el"))
;; CEDET - semantic, EDE, etc. (needs to be done pretty early!)
;; (load (concat package-conf-folder "cedet_config.el"))
;; EDE - project management in emacs
(load (concat package-conf-folder "ede_config.el"))
;; ECB - buffers on the side showing information
;; (load (concat package-conf-folder "ecb_config.el"))
;; Eldoc config
(load (concat package-conf-folder "eldoc_config.el"))
;; FLYCHECK -- automatic syntax checking on-the-fly
(load (concat package-conf-folder "flycheck_config.el"))
;; FLYSPELL -- automatic spell checking on-the-fly
(load (concat package-conf-folder "flyspell_config.el"))
;; HEADER 2 - Enter a header in the files
(load (concat package-conf-folder "header2_config.el"))
;; IDO - minibuffer helper
;; (load (concat package-conf-folder "ido_config.el"))
;; MULTIPLE CURSORS - use multiple cursors to edit the buffers
(load (concat package-conf-folder "multiple_cursors_config.el"))
;; THESAURUS - choose synonym and replace
(load (concat package-conf-folder "thesaurus_config.el"))
;; WINDOW NUMBER MODE - change windows by C-x C-j [NUMBER] or  META-[NUMBER]
(load (concat package-conf-folder "window-number_config.el"))
;; YASNIPPET - snippets easily handled
(load (concat package-conf-folder "yasnippet_config.el"))
;; JDEE Mode - Java mode - NOT TESTED, RATHER USE ECLIM!
;; (load (concat package-conf-folder "jdee_config.el"))
;; eclim for Java
;; (load (concat package-conf-folder "eclim_config.el"))
;; RAINBOW DELIMITERS - show parenthesis in different colors
(load (concat package-conf-folder "rainbow_del_config.el"))
;; ;; RAINBOW MODE - background of color names in specified color (kills org-mode agenda colors)
;; (load (concat package-conf-folder "rainbow_mode_config.el"))
;; ORG Mode - organize everything
(load (concat package-conf-folder "org_mode_config.el"))
;; AUTO COMPLETE - completion - You should not enable this, unless
;; you know what you are doing -- SEE COMPANY MODE
;; (load (concat package-conf-folder "auto_complete_config.el"))
;; WHITESPACE MODE -- mark 80'th+ columns
(load (concat package-conf-folder "whitespace_config.el"))
;; MAKE BACKUPS
(load (concat package-conf-folder "backup_each_save_config.el"))
;; MAGIT - git for emacs
(load (concat package-conf-folder "magit_config.el"))
;; DIRED - file mangement for emacs
(load (concat package-conf-folder "dired_config.el"))
;; DIRED PLUS - extension function for dired
;; (load (concat package-conf-folder "diredp_config.el")) -- not available no more
;; PAGER -- better scrolling
(load (concat package-conf-folder "pager_config.el"))
;; POWERLINE - better modline
(load (concat package-conf-folder "powerline_config.el"))
;; ANDROID MODE
;; (load (concat package-conf-folder "android_mode_config.el"))
;; BBDB - Address-Book Management (load before GNUS)
(load (concat package-conf-folder "bbdb_config.el"))
;; GNUS - Newsreader and Email Client
(load (concat package-conf-folder "gnus_config.el"))
;; CUA - use rectangle selections
(load (concat package-conf-folder "cua_config.el"))
;; BOOKMARKS+ - bookmark extendsion, multiple desktops
(load (concat package-conf-folder "bmkp_config.el"))
;; ACE JUMP Mode - quickly jump to the right position in the buffer
(load (concat package-conf-folder "ace_jump_config.el"))
;; PRINTING - set printing defaults
(load (concat package-conf-folder "printing_config.el"))
;; MPC - a mpd (which is a music player server) client
(load (concat package-conf-folder "mpc_config.el"))
;; EXPAND REGION - expand the region in (semantic) units
(load (concat package-conf-folder "expand_region_config.el"))
;; CHANGE INNER - kill inside/outside of given element
;; (load (concat package-conf-folder "change_inner_config.el"))
;; SHM - structured haskell code editing
;; (load (concat package-conf-folder "shm_config.el"))
;; Paredit - emacs lisp structured code editing
(load (concat package-conf-folder "paredit_config.el"))
;; Function args - show function arguments for C/C++ code
(load (concat package-conf-folder "function_args_config.el"))
;; Helm - narrowing framework
(load (concat package-conf-folder "helm_config.el"))
;; Ivy and Counsel mode (much better performance than helm)
(load (concat package-conf-folder "counsel_config.el"))
;; Cdlatex - fast input methods for LaTeX environments
(load (concat package-conf-folder "cdlatex_config.el"))
;; undo tree
(load (concat package-conf-folder "undotree_config.el"))
;; company mode -- auto completion -- set auto-completion-mode
(load (concat package-conf-folder "company_config.el"))
;; load django
(load (concat package-conf-folder "python_django_config.el"))
;; load ESS
(load (concat package-conf-folder "ess_config.el"))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++ Load Language Specific Settings +++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(load-file (concat language-conf-folder "c_config.el"))
(load-file (concat language-conf-folder "r_config.el"))
(load-file (concat language-conf-folder "haskell_config.el"))
(load-file (concat language-conf-folder "elm_config.el"))
(load-file (concat language-conf-folder "java_config.el"))
(load-file (concat language-conf-folder "emacs_lisp_config.el"))
(load-file (concat language-conf-folder "ocaml_config.el"))
(load-file (concat language-conf-folder "makefile_config.el"))
(load-file (concat language-conf-folder "latex_config.el"))
(load-file (concat language-conf-folder "octave_config.el"))
(load-file (concat language-conf-folder "bash_config.el"))
(load-file (concat language-conf-folder "python_config.el"))
(load-file (concat language-conf-folder "php_config.el"))
(load-file (concat language-conf-folder "matlab_config.el"))
;; (load-file (concat language-conf-folder "flex_config.el"))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ LOAD KEYBINDINGS ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(load (concat load-folder "basic_keys.el"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; emacs.el ends here
