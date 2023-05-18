;;; jdee_config.el ---
;;
;; Filename: jdee_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: So Okt 13 13:22:28 2013 (+0200)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Tue Mar 29 11:13:48 2016 (+0200)
;;           By: Manuel Schneckenreither
;;     Update #: 396
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ JDEE CONFIG +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; On Windows wget is not available.
(setq jde-help-remote-file-exists-function '("beanshell"))

(add-to-list 'load-path (concat package-folder "jdee-2.4.1/lisp"))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++ Java Version (JDK Version) +++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; See customize section in init.el for following variables:
;; '(jde-compile-option-directory "./../classes")
;; '(jde-compiler (quote ("javac")))
;; '(jde-global-classpath (quote ("./../classes" "./../lib")))
;; '(jde-jdk (quote ("1.8")))
;; '(jde-jdk-registry (quote (("1.8" . "/usr/lib/jvm/java-default-runtime"))))
;; '(jde-sourcepath (quote ("./src/main" "./src/test")))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++ General +++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; ENABLE JDE FOR JAVA FILES
(autoload 'jde-mode "jde" "JDE mode" t)
(setq auto-mode-alist
      (append '(("\\.java\\'" . jde-mode)) auto-mode-alist))
(load "jde-autoload")


;; (push 'jde-mode ac-modes)

(setq jde-check-version-flag nil)
;; (setq jde-compile-option-directory
;;    (concat user-emacs-directory "/tmp"))

(defalias 'dired-rename-file 'rename-file)

(require 'gud)

(defun jde-my-minor ()
  (progn

    (add-to-list 'ac-sources 'ac-source-semantic)

    ;; (gtags-mode t)
    ;; (auto-complete-mode t)
    ;; (add-to-list 'ac-sources ac-source-gtags)
    (local-set-key [f1] 'jde-help-symbol)
    ;; (local-set-key [f8] 'gud-next)
    ;; (local-set-key [f9] 'gud-cont)
    ;; (local-set-key (kbd "M-/") 'hippie-expand)
    (local-set-key (kbd "M-n") 'jde-complete-minibuf)

    (local-set-key (kbd "C-c i") 'jde-import-find-and-import)

    ;; locally overwrite build command
    ;; (local-set-key (kbd "C-c C-v C-b") 'compile-closest-Makefile)

    ;; (add-hook 'before-save-hook
    ;;           (lambda ()
    ;;             ;; (jde-import-all)
    ;;             ;; (jde-import-organize)
    ;;             ;; (jde-import-kill-extra-imports)
    ;;             )
    ;;           nil t)
    ;; (add-hook 'after-save-hook 'jde-compile nil t)


    ))

(add-hook 'jde-mode-hook 'jde-my-minor)


;; (require 'jde-help)
;; ;; w3 fail to load local file, so skip this feature
;; (defmethod jde-jdhelper-show-url ((this jde-jdhelper) url)
;;   (let ((doc-url (jde-url-name url)))
;;     (message "Displaying %s from %s"
;;              (oref url :class)
;;              (oref (oref url :docset) :description))
;;     (jde-jdhelper-show-document this doc-url)))


;; JUNIT
;; (setq jde-junit-testrunner-type "org.junit.runner.JUnitCore")
(setq jde-junit-testrunner-type "org.junit.runner.JUnitCore")

;; FIX PROJECT SETUP
(load-file (concat package-folder "jdee-2.4.1/lisp/jde-project-file.el"))

(setq jde-project-text
      "(jde-project-file-version \\\"1.0\\\")
(jde-set-variables
'(jde-compile-option-directory \\\"./classes\\\")
'(jde-sourcepath (quote (\\\"./src/main\\\" \\\"./src/test\\\" \\\"./src\\\")))
'(jde-global-classpath (quote (\\\"./classes\\\" \\\"./lib\\\" \\\"~/Programmierung/Java/JUnit/*\\\"))))")


(defun jde-save-project ()
  "Saves source file buffer options in one or more project files.
This command provides an easy way to create and update a project file
for a Java project. Simply open a source file, set the desired
options, using the JDE Options menu, then save the settings in the
project file, using this command.  Now, whenever you open a source
file from the same directory tree, the saved settings will be restored
for that file."
  (interactive)
  (let* ((directory-sep-char ?/) ;; Override NT/XEmacs setting
    (project-file-paths (jde-find-project-files default-directory)))
    (if (not project-file-paths)
    (setq project-file-paths
          (list (expand-file-name jde-project-file-name
                      (read-file-name "Save in directory: "
                              default-directory
                              default-directory)))))
    ;; (jde-save-project-internal project-file-paths)


    (shell-command
     (concat "echo \"" jde-project-text "\" > "
             (expand-file-name (nth 0 project-file-paths) jde-project-file-name)))
    ;; (message (expand-file-name (nth 0 project-file-paths) jde-project-file-name))
    ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; jdee_config.el ends here
