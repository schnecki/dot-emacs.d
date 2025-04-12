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
                        (split-string default-directory "app")
                      (if (string-match "src/" default-directory)
                          (split-string default-directory "src")
                        (if (string-match "/R/" default-directory)
                            (split-string default-directory "/R/")
                          (if (string-match "analysis/" default-directory)
                              (split-string default-directory "analysis")
                            (if (string-match "analisis/" default-directory)
                                (split-string default-directory "analisis")
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
    (message (concat "dir: " dir))
    (setq esdir (string-replace " " "\\\\ " dir))
    (shell-command
     (concat "cd " esdir " && find " esdir " -name \"*.r\" -o -name \"*.R\" -o -name \"*.Rd\" -o -name \"*.rd\" | etags - 1>/dev/null 2>/dev/null") nil)
    (visit-tags-table (concat esdir "/TAGS")))
  )


;; R MODE
(defun my-r-mode-hook ()
  (add-hook 'after-save-hook 'make-r-tags nil t) )

;; (setq auto-mode-alist
;;       (cons '("\\.r$" . ess-r-mode) auto-mode-alist))


;; add hook
(add-hook 'r-mode-hook 'my-r-mode-hook)
(add-hook 'ess-r-mode-hook 'my-r-mode-hook)


;; use Air to format the content of the file
(defun run-air-on-r-save ()
  "Run Air after saving .R files and refresh buffer."
  (when (and (stringp buffer-file-name)
             (string-match "\\.R$" buffer-file-name))
    (let ((current-buffer (current-buffer)))
      (shell-command (concat "air format " buffer-file-name))
      ;; Refresh buffer from disk
      (with-current-buffer current-buffer
        (revert-buffer nil t t)))))

(add-hook 'after-save-hook 'run-air-on-r-save)
