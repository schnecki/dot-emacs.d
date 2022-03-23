;;; yasnippet_config.el ---
;;
;; Filename: yasnippet_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: So Okt 13 20:37:05 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Mon Dec 17 14:45:54 2018 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 31
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

;; additional snippets directories
;; (setq yas-snippet-dirs (append yas-snippet-dirs
;;                                '("~/.emacs.d/snippets/")))

(setq yas-snippet-dirs '("~/.emacs.d/snippets/"))

;; do afterward
(yas-global-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; yasnippet_config.el ends here
