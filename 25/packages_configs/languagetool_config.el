
(setq languagetool-java-arguments '("-Dfile.encoding=UTF-8")
        languagetool-console-command "/usr/share/java/languagetool/languagetool-commandline.jar"
        languagetool-server-command "/usr/share/java/languagetool/languagetool-server.jar")

(setq languagetool-java-arguments '("-Dfile.encoding=UTF-8"
                                    "-cp" "/usr/share/languagetool:/usr/share/java/languagetool/*")
      languagetool-console-command "org.languagetool.commandline.Main"
      languagetool-server-command "org.languagetool.server.HTTPServer")
