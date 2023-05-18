;;; custom_themes.el ---
;;
;; Filename: custom_themes.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Mo Feb 24 14:01:15 2014 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Fr Mär  7 11:52:16 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 48
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

;; copied from color-theme-high-contrast theme
;; see http://shallowsky.com/dotfiles/.emacs-lisp/color-theme.el
(defun color-theme-bright-environment ()
  "High contrast color theme, maybe for the visually impaired.
Watch out!  This will set a very large font-size!

If you want to modify the font as well, you should customize variable
`color-theme-legal-frame-parameters' to \"\\(color\\|mode\\|font\\|height\\|width\\)$\".
The default setting will prevent color themes from installing specific
fonts."
  (interactive)
  (color-theme-standard)
  (let ((color-theme-is-cumulative t))
    (color-theme-install
     '(color-theme-bright-environment
       ((cursor-color . "red")
	(width . 300)
	(height . 100)
	(background . dark))

       (default ((t (:stipple nil :background "white" :foreground "magenta" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight ultrabold :height 3000 :width medium :family "adobe-courier"))))

       (bold ((t (:bold t :underline t))))
       (bold-italic ((t (:bold t :underline t))))
       (font-lock-builtin-face ((t (:bold t :foreground "red"))))
       (font-lock-comment-face ((t (:bold t :foreground "firebrick"))))
       (font-lock-constant-face ((t (:bold t :underline t :foreground "blue"))))
       (font-lock-function-name-face ((t (:bold t :foreground "blue4"))))
       (font-lock-keyword-face ((t (:bold t :foreground "dark magenta"))))
       (font-lock-string-face ((t (:bold t :foreground "green4"))))
       (font-lock-type-face ((t (:bold t :foreground "blue"))))
       (font-lock-variable-name-face ((t (:bold t :foreground "chocolate2"))))
       (font-lock-warning-face ((t (:bold t :foreground "red"))))
       (highlight ((t (:background "light gray" :foreground "white" :bold 1))))
       (info-menu-5 ((t (:underline t :bold t))))
       (info-node ((t (:bold t))))
       (info-xref ((t (:bold t ))))
       (italic ((t (:bold t :underline t))))
       (modeline ((t (:background "white" :foreground "black" :bold 1))))
       (modeline-buffer-id ((t (:background "white" :foreground "black" :bold 1))))
       (modeline-mousable ((t (:background "white" :foreground "black" :bold 1))))
       (modeline-mousable-minor-mode ((t (:background "white" :foreground "black" :bold 1))))
       (region ((t (:background "black" :foreground "white" :bold 1))))
       (secondary-selection ((t (:background "black" :foreground "white" :bold 1))))
       (underline ((t (:bold t :underline t))))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom_themes.el ends here
