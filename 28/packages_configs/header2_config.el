;;; header2_config.el ---
;;
;; Filename: header2_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Wed Oct  1 11:54:44 2014 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Wed Oct  1 15:34:56 2014 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 3
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


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ HEADER 2 CONFIG +++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; AUTOMATIC INSTERT HEADER ON FILE SAVE
(require 'header2)
(add-hook 'write-file-hooks 'auto-update-file-header)

(setq header-free-software "")
