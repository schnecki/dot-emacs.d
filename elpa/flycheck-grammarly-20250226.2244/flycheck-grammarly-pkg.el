;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "flycheck-grammarly" "20250226.2244"
  "Grammarly support for Flycheck."
  '((emacs     "27.1")
    (flycheck  "0.14")
    (grammarly "0.3.0")
    (s         "1.12.0"))
  :url "https://github.com/emacs-grammarly/flycheck-grammarly"
  :commit "34ee0901e1de05b0c60208293c8beb9a4587e5c7"
  :revdesc "34ee0901e1de"
  :keywords '("convenience" "grammar" "check")
  :authors '(("Jen-Chieh" . "jcs090218@gmail.com"))
  :maintainers '(("Jen-Chieh" . "jcs090218@gmail.com")))
