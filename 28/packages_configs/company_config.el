

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


(define-key company-active-map (kbd "TAB") 'complete-or-indent)

;; immediate completion
(setq company-idle-delay 0.01)

;; start completion using company
(add-hook 'after-init-hook 'global-company-mode)
