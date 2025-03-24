;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "jupyter" "20241203.1917"
  "Jupyter."
  '((emacs        "27")
    (cl-lib       "0.5")
    (org          "9.1.6")
    (zmq          "0.10.10")
    (simple-httpd "1.5.0")
    (websocket    "1.9"))
  :url "https://github.com/emacs-jupyter/jupyter"
  :commit "db8a9e233a010a61063f34220821ec76157a2d84"
  :revdesc "db8a9e233a01"
  :authors '(("Nathaniel Nicandro" . "nathanielnicandro@gmail.com"))
  :maintainers '(("Nathaniel Nicandro" . "nathanielnicandro@gmail.com")))
