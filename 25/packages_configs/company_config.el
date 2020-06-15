

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++ Company Auto Completion Configuration ++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(require 'company)

;; bind C-n and C-p
(define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)
(define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)


(defun complete-or-indent ()
  (interactive)
  (if (company-manual-begin)
      (company-complete-common)
    (indent-according-to-mode)))


(define-key company-active-map (kbd "TAB") 'company-complete-selection)
;; (define-key company-active-map (kbd "TAB") 'complete-or-indent)

;; Add Yasnippet
;; (add-to-list 'company-backends 'company-yasnippet)

;; immediate completion
(setq company-idle-delay 0.1)
(setq company-minimum-prefix-length 3)

;; start completion using company
;; (add-hook 'after-init-hook 'global-company-mode)


;; ngram
;; (with-eval-after-load 'company-ngram
;;   ; ~/data/ngram/*.txt are used as data
;;   (setq company-ngram-data-dir "~/.emacs.d/ngram")
;;   ; company-ngram supports python 3 or newer
;;   (setq company-ngram-python "python3")
;;   (company-ngram-init)
;;   (cons 'company-ngram-backend company-backends)
;;   ; or use `M-x turn-on-company-ngram' and
;;   ; `M-x turn-off-company-ngram' on individual buffers
;;   ;
;;   ; save the cache of candidates
;;   (run-with-idle-timer 3600 t
;;                        (lambda ()
;;                          (company-ngram-command "save_cache")
;;                          ))
;;   )
;; (require 'company-ngram nil t)

;; Statistics

;; (require 'company-statistics)
;; (company-statistics-mode)

;; global activation of the unicode symbol completion
;; (add-to-list 'company-backends 'company-math-symbols-unicode)

;; fuzzy
;; (require 'company-fuzzy)
;; (global-company-fuzzy-mode 1)

(setq company-eclim-auto-save nil)          ; Stop eclim auto save.
(setq company-dabbrev-downcase nil)         ; No downcase when completion.
(setq company-tooltip-align-annotations t)  ; Align annotation to the right side.


;; ;; doc info
;; (require 'company-quickhelp)
;; (company-quickhelp-mode)

