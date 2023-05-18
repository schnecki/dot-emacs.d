;;; column_marker_config.el ---
;;
;; Filename: column_marker_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Mo Okt 14 18:48:42 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Wed Apr 20 09:42:40 2016 (+0200)
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
;; +++++++++++++++++++++++++ WHITESPACE MODE ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(require 'whitespace)
;; highlight all columns > 80 (default value)
;; (setq whitespace-style '(face empty tabs lines-tail trailing))
(setq whitespace-style '(face  tabs lines-tail trailing))

(setq whitespace-line-column 83)
(setq-default fill-column 83)

(global-whitespace-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; column_marker_config.el ends here
