
;; (require 'languagetool)

;; (setq languagetool-java-arguments '("-Dfile.encoding=UTF-8")
;;         languagetool-console-command "/usr/share/java/languagetool/languagetool-commandline.jar"
;;         languagetool-server-command "/usr/share/java/languagetool/languagetool-server.jar")

;; (setq languagetool-java-arguments '("-Dfile.encoding=UTF-8"
;;                                     "-cp" "/usr/share/languagetool:/usr/share/java/languagetool/*")
;;       languagetool-console-command "org.languagetool.commandline.Main"
;;       languagetool-server-command "org.languagetool.server.HTTPServer")


(setq languagetool-java-arguments '("-Dfile.encoding=UTF-8")
        languagetool-console-command "~/.emacs.d/29/packages/LanguageTool-6.3/languagetool-commandline.jar"
        languagetool-server-command "~/.emacs.d/29/packages/LanguageTool-6.3/languagetool-server.jar")

(setq languagetool-java-arguments '("-Dfile.encoding=UTF-8"
                                    "-cp" "/usr/share/languagetool:/usr/share/java/languagetool/*")
      languagetool-console-command "org.languagetool.commandline.Main"
      languagetool-server-command "org.languagetool.server.HTTPServer")


(use-package flycheck-languagetool
  :ensure t
  :hook (text-mode . flycheck-languagetool-setup)
  :init
  (setq flycheck-languagetool-server-jar "~/.emacs.d/29/packages/LanguageTool-6.3/languagetool-server.jar"))
