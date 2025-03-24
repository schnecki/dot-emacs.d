;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "flycheck-grammarly" "20250101.849"
  "Grammarly support for Flycheck."
  '((emacs     "25.1")
    (flycheck  "0.14")
    (grammarly "0.3.0")
    (s         "1.12.0"))
  :url "https://github.com/emacs-grammarly/flycheck-grammarly"
  :commit "3cb1853bcdf62856604a081c0d88ae09d69f1601"
  :revdesc "3cb1853bcdf6"
  :keywords '("convenience" "grammar" "check")
  :authors '(("Jen-Chieh" . "jcs090218@gmail.com"))
  :maintainers '(("Jen-Chieh" . "jcs090218@gmail.com")))
