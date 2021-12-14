;;; r_config.el ---
;;
;; Filename: r_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Fr Feb  7 00:07:46 2021 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Wed Nov 10 22:05:00 2021 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 149
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


;; Create and set tags table
(defun make-r-tags ()
  "This function reloads the tags by using the command 'make tags'."
  (interactive)
  (let ((dir (nth 0 (if (string-match "app/" default-directory)
o                        (split-string default-directory "app")
                      (if (string-match "src/" default-directory)
                          (split-string default-directory "src")
                        (if (string-match "/R/" default-directory)
                            (split-string default-directory "/R/")
                          (if (string-match "shared/" default-directory)
                              (split-string default-directory "shared")
                            (if (string-match "exp/" default-directory)
                                (split-string default-directory "exp")
                              (if (string-match "analysis/" default-directory)
                                  (split-string default-directory "analysis")
                                (if (string-match "fay-shared/" default-directory)
                                    (split-string default-directory "fay-shared")
                                  (if (string-match "cbits/" default-directory)
                                      (split-string default-directory "cbits")
                                    (if (string-match "examples/" default-directory)
                                        (split-string default-directory "examples/")
                                      (if (string-match "bench/" default-directory)
                                          (split-string default-directory "bench/")
                                        (split-string default-directory "test"))
                                      ))))))))))))
    (setq esdir (replace-regexp-in-string " " "\\\\ " (concat dir "/")))
    (message (concat "esdir: " esdir))
    (setq tagslst '()) ;; '("."))
    (if (file-exists-p (concat esdir "src")) (add-to-list 'tagslst "src"))
    (if (file-exists-p (concat esdir "shared")) (add-to-list 'tagslst "shared"))
    (if (file-exists-p (concat esdir "test")) (add-to-list 'tagslst "test"))
    (if (file-exists-p (concat esdir "app")) (add-to-list 'tagslst "app"))
    (if (file-exists-p (concat esdir "exp")) (add-to-list 'tagslst "exp"))
    (if (file-exists-p (concat esdir "examples")) (add-to-list 'tagslst "examples"))
    (if (file-exists-p (concat esdir "fay")) (add-to-list 'tagslst "fay"))
    (if (file-exists-p (concat esdir "fay_shared")) (add-to-list 'tagslst "fay_shared"))
    (setq dirs (mapconcat 'identity tagslst " "))
    (message (concat "dirs: " dirs))
    (shell-command
     (concat "cd " esdir " && find " dirs " -name \"*.r\" -o -name \"*.R\" -o -name \"*.Rd\" -o -name \"*.rd\" | etags - 1>/dev/null 2>/dev/null") nil)
    ;; (concat "cd " esdir
    ;;         ;; " && hasktags --ignore-close-implementation -e --cache . 2>/dev/null 1>/dev/null") nil)
    ;;         " && hasktags -e --ignore-close-implementation "
    ;;         dirs
    ;;         ;; " 2>/dev/null 1>/dev/null"
    ;;         ) nil)
    (visit-tags-table (concat esdir "TAGS")))
  )


;; R MODE
(defun my-r-mode-hook ()
  (add-hook 'after-save-hook 'make-r-tags nil t) )

(setq auto-mode-alist
      (cons '("\\.r$" . ess-r-mode) auto-mode-alist))


;; add hook
(add-hook 'r-mode-hook 'my-r-mode-hook)
(add-hook 'ess-r-mode-hook 'my-r-mode-hook)
