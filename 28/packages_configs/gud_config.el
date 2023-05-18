

;; Configuration for the Debugger gud

(setq gdb-many-windows t)

;; open many windows when loading gud
(add-hook 'gud-mode-hook 'gdb-many-windows)
