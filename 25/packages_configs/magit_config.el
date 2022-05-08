

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ MAGIT KEYS ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; I could not get magit running under Windows in a short test...you
;; might need to invest a little bit of time
(if (fboundp 'w32-send-sys-command)
    (setq magit-git-executable "git.exe")
  )

;; pull short
;; (with-eval-after-load 'magit
;; 	(define-key magit-define-global-key-bindings
;; 	(global-set-key (kbd (concat prefix-command-key " g p"))
;;                 'magit-pull))

;; pull long
;; (global-set-key (kbd (concat prefix-command-key " g p u l"))
;;                 'magit-pull)

;; push short
;; (global-set-key (kbd (concat prefix-command-key " g h"))
;;                 'magit-push)

;; push long
;; (global-set-key (kbd (concat prefix-command-key " g p u s"))
;;                 'magit-push)

;; ;; git log
;; (global-set-key (kbd (concat prefix-command-key " g l"))
;;                 'magit-log)

;; git status
(global-set-key (kbd (concat prefix-command-key " g s"))
                'magit-status)

