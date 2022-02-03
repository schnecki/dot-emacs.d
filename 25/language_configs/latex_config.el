;;; latex_config.el ---
;;
;; Filename: latex_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Sa Nov  2 16:14:09 2013 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Fri Apr 23 10:30:10 2021 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 222
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


(load-file (concat package-folder "tex_texify/tex_texify.el"))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ LATEX CONFIG ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq preview-auto-cache-preamble nil)
(setq TeX-PDF-mode t)
(setq-default TeX-master nil)


(require 'tex-site)
(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase Mode" t)
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
;; (add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;; Activate nice interface between RefTeX and AUCTeX
(setq reftex-plug-into-AUCTeX t)


(setq LaTeX-eqnarray-label "eq"
      LaTeX-equation-label "eq"
      LaTeX-figure-label "fig"
      LaTeX-table-label "tab"
      LaTeX-myChapter-label "chap"
      TeX-auto-save t
      TeX-newline-function 'reindent-then-newline-and-indent
      TeX-parse-self t
      TeX-style-path
      '("style/" "auto/"
        "/usr/share/emacs21/site-lisp/auctex/style/"
        "/var/lib/auctex/emacs21/"
        "/usr/local/share/emacs/site-lisp/auctex/style/")
      LaTeX-section-hook
      '(LaTeX-section-heading
        LaTeX-section-title
        LaTeX-section-toc
        LaTeX-section-section
        LaTeX-section-label))


;; set tex master by guessing
;;; Code:
(defun guess-TeX-master (filename)
  "Guess the master file for FILENAME from currently open .tex files."
  (let ((candidate nil)
        (filename (file-name-nondirectory filename)))
    (save-excursion
      (dolist (buffer (buffer-list))
        (with-current-buffer buffer
          (let ((name (buffer-name))
                (file buffer-file-name))
            (if (and file (string-match "\\.tex$" file))
                (progn
                  (goto-char (point-min))
                  (if (re-search-forward (concat "\\\\input{" filename "}") nil t)
                      (setq candidate file))
                  (if (re-search-forward (concat "\\\\include{" (file-name-sans-extension filename) "}") nil t)
                      (setq candidate file))))))))
    (if candidate
        (message "TeX master document: %s" (file-name-nondirectory candidate)))
    candidate))


;; sync between evince and emacs auctex
(setq TeX-source-correlate-mode t)

;; start correlate server
(setq TeX-source-correlate-start-server t)


;; compile and show latex in one command
(defun compile-show-latex ()
  "Compile latex and show in evince."
  (interactive)
  (TeX-texify)
  (TeX-command "View" 'TeX-active-master 0)
  ;; need *.aux for syncing with Evince *.log needed for lookup, *.bbl is needed for
  ;; bibliography
  (shell-command "rm -rf *.blg *.toc *.out *.dvi *.backup *.exl *.exls *.ps" nil)
  )

(setq TeX-view-program-selection
      '((output-html "xdg-open")
        (output-pdf "Evince")
        (output-dvi "Evince")))


(defun make-tex-tags ()
  "This function reloads the tags by using the command 'make tags'."
  (interactive)
  (let ((dir (nth 0 (if (string-match "tikz/" default-directory)
                        (split-string default-directory "tikz")
                      (if (string-match "figures/" default-directory)
                          (split-string default-directory "figures")
                      (if (string-match "proceedings/" default-directory)
                          (split-string default-directory "proceedings")
                      (if (string-match "paper/" default-directory)
                          (split-string default-directory "paper")
                            (split-string default-directory "src"))))))))


    (setq esdir (replace-regexp-in-string " " "\\\\ " dir))
    (async-shell-command
     (concat "cd " esdir " && find . -name \"*.tex\" -not -name \"_*\" -not -name \".*\" | etags - 1>/dev/null 2>/dev/null"))
    (visit-tags-table (concat dir "TAGS"))))

(add-to-list 'display-buffer-alist '("*Async Shell Command*" display-buffer-no-window (nil)))

;; auto completion for auctex
(require 'auto-complete-auctex)


;; MINOR MODE HOOK
(defun my/latex-minor-mode ()
  "Minor mode hook for Latex."

  (TeX-PDF-mode t)
  (setq TeX-master (guess-TeX-master (buffer-file-name)))
  (flyspell-mode)
  ;; (flyspell-buffer)

  ;; enable org-table mode
  (orgtbl-mode)

  ;; auto complete mode
  ;; (add-to-list 'ac-sources 'ac-source-etags)

  ;; (add-to-list 'ac-sources 'ac-source-abbrev)          ;; edited
  ;; ;; (add-to-list 'ac-sources 'ac-source-css-property)
  ;; ;; (add-to-list 'ac-sources 'ac-source-dictionary)
  ;; ;; (add-to-list 'ac-sources 'ac-source-eclim)
  ;; (add-to-list 'ac-sources 'ac-source-yasnippet)
  ;; ;; (add-to-list 'ac-sources 'ac-source-symbols)
  ;; ;; (add-to-list 'ac-sources 'ac-source-filename)
  ;; ;; (add-to-list 'ac-sources 'ac-source-files-in-current-dir)
  ;; ;; (add-to-list 'ac-sources 'ac-source-gtags)
  ;; (add-to-list 'ac-sources 'ac-etags-ac-setup)
  ;; (add-to-list 'ac-sources 'ac-source-imenu)
  ;; ;; (add-to-list 'ac-sources 'ac-source-semantic ;; slows down auto complete)
  ;; ;; (add-to-list 'ac-sources 'ac-source-semantic-raw ;; slows down auto complete)
  ;; ;; (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-buffer)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)
  ;; (add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`
  ;; (add-to-list 'ac-modes 'gams-mode)

  ;; (auto-complete-mode)
  ;; (company-mode)
  (auto-fill-mode)

  ;; create and set tags file
  ;; (add-hook 'after-save-hook 'make-tex-tags nil t)

  ;; add to hook
  ;; (add-hook 'LaTeX-mode-hook 'turn-on-auto-fill nil t)

  ;; set keys
  (local-set-key (kbd "C-x SPC") 'compile-show-latex)

  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  (add-hook 'after-save-hook (lambda () (TeX-texify)) nil 'make-it-local)
  ;; (add-hook 'after-save-hook (lambda () (TeX-command "View" 'TeX-active-master 0)) nil 'make-it-local)
  ;; (add-hook 'after-save-hook (lambda () (funcall-interactively 'compile-show-latex)) nil t)
  ;; (add-hook 'after-save-hook (lambda () (call-interactively 'compile-show-latex-wrapper)) nil t)

  ;; auctex
  (require 'company-auctex)
  (company-auctex-init)

  ;; bibtex
  (require 'company-bibtex)
  (add-to-list 'company-backends 'company-bibtex)

  (company-mode)

;; D company-box        20190311.1745 installed             Company front-end with icons
;; D company-cabal      20170917.1317 installed             company-mode cabal backend
;; D company-ghc        20170918.833  installed             company-mode ghc-mod backend
;; D company-ghci       20190707.311  installed             company backend which uses the current ghci process.
;; D company-quickhelp  20180525.1003 installed             Popup documentation for completion candidates


  )

(add-hook 'TeX-latex-mode 'my/latex-minor-mode)
(add-hook 'LaTeX-mode-hook 'my/latex-minor-mode)
(add-hook 'LaTeX-mode-hook #'tex-smart-umlauts-decode)
(add-hook 'TeX-mode-hook 'my/latex-minor-mode)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ BIBTEX CONFIG ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(defun my/bibtex-minor-mode ()
  "Minor mode for bibtex"

  (add-hook 'before-save-hook 'bibtex-reformat)

  )

(add-hook 'bibtex-mode-hook 'my/bibtex-minor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; latex_config.el ends here
