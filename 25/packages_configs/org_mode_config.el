

;; (load-file "org_gnome_calendar.el")

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ ORG CONFIG ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(require 'org)
(require 'org-agenda)

;; active Babel languages

;; see http://orgmode.org/worg/org-contrib/babel/languages.html
;; see http://orgmode.org/manual/Languages.html#Languages
;; and see: http://orgmode.org/manual/Evaluating-code-blocks.html


;; (setq org-latex-default-packages-alist
;;       '(("hidelinks" "hyperref" nil)))

(org-babel-do-load-languages
 (quote org-babel-load-languages)
 (quote ((emacs-lisp . t)
         (dot . t)
         (ditaa . t)
         (R . t)
         (python . t)
         (ruby . t)
         (gnuplot . t)
         (clojure . t)
         (shell . t)
         (ledger . t)
         (org . t)
         (plantuml . t)
         (latex . t))))

;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((gnuplot . t)))
;; add additional languages with '((language . t)))


;; persistent clocking
(setq org-clock-persisnt 'history)
(org-clock-persistence-insinuate)

(global-set-key (kbd "C-c C-x C-x") 'org-clock-in-last)
(global-set-key (kbd "C-c C-x C-j") 'org-clock-goto)
(global-set-key (kbd "C-c C-x C-o") 'org-clock-out)


;; do not show prewarnings when also scheduled, but x days before the deadline
(setq org-agenda-skip-deadline-prewarning-if-scheduled 3)

;; format string used when creating CLOCKSUM lines and when generating a
;; time duration (avoid showing days)
(setq org-time-clocksum-format
      '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))


;; requiore export to taksjuggler
(require 'ox-taskjuggler)


;; require for export to pdf
;; (require 'ox-groff)

;; easy follow links
(setq org-return-follows-link t)

;; open text files in org mode
(add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))

;; open unknown files in org mode
(setq-default major-mode 'org-mode)

;; Insert source code
(defun org-insert-src-block (src-code-type)
  "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
  (interactive
   (let ((src-code-types
          '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
            "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
            "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
            "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
            "scheme" "sqlite")))
     (list (ido-completing-read "Source code type: " src-code-types))))
  (progn
    (newline-and-indent)
    (insert (format "#+BEGIN_SRC %s\n" src-code-type))
    (newline-and-indent)
    (insert "#+END_SRC\n")
    (previous-line 2)
    (org-edit-src-code)
    ))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++ CAPTURE/REMEMBER ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq org-mode-capture-directory "~/Documents/planning/default.org")
(setq org-agenda-files '("~/Documents/planning"))

(setq org-default-notes-file org-mode-capture-directory)


;; automatically clock in and resume after finishing capture mode
(setq org-capture-templates
      (append '(("c" "Clocked Task" entry
                 (file+headline org-mode-capture-directory "Tasks")
                 "* TODO %^{Name of Task} %^g     \nAdded: %U  %i\n  %?\n"
                 :clock-in t :clock-resume t))))

(setq org-default-notes-file "~/Documents/planning/default.org")
(define-key global-map "\C-cr" 'org-capture)

(setq org-capture-templates
      (append '(("l" "Ledger entries")
                ("ld" "Debit/Credit Card" plain
                 (file "~/Documents/planning/accounting.ledger")
                 "%(org-read-date) %^{Payee}
  Liabilities:Debit Card
  Expenses:%^{Account}  %^{Amount}
")
                ("lc" "Cash" plain
                 (file "~/Documents/planning/accounting.ledger")
                 "%(org-read-date) * %^{Payee}
  Expenses:Cash
  Expenses:%^{Account}  %^{Amount}
")
                ("g" "Google Calendar")
                ("gd" "Event in default calendar" plain
                 (file "~/Documents/planning/default.org")
                 "* %^{Subject}
%^T

%^{Description}")
                ;;                 ("gu" "Event in university calendar" plain
                ;;                   (file "~/Documents/planning/university.org")
                ;;                   "* %^{Subject}
                ;; %^T

                ;; %^{Description}")
                )
              org-capture-templates))

;; (setq org-capture-templates nil)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ OTHER STUFF +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq org-ditaa-jar-path (concat package-folder "java_files/ditaa0_9.jar"))
(setq org-plantuml-jar-path (concat package-folder "java_files/plantuml.jar"))

(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)


                                        ; Make babel results blocks lowercase
(setq org-babel-results-keyword "results")

(defun bh/display-inline-images ()
  (condition-case nil
      (org-display-inline-images)
    (error nil)))


                                        ; Do not prompt to confirm evaluation
                                        ; This may be dangerous - make sure you understand the consequences
                                        ; of setting this -- see the docstring for details
(setq org-confirm-babel-evaluate nil)

                                        ; Use fundamental mode when editing plantuml blocks with C-c '
(add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ Autocompletion +++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(require 'org-ac)
(setq org-ac/ac-trigger-command-keys '("\\" "SPC" ":" "[" "+"))
(org-ac/config-default)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++++ MINOR MODE +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; MINOR MODE HOOK
(defun my/org-minor-mode ()
  "Minor mode hook for Org."

  (local-set-key (kbd "C-c C-x s") 'org-insert-src-block)

  (local-set-key (kbd "C-x SPC") 'org-latex-export-to-pdf)


  ;; add auto-complete mode
  ;; (add-to-list 'ac-sources 'ac-source-abbrev)          ;; edited
  ;; ;; (add-to-list 'ac-sources 'ac-source-css-property)
  ;; (add-to-list 'ac-sources 'ac-source-dictionary)
  ;; ;; (add-to-list 'ac-sources 'ac-source-eclim)
  ;; (add-to-list 'ac-sources 'ac-source-yasnippet)
  ;; ;; (add-to-list 'ac-sources 'ac-source-symbols)
  ;; ;; (add-to-list 'ac-sources 'ac-source-filename)
  ;; ;; (add-to-list 'ac-sources 'ac-source-files-in-current-dir)
  ;; ;; (add-to-list 'ac-sources 'ac-source-gtags)
  ;; ;; (add-to-list 'ac-sources 'ac-source-etags)
  ;; ;; (add-to-list 'ac-sources 'ac-source-imenu) ;; broken !!!
  ;; ;; (add-to-list 'ac-sources 'ac-source-semantic) ;; slows down auto complete)
  ;; ;; (add-to-list 'ac-sources 'ac-source-semantic-raw ;; slows down auto complete)
  ;; ;; (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  ;; (add-to-list 'ac-sources 'ac-source-words-in-buffer)
  ;; ;; (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)

  ;; (auto-complete-mode)

  )

(add-hook 'org-mode-hook 'my/org-minor-mode)

(setq org-startup-indented t)


(add-to-list 'org-latex-classes
             '("letter"
               "\\documentclass{letter}
               [DEFAULT-PACKAGES]
               [PACKAGES]
               [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


(add-to-list 'org-latex-classes
             '("scrlttr2"
               "\\documentclass{scrlttr2}
                \\usepackage{ngerman}
                \\usepackage[utf8]{inputenc}
                \\usepackage[T1]{fontenc}
                \\usepackage{textcomp}
                \\RequirePackage{graphicx}

                % if you have a word with just uppercase letter you should use the package soul
                % for better readability
                \\usepackage{soul}
                \\sodef\\so{}{.14em}{.4em plus.1em minus .1em}{.4em plus.1em minus .1em}


                % do not indent the signature
                \\renewcommand*{\\raggedsignature}{\\raggedright}


               [DEFAULT-PACKAGES]
               [PACKAGES]
               [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


(add-to-list 'org-latex-classes
             '("ds"
               "[NO-DEFAULT-PACKAGES]
               [NO-PACKAGES]
               [NO-EXTRA]"
               ("\\subsection{%s}" . "\\section*{%s}")
               ("\\subsubsection{%s}" . "\\subsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
               ("\\textbf{%s}" . "\\textbf{%s}")))

(add-to-list 'org-latex-classes
             '("empty"
               "[NO-DEFAULT-PACKAGES]
               [NO-PACKAGES]
               [NO-EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("clseminar"
               "\\documentclass{clseminar}
               [DEFAULT-PACKAGES]
               [PACKAGES]
               [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("plmmthesis"
               "\\documentclass{plmmthesis}
               [DEFAULT-PACKAGES]
               [PACKAGES]
               [EXTRA]"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("plmseminar"
               "\\documentclass{plmseminar}
               [DEFAULT-PACKAGES]
               [PACKAGES]
               [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


(add-to-list 'org-latex-classes
             '("clbthesis"
               "\\documentclass{clbthesis}
               [DEFAULT-PACKAGES]
               [PACKAGES]
               [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


(add-to-list 'org-latex-classes
             '("clmthesis"
               "\\documentclass{clmthesis}
               [DEFAULT-PACKAGES]
               [PACKAGES]
               [EXTRA]"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("clpthesis"
               "\\documentclass{clpthesis}
               [DEFAULT-PACKAGES]
               [PACKAGES]
               [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("cltreport"
               "\\documentclass{cltreport}
               [DEFAULT-PACKAGES]
               [PACKAGES]
               [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("cltexpose"
               "\\documentclass{cltexpose}
               [DEFAULT-PACKAGES]
               [PACKAGES]
               [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ DEFAULT KEYS +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; (if org-gcal-client-id
;;     (add-to-list 'emacs-startup-hook 'org-gcal-sync))

(defun org-save-all-org-buffers ()
  "Save all Org buffers without user confirmation."
  (interactive)
  (message "Saving all Org buffers...")
  (save-some-buffers t (lambda () (derived-mode-p 'org-mode)))
  (when (featurep 'org-id) (org-id-locations-save))
  (message "Saving all Org buffers... done")
  (when org-gcal-client-id (org-gcal-sync)))

(defun org-gcal-sync-and-open-agenda ()
  "Calls org-gcal-sync and then org-agenda"
  (interactive)
  (org-gcal-sync)
  (org-agenda))

(global-set-key "\C-ca" 'org-gcal-sync-and-open-agenda)
(global-set-key (kbd (concat prefix-command-key " C-c")) 'org-capture) ;;  define keystroke
(global-set-key (kbd (concat prefix-command-key " C-a")) 'org-gcal-sync-and-open-agenda) ;;  define keystroke
;; (global-set-key "\C-cb" 'org-iswitchb)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ Open files in ... ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(eval-after-load "org"
  '(progn
     ;; .txt files aren't in the list initially, but in case that changes
     ;; in a future version of org, use if to avoid errors
     (if (assoc "\\.txt\\'" org-file-apps)
         (setcdr (assoc "\\.txt\\'" org-file-apps) "notepad.exe %s")
       (add-to-list 'org-file-apps '("\\.txt\\'" . "notepad.exe %s") t))
     ;; Change .pdf association directly within the alist
     (setcdr (assoc "\\.pdf\\'" org-file-apps) "evince %s")))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ Org Mobile Setup ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(setq org-mobile-inbox-for-pull "~/.grive/index.org")


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ LATEX EXPORT ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
        "bibtex %b"
        "pdflatex -interaction nonstopmode -output-directory %o %f"
        "pdflatex -interaction nonstopmode -output-directory %o %f"))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++++++ eldoc ++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; (org-eldoc-hook-setup) ;; have org-eldoc add itself to `org-mode-hook'


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++ org mode and cua mode ++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(require 'org-cua-dwim)
(org-cua-dwim-activate)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++ DIARY SUNSET AND SUNRISE ++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(setq calendar-latitude 47.6667)
(setq calendar-longitude 11.2)
(setq calendar-location-name "Innsbruck, Austria")


(defun cus/org-agenda-only-today (fn)
  "Show the result of calling FN in the agenda for today."
  (if (equal date (calendar-current-date))
      (funcall fn)))


(autoload 'solar-sunrise-sunset "solar.el")
(autoload 'solar-time-string "solar.el")
(defun diary-sunrise ()
  "Local time of sunrise as a diary entry.
The diary entry can contain `%s' which will be replaced with
`calendar-location-name'."
  (let ((l (solar-sunrise-sunset date)))
    (when (car l)
      (concat
       (if (string= entry "")
           "Sunrise"
         (format entry (eval calendar-location-name))) " "
       (solar-time-string (caar l) nil)))))

(defun diary-sunset ()
  "Local time of sunset as a diary entry.
The diary entry can contain `%s' which will be replaced with
`calendar-location-name'."
  (let ((l (solar-sunrise-sunset date)))
    (when (cadr l)
      (concat
       (if (string= entry "")
           "Sunset"
         (format entry (eval calendar-location-name))) " "
       (solar-time-string (caadr l) nil)))))


(defun sa-ignore-headline (contents backend info)
  "Ignore headlines with tag `ignoreheading'."
  (when (and (org-export-derived-backend-p backend 'latex 'html 'ascii)
             (string-match "\\`.*ignoreheading.*\n"
                           (downcase contents)))
    (replace-match "" nil nil contents)))

(add-to-list 'org-export-filter-headline-functions 'sa-ignore-headline)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ Latex Export ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; rather do that for each file separately in header!!!
;; (setq org-latex-listings-options
;; '(("basicstyle" "\\small")
;;   ;; ("keywordstyle" "\\color{black}\\bfseries\\underbar")
;;   ("basicstyle" "\\footnotesize")
;;   ("breakatwhitespace" "false")
;;   ("breaklines" "true")
;;   ("captionpos" "b")
;;   ("deletekeywords" "{...}")
;;   ("escapeinside" "{\\%*}{*)}")
;;   ("extendedchars" "true")
;;   ("frame" "single")
;;   ("keepspaces" "true")
;;   ;; ("keywordstyle" "\\color{blue}")
;;   ("otherkeywords" "{*,...}")
;;   ("numbers" "left")
;;   ("numbersep" "5pt")
;;   ("numberstyle" "\\tiny\\color{black}")
;;   ("rulecolor" "\\color{black}")
;;   ("showspaces" "false")
;;   ("showstringspaces" "false")
;;   ("showtabs" "false")
;;   ("stepnumber" "1")
;;   ("tabsize" "2")))
