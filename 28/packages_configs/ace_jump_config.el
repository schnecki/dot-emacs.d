;;; ace_jump_config.el ---
;;
;; Filename: ace_jump_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Fr Mär 28 01:37:14 2014 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Wed Oct 22 21:15:08 2014 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 15
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
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


(require 'ace-window)

;; set ace jump cursor config
;; (global-set-key (kbd "C-c SPC") 'ace-jump-mode)
(global-set-key (kbd "M-p") 'ace-jump-mode)
(global-set-key (kbd "C-c b") 'ace-jump-mode-pop-mark)


;; set window config
;;(global-set-key (kbd "M-p") 'ace-window)
(global-set-key (kbd "C-x o") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))


;; set buffer switching to ace-jump-buffer
(global-set-key (kbd "C-c C-b") 'ace-jump-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ace_jump_config.el ends here
