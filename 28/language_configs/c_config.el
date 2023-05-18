;;; c_config.el ---
;;
;; Filename: c_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Fr Feb  7 00:07:46 2014 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Mon Oct 12 16:07:55 2015 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 93
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


(require 'cc-mode);

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++ SETTINGS FOR C LIKE LANGUAGES+++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; preferences
(c-set-offset 'substatement-open 0)
(c-set-offset 'case-label '+)
(c-set-offset 'arglist-cont-nonempty '+)
(c-set-offset 'arglist-intro '+)
(c-set-offset 'topmost-intro-cont '+)


;; CONFIGURE ELDOC INCLUDES
;; (setq c-eldoc-includes   "pkg-config gtk+-2.0 --cflags` -I./ -I../ ")

;; C-MODE HOOK
(setq auto-mode-alist (cons '("\.cl$" . c-mode) auto-mode-alist)) ;; OPENCL

;; (add-hook 'c-mode-hook 'turn-on-eldoc-mode)

;; Create and set tags table
(defun make-c-tags ()
  "This function reloads the tags by using the command 'make tags'."
  (interactive)
  (let ((dir (nth 0 (split-string default-directory "src"))))
    (setq esdir (replace-regexp-in-string " " "\\\\ " dir))
    (shell-command
     (concat "cd " esdir " && find . -name \"*.c\" -o -name \"*.h\" -o -name \"*.cpp\" -o -name \"*.hpp\" | etags - 1>/dev/null 2>/dev/null") nil)
    (message (concat "cd " esdir " && find . -name \"*.c\" -o -name \"*.h\" -o -name \"*.cpp\" -o -name \"*.hpp\" | etags - 1>/dev/null 2>/dev/null") nil)
    (visit-tags-table (concat dir "TAGS"))))

(require 'auto-complete-config)
(require 'auto-complete-c-headers)
(require 'auto-complete)


;; (setq ac-clang-flags (split-string "-I/usr/include/c++/4.9.1"))


;; C MODE
(defun my-c-mode-hook ()


  ;; add auto-complete mode
  (add-to-list 'ac-sources 'ac-source-semantic) ;; slows down auto complete)
  (add-to-list 'ac-sources 'ac-source-abbrev)
  ;; (add-to-list 'ac-sources 'ac-source-css-property)
  ;; (add-to-list 'ac-sources 'ac-source-dictionary)
  ;; (add-to-list 'ac-sources 'ac-source-eclim)
  (add-to-list 'ac-sources 'ac-source-yasnippet)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  ;; (add-to-list 'ac-sources 'ac-source-symbols)
  ;; (add-to-list 'ac-sources 'ac-source-filename)
  ;; (add-to-list 'ac-sources 'ac-source-files-in-current-dir)
  ;; (add-to-list 'ac-sources 'ac-source-gtags)
  (add-to-list 'ac-sources 'ac-source-etags)
  (add-to-list 'ac-sources 'ac-source-imenu)


  ;; (add-to-list 'ac-sources 'ac-source-semantic-raw) ;; slows down auto complete)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-buffer)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)


  ;; (setq ac-sources (append '(ac-source-semantic) ac-sources))

  ;; enable semantic for auto complete mode
  (semantic-mode t)

  ;; enable auto completion. If it doesn't work try to disable flyspell mode.
  (auto-complete-mode)

  ;; use programming flyspell mode
  (flyspell-prog-mode)

  ;; start auto completion after entering a dot: .
  (local-set-key (kbd ".") (lambda ()
                             (interactive)
                             (progn
                               (insert ".")
                               ;; (if (not (auto-complete-mode))
                               ;;     (auto-complete-mode t))
                               (auto-complete)
                               ;; (semantic-ia-complete-tip (point))
                               )))

  ;; start auto completion after entering >
  (local-set-key (kbd ">") (lambda ()
                             (interactive)
                             (progn
                               (insert ">")
                               ;; (if (not (auto-complete-mode))
                               ;;     (auto-complete-mode t))
                               (auto-complete)
                               ;; (semantic-ia-complete-tip (point))
                               )))

  (add-hook 'after-save-hook 'make-c-tags nil t)

  )

;; add hook
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)
(define-key c-mode-map (kbd "M-o")  'fa-show)
(define-key c++-mode-map (kbd "M-o")  'fa-show)


;;; flycheck
(add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++11")))
(add-hook 'c-mode-hook (lambda () (setq flycheck-clang-language-standard "c99")))
;; (add-hook 'c-mode-hook (lambda () (setq flycheck-clang-include-path "-l/usr/include/gtkmm-3.0 -l/usr/include/gdkmm-3.0 -l/usr/include/glibmm-2.4 -pthread -I/usr/include/gtkmm-3.0 -I/usr/lib/gtkmm-3.0/include -I/usr/include/atkmm-1.6 -I/usr/include/gtk-3.0/unix-print -I/usr/include/gdkmm-3.0 -I/usr/lib/gdkmm-3.0/include -I/usr/include/giomm-2.4 -I/usr/lib/giomm-2.4/include -I/usr/include/pangomm-1.4 -I/usr/lib/pangomm-1.4/include -I/usr/include/glibmm-2.4 -I/usr/lib/glibmm-2.4/include -I/usr/include/gtk-3.0 -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -I/usr/include/gtk-3.0 -I/usr/include/gio-unix-2.0/ -I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/cairomm-1.0 -I/usr/lib/cairomm-1.0/include -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/include/harfbuzz -I/usr/include/freetype2 -I/usr/include/harfbuzz -I/usr/include/libdrm -I/usr/include/libpng16 -I/usr/include/sigc++-2.0 -I/usr/lib/sigc++-2.0/include -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng16 -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include ")))

