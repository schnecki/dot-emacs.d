;;; shm_config.el ---
;;
;; Filename: shm_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Thu Sep  4 21:24:24 2014 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Mon Nov  3 20:26:15 2014 (+0100)
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
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

(require 'shm)
(require 'shm-case-split)

(defun my/haskell-shm-minor-mode ()
  "Minor mode hook for shm-mode for Haskell."
  (define-key shm-map (kbd "C-c C-s") 'shm/case-split)
  (define-key shm-map (kbd "C-x C-k") 'shm/kill-region)
  (define-key shm-map (kbd "C-w") 'shm/backward-kill-word))

(add-hook 'haskell-mode-hook 'my/haskell-shm-minor-mode)

;;; add it to haskell mode
(add-hook 'haskell-mode-hook 'structured-haskell-mode)

;;; customize keymap
(define-key shm-map (kbd "M-;") 'paredit-comment-dwim)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; shm_config.el ends here
