;;; yasnippet_config.el ---
;;
;; Filename: yasnippet_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: So Okt 13 20:37:05 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Sat Jan  9 21:16:10 2016 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 27
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
;; +++++++++++++++++++++++++++++ YASNIPPET ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(require 'yasnippet)


(setq yas/snippet-dirs
      '("~/.emacs.d/snippets/"))            ;; personal snippets
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets/"))            ;; personal snippets


;; do afterward
(yas-global-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; yasnippet_config.el ends here
