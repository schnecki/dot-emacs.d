;; flyspell_config.el ---
;;
;; Filename: flyspell_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Fr Okt  4 20:40:17 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Mon Mar 15 19:11:14 2021 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 150
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

;; (require 'flyspell-lazy)
;; (flyspell-lazy-mode 1)

(require 'ispell)
(require 'flyspell)

;; AUTOMATICALLY GUESS DICTIONARY
(require 'auto-dictionary)
(add-hook 'flyspell-mode-hook (lambda () (auto-dictionary-mode 1)))

;; call every now and then
;; (setq flyspell-delay 1)

;; If on Windows use aspell
;; (if (fboundp 'w32-send-sys-command)
;;     (setq-default ispell-program-name "c:\\Program Files\\Aspell\\bin\\aspell.exe"))

;; (add-hook 'flyspell-mode-hook #'flyspell-local-vars)
;; (defun flyspell-local-vars ()
;;   (add-hook 'hack-local-variables-hook #'flyspell-buffer))

;; MINOR MODE HOOK
(defun my/flyspell-minor-mode ()
  "Minor mode hook for flyspell."

  ;; KEYS
  (local-set-key (kbd (concat prefix-command-key "s w")) 'ispell-word)
  (local-set-key (kbd (concat prefix-command-key "s b")) 'flyspell-buffer)
  (local-set-key (kbd "C-;") 'flyspell-correct-previous)

  )

;; global set key to enable/disable flyspell mode
(global-set-key (kbd (concat prefix-command-key "s m")) 'flyspell-mode)
(global-set-key (kbd (concat prefix-command-key "s p")) 'flyspell-prog-mode)

(add-hook 'flyspell-mode-hook 'my/flyspell-minor-mode)

;; load mode hook
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'markdown-mode-hook 'flyspell-mode)
(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'message-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'haskell-mode-hook 'flyspell-prog-mode)
(add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode)

(defun flyspell-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
         (change (if (string= dic "german") "english"
                   (if (string= dic "english")
                       "spanish" "german"))))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))

(global-set-key (kbd "<f8>") 'flyspell-switch-dictionary)

;; fix key
;; (eval-after-load "flyspell"
;;   '(define-key flyspell-mode-map (kbd "C-.") nil))

;; (eval-after-load "flyspell"
;;   '(define-key flyspell-mode-map (kbd "C-.") 'view-tag-other-window)
;;   )

(eval-after-load "flyspell"
  '(define-key flyspell-mode-map (kbd "C-c C-.") nil))

(setq flyspell-issue-message-flag nil)

(eval-after-load "flyspell"
  '(define-key flyspell-mode-map (kbd "C-M-i") nil))

(eval-after-load "flyspell"
  '(define-key flyspell-mode-map (kbd "C-.") nil))


;; (add-hook 'jde-mode-hook (lambda () (flyspell-mode))) ;; prog for
;; (add-hook 'tcl-mode-hook 'flyspell-mode)

;; (add-hook 'org-mode-hook (lambda () (flyspell-mode)))
;; (add-hook 'c++-mode-hook (lambda () (flyspell-mode)))
;; (add-hook 'c-mode-hook (lambda () (flyspell-mode)))
;; (add-hook 'emacs-lisp-mode-hook (lambda () (flyspell-mode)))
;; (add-hook 'haskell-mode-hook (lambda () (flyspell-mode)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; flyspell_config.el ends here
