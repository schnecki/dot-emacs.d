;;; eldoc_config.el --- 
;; 
;; Filename: eldoc_config.el
;; Description: 
;; Author: Manuel Schneckenreither
;; Maintainer: 
;; Created: Fr Okt  4 21:14:20 2013 (+0200)
;; Version: 
;; Package-Requires: ()
;; Last-Updated: Wed Oct 22 21:53:16 2014 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 8
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

(require 'eldoc)

(defun turn-on-eldoc ()
  "Force 'eldoc-mode' on using a positive arg.  For use in hooks."
   (interactive)
   (eldoc-mode 1))

 (defun tal-eldoc-function ()
  "Returns a documentation string appropriate for the current context or nil."
  (let ((begin (point))
        (count -1)
        (word))
    ;; if thing-at-point has a doc string, return it, we're done.
    (if (and (setq word (thing-at-point 'symbol))
             (setq word (symbol-value (intern-soft (upcase word)
                                                   tal-eldoc-obarray))))
        word
      ;; Otherwise see if we're within (parens) and if so, count the
      ;; number of commas between point and the open paren.
      (save-excursion
        (when (and (condition-case ()
                       (or (backward-up-list) t)
                     (error nil))
                   (eq ?\( (char-after))) 
          (skip-syntax-backward "-")
          (if (setq word (thing-at-point 'symbol))
              (while (progn (setq count (1+ count))
                            (search-forward "," begin t))))))
      ;; if the word prior to the open paren has a doc string use it.
      (when (and word
                 (setq word (copy-sequence
                             (symbol-value 
                              (intern-soft (upcase word)
                                           tal-eldoc-obarray)))))
        ;; if the doc string has an open paren, highlight the word (if
        ;; any) that follows the same number of comma's counted above.
        (when (and (> count -1)
                   (string-match
                    "(" word
                    ;; this tries to skip parens from int(32) type
                    ;; proc/subproc declarations.
                    (string-match ")\\s-\\(sub\\)?proc\\b" word)))
          (while (and (> count 0)
                      (string-match "," word (match-end 0))
                      (setq count (1- count))))
          (when (= count 0)
            (if (string-match "\\w+\\(:\\w+\\)?" word (match-end 0))
                ;; found something needing to be made bold
                (put-text-property (match-beginning 0) (match-end 0)
                                   'face 'bold word))))
        word))))

;; (turn-on-eldoc)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++++ ELDOC MODE +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(eldoc-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; eldoc_config.el ends here
