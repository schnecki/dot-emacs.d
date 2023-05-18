;;; package -- flycheck_config.el ---
;;; Commentary:
;;
;; Filename: flycheck_config.el
;; Status:
;; Author: Manuel Schneckenreither
;; Created: Mo Sep  2 22:29:02 2013 (+0200)
;; Version:
;; Last-Updated:
;;           By:
;;     Update #: 30
;; URL:
;; Description:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ FLYCHECK COONFIG ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(require 'flycheck)

;; Enable flycheck for all buffers
(global-flycheck-mode t)

;; HASKELL
;; set in customize-set-variables in init.el

;; LEDGER
;; (eval-after-load 'flycheck '(require 'flycheck-ledger))

;; FLYCHECK MODE LINE COLOR
(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)

;; Haskell setup
;; (eval-after-load 'flycheck
;;  '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))

;; (eval-after-load 'flycheck '(require 'flycheck-hdevtools))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; flycheck_config.el ends here
