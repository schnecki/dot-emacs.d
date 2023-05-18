;;; auto_complete_config.el ---
;;
;; Filename: auto_complete_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: So Okt 13 19:43:26 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Wed Dec  2 15:54:10 2015 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 276
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
;;; Code:

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ SMART TABS MODE +++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(require 'auto-complete)


(define-key ac-completing-map [(tab)] 'ac-complete)
(define-key ac-completing-map "\r" nil) ;; disable completing by enter
(define-key ac-completing-map [return] nil) ;; disable completing by enter
;; (icomplete-mode +1) ;; complete mode in mini-buffer

;; flyspell and ac-complete don't like each other
(ac-flyspell-workaround)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ ETAGS SOURCE  ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; (defface ac-etags-candidate-face
;;   '((t (:background "light sky blue" :foreground "black")))
;;   "Face for etags candidate")

;; (defface ac-etags-selection-face
;;   '((t (:background "blue" :foreground "white")))
;;   "Face for the etags selected candidate.")


;; ;; define a new source for auto complete (source from tags)
;; (defvar ac-source-etags
;;   '((candidates . (lambda ()
;;                     (all-completions ac-target (tags-completion-table))))
;;     (candidate-face . ac-etags-candidate-face)
;;     (selection-face . ac-etags-selection-face)
;;     (requires . 3))
;;   "Source for etags.")


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++ USER OPTIONS, VARIABLES +++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline-p 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue")
;; (define-key ac-completing-map "." 'ac-complete)
;; (define-key ac-completing-map ";" 'ac-stop)
(setq ac-dwim t)
(setq ac-auto-show-menu 0.01)
(setq ac-auto-start t)
(setq ac-delay 0.01)
(setq ac-dictionary-directories (quote ("~/.emacs.d/auto-complete/dict/")))
(setq ac-quick-help-delay 0.1)
(setq ac-ignore-case 0)                 ; be case-sensitive!
(setq ac-use-menu-map t)
(setq ac-candidate-limit 100)  ;; maximize candidate number to prevent delays
(setq ac-use-fuzzy t)          ;; use fuzzy matching

;; use C-p and C-n to navigate in menu
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;; dirty fix for having AC everywhere
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
                           (auto-complete-mode 1))
                       ))

(real-global-auto-complete-mode t)

;; YASNIPPET BUG FIX (IF BROKEN)
;; (setq ac-source-yasnippet nil)


;; configure sources
(ac-config-default)

(custom-set-variables
  '(ac-etags-requires 1))

(eval-after-load "etags"
  '(progn
      (ac-etags-setup)))

;; global sources
(setq-default ac-sources
              '(ac-source-abbrev ;; A source for Emacs abbreviation function. See info emacs Abbrevs about abbreviation function.
                ;; ac-source-css-property ;; A source for CSS property.
                ac-source-dictionary ;; A source for dictionary. See completion by dictionary about dictionary.
                ;; ac-source-eclim ;; A source for Emacs-eclim.
                ;; ac-source-features ;; A source for completing features which are available with (require '.
                ;; ac-source-filename ;; A source for completing file name. Completion will be started after inserting /.
                ;; ac-source-files-in-current-dir ;; A source for completing files in a current directory. It may be useful with eshell.
                ;; ac-source-functions ;; A source for completing Emacs Lisp functions. It is available only after (.
                ;; ac-source-gtags ;; A source for completing tags of Global.
                ;; ac-source-etags ;; locally defined tags completion source
                ac-source-imenu ;; A source for completing imenu nodes. See info emacs imenu for details.
                ;; ac-source-semantic ;; A source for Semantic. It can be used for completing member name for C/C++.
                ;; ac-source-semantic-raw ;; Unlike ac-source-semantic, this source is for completing symbols in a raw namespace.
                ;; ac-source-symbols ;; A source for completing Emacs Lisp symbols.
                ;; ac-source-variables ;; A source for completing Emacs Lisp symbols.
                ;; ac-source-words-in-all-buffer ;; A source for completing words in all buffer.
                ;; ac-source-words-in-buffer ;; A source for completing words in a current buffer.
                ;; ac-source-words-in-same-mode-buffers
                ac-source-yasnippet ;; A source for Yasnippet to complete and expand snippets.
                ))


;; Completion SOURCE FROM ISPELL (needs plain word file at: /usr/share/dict/words)
;; (require 'ispell)
;; (setq ispell-alternate-dictionary ;; '("~/.emacs.d/auto-complete/words/en_US.dic"
;;                                     "~/.emacs.d/auto-complete/words/de_AT.dic")

;; (setq ac-ispell-requires 2)
;; (setq ac-ispell-fuzzy-limit 0)

;; (eval-after-load "ac-ispell"
;;   (ac-ispell-ac-setup))

;; (eval-after-load "auto-complete"
;;   '(progn
;;      (ac-ispell-setup)))


;; (defun my/enable-ac-ispell ()
;;   (add-to-list 'ac-sources 'ac-source-ispell)
;;   )


;; (add-hook 'git-commit-mode-hook 'my/enable-ac-ispell)
;; (add-hook 'mail-mode-hook 'my/enable-ac-ispell)
;; (add-hook 'message-mode-hook 'my/enable-ac-ispell)
;; (add-hook 'TeX-mode-hook 'my/enable-ac-ispell)

;; another try

;; ;; (require 'ispell)

;; ;; (defvar ac-ispell-modes
;; ;;   '(text-mode))

;; ;; (defun ac-ispell-candidate ()
;; ;; (if (memq major-mode ac-ispell-modes)
;; ;; (let ((word (ispell-get-word nil "\\*")))
;; ;;      (setq word (car word))
;; ;;      (lookup-words (concat word "*") ispell-complete-word-dict))))

;; ;; (defvar ac-source-ispell
;; ;;   '((candidates . ac-ispell-candidate)
;; ;;     (requires . 3))
;; ;; "Source for ispell."


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; auto_complete_config.el ends here
