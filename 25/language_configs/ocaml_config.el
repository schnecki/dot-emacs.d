;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ OCAML MODE ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; OCAML HOOK
(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)
(add-hook 'tuareg-mode-hook 'flymake-tuareg-load)
(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode)
                ("\\.fp$" . tuareg-mode)
                ("\\.ocaml$" . tuareg-mode)
                ("\\.raml$" . tuareg-mode))
              auto-mode-alist))
