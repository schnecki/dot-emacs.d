
(require 'dap-hydra)

(add-hook 'dap-stopped-hook
          (lambda (arg) (call-interactively #'dap-hydra)))


(require 'dap-python)

(require 'dap-java)
(require 'dap-firefox)
(dap-firefox-setup)
