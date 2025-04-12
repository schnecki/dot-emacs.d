(add-to-list 'tramp-methods
  '("qsub"
    (tramp-login-program        "qsub")
    (tramp-login-args           (("-I"))) ; other options here?
    ;; Local $SHELL could be a nasty one, like zsh or fish.  Let's override it.
    (tramp-login-env            (("SHELL") ("/bin/sh")))
    (tramp-remote-shell         "/bin/sh")
    (tramp-remote-shell-args    ("-c"))
    (tramp-connection-timeout   10)))
