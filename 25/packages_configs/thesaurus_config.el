;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ THESAURUS CONFIG ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; THESAURUS - SYNONYM FINDER
;; (require 'thesaurus)
;; (setq thesaurus-bhl-api-key thesaurus_api_key)  ;; from registration


;; ;; KEYS search synonym
;; (define-key global-map (kbd (concat prefix-command-key " s s"))
;;   'thesaurus-choose-synonym-and-replace)


(require 'synonymous)


(define-key global-map (kbd (concat prefix-command-key " s s"))
  'synonymous-synonyms)


(define-key global-map (kbd (concat prefix-command-key " s a"))
  'synonymous-antonyms)
