
(setq ess-root-path (file-name-as-directory (concat package-folder "ess-18.10.2/lisp")))
(add-to-list 'load-path ess-root-path)

(require 'ess-site)

;; (require 'ess-site)
(require 'ess-r-mode)
(add-to-list 'auto-mode-alist '("\\.R\\'" . r-mode))
(setq ess-use-flymake nil) ;; disable Flymake


(load-file (concat package-folder "ess-R-data-view.el"))
(require 'ess-R-data-view)

;; MINOR MODE HOOK
(defun my/ess-minor-mode ()
  "Minor mode hook for ESS."

  (define-key ess-mode-map (kbd "C-x SPC") 'ess-R-dv-pprint)
  ;; (define-key ess-mode-map (kbd "F1") 'ess-help)
  (local-set-key [f1] 'ess-help) ;; find man page
  (company-mode-on)
  ;; (eldoc-mode)
  )

(setq ess-r--no-company-meta t)

(add-hook 'ess-mode-hook 'my/ess-minor-mode)
(add-hook 'ess-post-run-hook 'ess-tracebug)

;; (setq display-buffer-alist
;;       `(("*R Dired"
;;          (display-buffer-reuse-window display-buffer-in-side-window)
;;          (side . right)
;;          (slot . -1)
;;          (window-width . 0.33)
;;          (reusable-frames . nil))
;;         ("*R"
;;          (display-buffer-reuse-window display-buffer-at-bottom)
;;          (window-width . 0.5)
;;          (reusable-frames . nil))
;;         ("*Help"
;;          (display-buffer-reuse-window display-buffer-in-side-window)
;;          (side . right)
;;          (slot . 1)
;;          (window-width . 0.33)
;;          (reusable-frames . nil))))
