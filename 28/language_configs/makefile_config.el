;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++ FIX MAKEFILE TAB BUG IN 24.2 +++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(defadvice whitespace-cleanup (around whitespace-cleanup-indent-tab
                                      activate)
  "Fix whitespace-cleanup indent-tabs-mode bug"
  (let ((whitespace-indent-tabs-mode indent-tabs-mode)
        (whitespace-tab-width tab-width))
    ad-do-it))


(setq-default indent-tabs-mode nil)
(add-hook 'after-save-hook 'whitespace-cleanup)
