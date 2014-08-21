;;; yasnippet_config.el --- 
;; 
;; Filename: yasnippet_config.el
;; Description: 
;; Author: Manuel Schneckenreither
;; Maintainer: 
;; Created: So Okt 13 20:37:05 2013 (+0200)
;; Version: 
;; Package-Requires: ()
;; Last-Updated: So Okt 13 21:03:44 2013 (+0200)
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
;;; Code:



;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++++ YASNIPPET ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(require 'yasnippet)



(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"            ;; personal snippets
        ))


;; (global-set-key [(tab)] 'yas/expand)

;; do afterwars
(yas-global-mode 1)



(defun ac-yasnippet-candidates ()
  (with-no-warnings
(cond (;; 0.8 onwards
       (fboundp 'yas-active-keys)
       (all-completions ac-prefix (yas-active-keys)))
      (;; >0.6.0
       (fboundp 'yas/get-snippet-tables)
       (apply 'append (mapcar 'ac-yasnippet-candidate-1
                  (condition-case nil
                  (yas/get-snippet-tables major-mode)
                (wrong-number-of-arguments
                 (yas/get-snippet-tables)))))
       )
      (t
       (let ((table
          (if (fboundp 'yas/snippet-table)
          ;; <0.6.0
          (yas/snippet-table major-mode)
        ;; 0.6.0
        (yas/current-snippet-table))))
     (if table
         (ac-yasnippet-candidate-1 table)))))))

(defalias 'yas/current-snippet-table 'yas--get-snippets-table)

;; ;; If you use yasnippet from 'auto-complete', add
;; (yas-set-ac-modes)
;; (yas-enable-emacs-lisp-paren-hack)
;; before 'auto-complete' settings.

;; (require 'auto-complete-yasnippet)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; yasnippet_config.el ends here