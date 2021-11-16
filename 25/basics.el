;; basics.el ---
;;
;; Filename: basics.el
;; Status:
;; Author: Manuel Schneckenreither
;; Created: Mon Dec 10 22:51:09 2012 (+0100)
;; Version:
;; Last-Updated:Tue Mar 13 15:49:08 2018 (+0100))
;;           By:Manuel Schneckenreitherr
;;     Update #:8723
;; URL:
;; Description:
;;    Basic configuration for emacs. In here are all configs of
;;    components which do not need any packages or languages,
;;    but come with emacs.
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

;; Flymake temp dir
(setq temporary-file-directory "~/.emacs.d/.tmp/")


;; trump hang workaround
;; (setq tramp-ssh-controlmaster-options
;;       "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")
(setq projectile-mode-line "Projectile")

(add-to-list 'backup-directory-alist (cons tramp-file-name-regexp nil))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++ ENSURE PATH IS SET ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ DESKTOP SESSIONS +++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; DESKTOP - Save and restore open buffers, point, mark, histories, other variables
;; (desktop-save-mode 1)

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; files/buffers not to be opened
(setq desktop-buffers-not-to-save
      (concat "\\("
              "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
              "\\|\\.diary\\|^\\.newsrc-dribble\\|\\.bbdb"
              "\\)$"))
;; (add-to-list 'desktop-modes-not-to-save 'dired-mode)
;;(add-to-list 'desktop-modes-not-to-save 'Info-mode)
;;(add-to-list 'desktop-modes-not-to-save 'info-look-up-mode)
;;(add-to-list 'desktop-modes-not-to-save 'fundamental-mode)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ COMPILATION +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; SET RECOMPILE FUNCTION
(setq compilation-last-buffer nil)
(defun compile-again (pfx)
  (interactive "p")
  (if (and (eq pfx 1)
           compilation-last-buffer)
      (progn
        (set-buffer compilation-last-buffer)
        (revert-buffer t t))
    (call-interactively 'compile)))

;; ;; CLOSE/BURY THE COMPILATION WINDOW IF THERE WAS NO ERROR AT ALL.
;; (defun bury-compile-buffer-if-successful (buffer string)
;;  "Bury a compilation buffer if succeeded without warnings "
;;  (when (and
;;          (buffer-live-p buffer)
;;          (string-match "compilation" (buffer-name buffer))
;;          (string-match "finished" string)
;;          (not
;;           (with-current-buffer buffer
;;             (goto-char (point-min))
;;             (search-forward "warning" nil t))))
;;     (run-with-timer 1 nil
;;                     (lambda (buf)
;;                       (bury-buffer buf)
;;                       (switch-to-prev-buffer (get-buffer-window buf) 'kill))
;;                     buffer)))
;; ;; (add-hook 'compilation-exit-message-function 'bury-compile-buffer-if-successful)
;; (add-hook 'compilation-exit-message-function nil)

;; (setq shell-file-name "bash")
;; (setq shell-command-switch "-c")
(setenv "BASH_ENV" "~/.bashrc")

;; Helper for compilation. Close the compilation window if
;; there was no error at all.
(defun compilation-exit-autoclose (status code msg)
  "Close compile window on successful compiliation."

  ;; If M-x compile exists with a 0
  (when (and (eq status 'exit) (zerop code))
    ;; then bury the *compilation* buffer, so that C-x b doesn't go there
    (bury-buffer)
    ;; and delete the *compilation* window
    (delete-window (get-buffer-window (get-buffer "*compilation*")))
    ;; (command-execute 'shell)
    ;; (shell)
    ;; (delete-other-windows)
    ;; (split-window-right)
    ;; (other-window 1)
    ;; (shell)
    ;; (let ((w (split-window-right 1)))
    ;;     (select-window w)
    (shell)
    ;; (switch-to-buffer "*shell*")
    ;; (shell)
    ;; (other-window 1)
    ;; (shell)
    ;; (switch-to-buffer "*shell*")
    )
  ;; Always return the anticipated result of compilation-exit-message-function
  (cons msg code))
;; Specify my function (maybe I should have done a lambda function)
(setq compilation-exit-message-function 'compilation-exit-autoclose)

;; (defun compilation-exit-autoclose (status code msg)
;;   "Automatically close the *compilation* buffer, if the major
;; mode of the invoking window is in
;; `compilation-modes-to-close-window listed."
;;   (interactive)
;;   (let ((this-buffer (current-buffer)))
;;     (let ((cmm (buffer-local-value 'major-mode (other-buffer this-buffer t nil))))

;;       (if (not (equal nil (find cmm compilation-modes-to-close-window)))
;;           (when (and (eq status 'exit) (zerop code))
;;             ;; then bury the *compilation* buffer, so that C-x b doesn't go there
;;             ;; (bury-buffer)
;;             ;; and delete/bury the *compilation* buffer
;;             ;; (replace-buffer-in-windows "*compilation*")
;;             (bury-buffer "*compilation*")
;;             ;; (other-window 1)
;;             ;; (switch-to-buffer "*shell*")
;;             (command-execute 'shell)
;;             (switch-to-buffer "*shell*")
;;             ;; (shell)
;;             ;; (message "compilation successful")
;;             ;; (cons msg code)
;;             )
;;         ;; Otherwise open compilation window. Always return the anticipated result
;;         ;; of compilation-exit-message-function
;;         (cons msg code)
;;         ))));;

;; SPECIFY FUNCTION
;; specified for each language
;; (setq compilation-modes-to-close-window '(jde-mode
;;                                           java-mode
;;                                           c-mode
;;                                           ))
;; (setq compilation-exit-message-function 'compilation-exit-autoclose)
;; (setq compilation-exit-message-function nil)

;; COMPILE CLOSES MAKEFILE
(defun compile-closest-Makefile ()
  (interactive)
  (let* ((dir (loop as d = default-directory then
                    (expand-file-name ".." d) if (file-exists-p (expand-file-name "Makefile" d)) return d))
         (makefile (concat dir "/Makefile"))
         )
    (message (concat "Compiling using Makefile at " makefile))
    (compile (concat "make -C " dir))
    ;; (cd dir)
    ;; (compile "make -C " makefile)
    ))

;; bind compiling with get-above-makefile to f5
(global-set-key [f5] 'compile-closest-Makefile)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++ YES AND NO PROMPTS ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; MAKE YES NO PROMTS TO Y N PROMTS
(defalias 'yes-or-no-p 'y-or-n-p)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++ DISPLAY LINE NUMBERS +++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(require 'linum)
(global-linum-mode) ;; Turn on line numbers
(setq linum-format "%3d")

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ HIGHLIGHT MODE +++++++++++++++++++++++++++=
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(defun highlight-changes-remove-after-save ()
  "Remove previous changes after save."
  (make-local-variable 'after-save-hook)
  (add-hook 'before-save-hook
            (lambda ()
              (highlight-changes-remove-highlight (point-min) (point-max)))))

;; (global-highlight-changes-mode t)
;; (setq highlight-changes-remove-highlight t)
;; (add-hook 'after-save-hook 'highlight-changes-remove-after-save)

;; HIGHLIGH CURRENT LINE
;; (highlight-current-line-minor-mode)

;; Highlight keywords
(defun highlight-keywords ()
  "This function highlights keywords in files."

  (font-lock-add-keywords nil
                          '(("\\<\\(FIXME\\|TODO\\|BUG\\)" 1 font-lock-warning-face t))))


;; common c mode langauges like java, c, c++ are enabled with the
;; following line. All others are enabled in their specific language
;; configuration file, see the language_configs folder.
(add-hook 'c-mode-common-hook 'highlight-keywords)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ TAB SETTINGS ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; TAB WIDTH
(setq-default tab-width 2)
;; (setq whitespace-tab-width 2)
(setq cua-auto-tabify-rectangles nil)

;; SMART TABS
(defadvice align (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice align-regexp (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice indent-relative (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice indent-according-to-mode (around smart-tabs activate)
  (let ((indent-tabs-mode indent-tabs-mode))
    (if (memq indent-line-function
              '(indent-relative
                indent-relative-maybe))
        (setq indent-tabs-mode nil))
    ad-do-it))

(defmacro smart-tabs-advice (function offset)
  `(progn
     (defvaralias ',offset 'tab-width)
     (defadvice ,function (around smart-tabs activate)
       (cond
        (indent-tabs-mode
         (save-excursion
           (beginning-of-line)
           (while (looking-at "\t*\\( +\\)\t+")
             (replace-match "" nil nil nil 1)))
         (setq tab-width tab-width)
         (let ((tab-width fill-column)
               (,offset fill-column)
               (wstart (window-start)))
           (unwind-protect
               (progn ad-do-it)
             (set-window-start (selected-window) wstart))))
        (t
         ad-do-it)))))

;; (smart-tabs-advice c-indent-line c-basic-offset)
;; (smart-tabs-advice c-indent-region c-basic-offset)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ INDENT BUFFER ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; format whole buffer - not bound to any key sequence
(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))


;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++++++ TAGS INFORMATION ++++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; View tags other window - Bound to C-. in basic_keys.el
(defun view-tag-other-window (tagname &optional next-p regexp-p)
  "Same as `find-tag-other-window' but doesn't move the point"
  (interactive (find-tag-interactive "View tag other window: "))
  (let ((window (get-buffer-window)))
    (if (eq 1 (length (visible-frame-list)))
        ;; ( xref-find-definitions-other-window)
        (find-tag-other-window tagname next-p regexp-p)
      (let* ((mypos (seq-position (visible-frame-list) (selected-frame)))
             (otherpos (mod (+ mypos 1) (length (visible-frame-list))))
             (my-frame (elt (visible-frame-list) mypos))
             (target-frame (elt (visible-frame-list) otherpos)))
        (select-frame target-frame)
        (find-tag-other-window tagname next-p regexp-p)
        (recenter 10)
        (delete-other-windows)
        (select-frame my-frame)))))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++ CONFIGURE IN MINIBUFFER INFO ++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
(display-time-mode t)
(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)
(column-number-mode t)
(line-number-mode t)
(size-indication-mode t)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ BACKUP INFO +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; define folders
(defvar autosaves-folder (concat load-emacsd ".tmp/autosaves/"))
(defvar backup-folder (concat load-emacsd ".tmp/backups/"))

;; create the autosave and backup dirs if necessary, since emacs won't.
(make-directory autosaves-folder t)
(make-directory backup-folder t)


;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.tmp/...
(setq auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/.tmp/autosaves/\\1" t)))
      backup-directory-alist (quote ((".*" . "~/.emacs.d/.tmp/backups/")))
      )

(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying nil               ; don't clobber slinks
      version-control t                 ; version numbers for backup files
      delete-old-versions 0             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 32              ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 4096            ; newest versions to keep when a new numbered backup is made (default: 2)
      vc-make-backup-files t            ; make backups even when file is in version control (e.g. git)


      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 60              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 400            ; number of keystrokes between auto-saves (default: 300)
      )


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ CLIPBOARD TRACKING++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq x-select-enable-clipboard t)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ FULLSCREEN ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(defvar my-fullscreen-p t "Check if fullscreen is on or off")

(defun my-non-fullscreen ()
  (interactive)
  (if (fboundp 'w32-send-sys-command)
      ;; WM_SYSCOMMAND restore #xf120
      (w32-send-sys-command 61728)
    (progn (set-frame-parameter nil 'width 82)
           (set-frame-parameter nil 'fullscreen 'fullheight)
           (menu-bar-mode 1))))

(defun my-fullscreen ()
  (interactive)
  (if (fboundp 'w32-send-sys-command)
      ;; WM_SYSCOMMAND maximaze #xf030
      (w32-send-sys-command 61488)
    (set-frame-parameter nil 'fullscreen 'fullboth)
    (menu-bar-mode 0)))

(defun my-toggle-fullscreen ()
  (interactive)
  (setq my-fullscreen-p (not my-fullscreen-p))
  (if my-fullscreen-p
      (my-non-fullscreen)
    (my-fullscreen)))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++ STOP ASKING EXISTING PROCESS EXISTS STUFF +++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++ SHOW KILL RING WHEN YANKING ++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(defun kill-ring-insert ()
  (interactive)
  (let ((to_insert (completing-read "Yank : "
                                    (delete-duplicates kill-ring :test #'equal)
                                    )))
    (when (and to_insert
               (region-active-p))
      ;; the currently highlighted section is to be replaced by the yank
      (delete-region (region-beginning) (region-end)))
    (insert to_insert))
  )


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++ JUMP TO BEGINNING AFTER MATCH IN SEARCHING +++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(defun my-goto-match-beginning ()
  (when (and isearch-forward isearch-other-end (not isearch-mode-end-hook-quit))
    (goto-char isearch-other-end)))
(add-hook 'isearch-mode-end-hook 'my-goto-match-beginning)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ UNIQUIFY MODE +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; display enough information to distinguish buffers with same names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++++ BOOKMARKS ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq
 bookmark-default-file (concat load-emacsd ".bookmarks") ;; keep my ~/ clean
 bookmark-save-flag 1)                        ;; autosave each change

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ KILL PROCESSES ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(defun delete-process-interactive ()
  (interactive)
  (let ((pname (ido-completing-read "Process Name: "
                                    (mapcar 'process-name (process-list)))))

    (delete-process (get-process pname))))

(global-set-key (kbd (concat prefix-command-key "k")) 'delete-process-interactive)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++ SEARCH IMPROVEMENT ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(defadvice isearch-yank-word-or-char (before move-to-beginning-of-word)
  (unless (eq last-command this-command)
    (goto-char (car (bounds-of-thing-at-point 'word)))))
(ad-activate 'isearch-yank-word-or-char)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ Buffer switching ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(defun switch-buffers-between-frames ()
  "switch-buffers-between-frames switches the buffers between the two last frames"
  (interactive)
  (let ((this-frame-buffer nil)
        (other-frame-buffer nil))
    (setq this-frame-buffer (car (frame-parameter nil 'buffer-list)))
    (other-frame 1)
    (setq other-frame-buffer (car (frame-parameter nil 'buffer-list)))
    (switch-to-buffer this-frame-buffer)
    (other-frame 1)
    (switch-to-buffer other-frame-buffer)))

(defun transpose-buffers (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (plusp arg) (1- arg) (1+ arg))))))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ Insert date +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(defun insert-date (prefix)
  "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
  (interactive "P")
  (let ((format (cond
                 ((not prefix) "%d.%m.%Y")
                 ((equal prefix '(4)) "%Y-%m-%d")
                 ((equal prefix '(16)) "%A, %d. %B %Y")))
        (system-time-locale "de_DE"))
    (insert (format-time-string format))))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ Open File as Root ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(defun th-rename-tramp-buffer ()
  (when (file-remote-p (buffer-file-name))
    (rename-buffer
     (format "%s:%s"
             (file-remote-p (buffer-file-name) 'method)
             (buffer-name)))))

(add-hook 'find-file-hook
          'th-rename-tramp-buffer)

(defadvice find-file (around th-find-file activate)
  "Open FILENAME using tramp's sudo method if it's read-only."
  (if (and (not (file-writable-p (ad-get-arg 0)))
           (y-or-n-p (concat "File "
                             (ad-get-arg 0)
                             " is read-only.  Open it as root? ")))
      (th-find-file-sudo (ad-get-arg 0))
    ad-do-it))

(defun th-find-file-sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/sudo::" file))))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ OTHER STUFF +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(if (display-graphic-p)
    (progn
      (menu-bar-mode 1)    ;; MENUBAR
      (tool-bar-mode -1)   ;; REMOVE TOOLBAR
      (scroll-bar-mode -1) ;; REMOVE SCROLLBARS
      ))


;; ENABLE UTF8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; DISABLE GUI DIALOG BOXES
(setq use-dialog-box nil)

;; AUTOMATICALLY RELOAD ALL TAGS WITHOUT ASKING IN A GUI
(setq tags-revert-without-query t)

;; SHOW KEYSTROKES IN MINIBUFFER IMMEDIATELY
(setq echo-keystrokes 0.01)

;; END SENTENCES WITH ONE SPACE, NOT TWO (AFFECTS FILL COMMANDS)
(setq-default sentence-end-double-space nil)

;; LET WEEK START WITH MONDAY (NOT SUNDAY)
(setq calendar-week-start-day '1)

;; TREAT COMPRESSED FILES AS FOLDERS
(auto-compression-mode 1)

;; SET VARIABLE TO PREVENT WINDOW
(setq gnus-registry-install t)

;; SET VALUE
(setq mail-interactive nil)

;; ELECTRIC PARENTHESIS PAIRS
(electric-pair-mode 1)

;; VISUAL LINE MODE - WRAP LONG LINES
(global-visual-line-mode)

;;DON'T ECHO PASSWORDS WHEN COMMUNICATING WITH INTERACTIVE PROGRAMS
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

;; KILL WHOLE LINE AND NEWLINE WITH C-k IF AT BEGINNING OF LINE ¶
(setq kill-whole-line t)

;; ALWAYS USE THE ABSOUTE PATH WHEN VISTITING FILES (GETS RID OF SOME
;; WEIRED BEHAVIOUR)
(setq find-file-visit-truename t)

;; STACK TRACE IN CASE OF AN ERROR
(setq stack-trace-on-error t)

;; FLUSH BLANK LINES
(defun collapse-blank-lines ()
  "Delete blank lines."
  (interactive)
  (save-excursion
    (replace-regexp "^[ ]*\n\\{2,\\}" "\n\n" nil (point-min) (point-max)))
  )

(add-hook 'before-save-hook 'collapse-blank-lines)

;; OPEN MARKDOWN FILES WITH THE MARKDOWN MODE
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

;; ADD NEW LINES WHEN AT END OF BUFFER
(setq next-line-add-newlines t)

;; USE IMENU
(global-set-key (kbd "C-c l") 'imenu)

;; VISIBLE BELL
(setq visible-bell t)

;; SHOW PARENTHESIS
(show-paren-mode t)

;; Octave Mode
(require 'octave)


;; version control darcs repositories
(add-to-list 'vc-handled-backends 'DARCS)
(autoload 'vc-darcs-find-file-hook "vc-darcs")
(add-hook 'find-file-hooks 'vc-darcs-find-file-hook)


;; Send mail to myself in bcc
(defun add-sender-mail-bcc ()
  (interactive)
  (mail-bcc)
  (if (char-equal (char-before (- (point) 1)) ?:)
      (insert (message-fetch-field "From"))
    (progn
      (insert ", ")
      (insert (message-fetch-field "From")))))


;; REPLACE S EXPRESSION
(defun replace-last-sexp ()
  (interactive)
  (let ((value (eval (preceding-sexp))))
    (kill-sexp -1)
    (insert (format "%S" value))))

(global-set-key (kbd (concat prefix-command-key " C-e")) 'replace-last-sexp)

;; MAIL
(setq mail-user-agent 'sendmail-user-agent)
;; (setq mail-self-blind nil) ;; does not work for me, solved by bcc'ing to myself
(add-hook 'message-send-hook 'add-sender-mail-bcc)

;; Regex
(require 're-builder)
(setq reb-re-syntax 'string)

;; Editorconfig (see https://editorconfig.org/)
(editorconfig-mode 1)

;; IDO - Interactive do things
;; (require 'ido)
;; (ido-mode nil)

;; Turn of linum mode for big files
(defun buffer-too-big-p ()
  (or (> (buffer-size) (* 5000 80))
      (> (line-number-at-pos (point-max)) 5000)))

(add-hook 'find-file-hook
          (lambda ()
            ;; (message minor-mode-list)
            ;; turn off `linum-mode' when there are more than 5000 lines
            (if (buffer-too-big-p) (linum-mode -1))
            (if (buffer-too-big-p) (font-lock-mode -1))
            (if (buffer-too-big-p) (undo-tree-mode -1))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; basics.el ends here
