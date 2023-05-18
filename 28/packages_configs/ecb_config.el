;;; ecb_config.el ---
;;
;; Filename: ecb_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: So Okt 13 16:30:34 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Fri Aug 29 16:26:38 2014 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 11
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


;; START ECB, BUT WITHOUT THE TIP OF THE DAY
(require 'ecb)
(ecb-byte-compile)
(setq ecb-tip-of-the-day nil)
;; (ecb-activate)


;; rest of ecb config can be found in init.el
;; under BASIC INFO in custom-set-variables!


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ MY LAYOUTS ++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; normally user-defined layouts are loaded from ~/.ecb...

(ecb-layout-define "left-methods-sources" left nil
  (if (fboundp (quote ecb-set-methods-buffer)) (ecb-set-methods-buffer) (ecb-set-default-ecb-buffer))
  (dotimes (i 2) (other-window 1) (if (equal (selected-window) ecb-compile-window) (other-window 1)))
  (ecb-split-ver 0.7083333333333334 t)
  (if (fboundp (quote ecb-set-methods-buffer)) (ecb-set-methods-buffer) (ecb-set-default-ecb-buffer))
  (dotimes (i 1) (other-window 1) (if (equal (selected-window) ecb-compile-window) (other-window 1)))
  (dotimes (i 2) (other-window 1) (if (equal (selected-window) ecb-compile-window) (other-window 1)))
  (if (fboundp (quote ecb-set-sources-buffer)) (ecb-set-sources-buffer) (ecb-set-default-ecb-buffer))
  (dotimes (i 1) (other-window 1) (if (equal (selected-window) ecb-compile-window) (other-window 1)))
  (dotimes (i 1) (other-window -1) (if (equal (selected-window) ecb-compile-window) (other-window -1)))
  (if (fboundp (quote ecb-set-methods-buffer)) (ecb-set-methods-buffer) (ecb-set-default-ecb-buffer))
  (dotimes (i 1) (other-window 1) (if (equal (selected-window) ecb-compile-window) (other-window 1)))
  (if (fboundp (quote ecb-set-sources-buffer)) (ecb-set-sources-buffer) (ecb-set-default-ecb-buffer))
  (dotimes (i 2) (other-window 1) (if (equal (selected-window) ecb-compile-window) (other-window 1)))
  (dotimes (i 2) (other-window 1) (if (equal (selected-window) ecb-compile-window) (other-window 1)))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ecb_config.el ends here
