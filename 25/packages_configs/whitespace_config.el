;;; column_marker_config.el ---
;;
;; Filename: column_marker_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Mo Okt 14 18:48:42 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Tue Jan 26 22:37:02 2021 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 39
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
;; +++++++++++++++++++++++++ WHITESPACE MODE ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; (require 'whitespace)
;; ;; highlight all columns > 80 (default value)
;; ;; (setq whitespace-style '(face empty tabs lines-tail trailing))
;; (setq whitespace-style '(face tabs lines-tail trailing))

;; (setq whitespace-line-column 100)
;; (setq-default fill-column 100)

;; (global-whitespace-mode t)


(require 'fill-column-indicator)
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; column_marker_config.el ends here
