;;; gnus_config.el ---
;;
;; Filename: gnus_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Di Feb  4 12:54:58 2014 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: Thu Feb 11 01:23:50 2021 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 311
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
;;; GNUS:


;; Don't create that ugly Mail folder in my home directory
;; (setq gnus-directory (expand-file-name "~/Mail/"))
;; (setq gnus-home-directory "~/Mail/")


;; (load-file (concat package-folder "gnus/gnus-desktop-notify.el"))

;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++++++++ QUITING GNUS ++++++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; disable exiting with q
(defun local-gnus-group-mode ()
  ;; KEYS
  (local-set-key (kbd "q") (lambda ()
                             (interactive)
                             (error (substitute-command-keys (concat
                                                              "disabled! Use C-x k to "
                                                              "bury the buffer or "
                                                              "\\[gnus-group-exit] to quit "
                                                              "Gnus")))))
  (local-set-key (kbd "C-x k") (lambda ()
                                 (interactive)
                                 (schnecki-gnus)))
  (local-set-key (kbd "Q") 'gnus-group-exit))

;; set in group mode hook
(add-hook 'gnus-group-mode-hook 'local-gnus-group-mode)


;; Redefine keys - disable hiding topics in group buffer
(defun jbr-gnus-topic-mode-hook()
  (define-key gnus-topic-mode-map [tab] 'gnus-group-next-unread-group)
  (define-key gnus-topic-mode-map [backtab] 'gnus-group-prev-unread-group)
  (define-key gnus-topic-mode-map [S-tab] 'gnus-group-prev-unread-group))

(add-hook 'gnus-topic-mode-hook 'jbr-gnus-topic-mode-hook)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ GNUS CONFIG ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; show old messages also
;; (setq gnus-fetch-old-headers t)

;; (setq gnus-asynchronous t)
;; (setq gnus-use-cache t)

;; show all images, but the ones having "ads" in them.
;; (setq gnus-blocked-images "ads")
(setq gnus-blocked-images 'gnus-block-private-groups)


;; CHANGE GNUS DIRECTORY TO NOT CLUTTER THE HOME DIRECTORY

;; archive
;; (setq gnus-message-archive-method
;;       '(nnfolder "archive"
;;                  (nnfolder-inhibit-expiry t)
;;                  (nnfolder-get-new-mail nil)
;;                  (nnfolder-active-file "~/Mail/sent-mail/active")
;;                  (nnfolder-directory "~/Mail/sent-mail/")
;;                  ))


(setq gnus-gcc-mark-as-read t)


;; ;; set folder paths
;; (setq gnus-article-save-directory "~/Mail/News/")

;; (setq gnus-home-directory "~/Mail/"
;;       message-directory (concat gnus-home-directory "messages/")
;;       nnfolder-directory (concat gnus-home-directory "archive/")
;;       gnus-directory (concat gnus-home-directory "news/")
;;       gnus-kill-files-directory (concat gnus-home-directory "score/")
;;       gnus-cache-directory (concat gnus-home-directory ".cache/")
;;       gnus-html-cache-directory (concat gnus-home-directory "htmlcache/"))

;; ;; set default values
(setq
 ;; gnus-save-newsrc-file nil
 ;; gnus-read-newsrc-file nil
 ;; gnus-use-dribble-file nil
 gnus-interactive-exit nil
 ;; gnus-save-killed-list nil
 )


;; ;; for searching through imap folders (rest of config in .gnus)
;; (require 'nnir)

;; ;; bbdb
(setq bbdb/news-auto-create-p t)
(require 'bbdb)
;; ;; start bbdb and dired
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)

;; ;; search imap
;; (setq nnir-imap-default-search-key "Imap")

;; (setq nnir-method-default-engines '((nnimap . imap)
;;                                     (nntp . gmane)
;;                                     ))


;; ;; set custom timeout
;; (defadvice gnus-demon-scan-news (around gnus-demon-timeout activate)
;;   "Timeout for Gnus."
;;   (with-timeout
;;       (15 (message "Gnus timed out."))
;;     ad-do-it))

;; close sent message buffers
(setq message-kill-buffer-on-exit t)


;; Toggle between the gnus window configuration and your normal
;; editing window configuration.
(defun schnecki-gnus ()
  (interactive)
  (let ((bufname (buffer-name)))
    (if (or
         (string-equal "*Group*" bufname)
         (string-equal "*BBDB*" bufname)
         (string-match "\*Summary" bufname)
         (string-match "\*Article" bufname))
        (progn
          (schnecki-bury-gnus))
                                        ;unbury
      (if (get-buffer "*Group*")
          (schnecki-unbury-gnus)
        (gnus-unplugged)))))

(defun schnecki-unbury-gnus ()
  (interactive)
  (setq gnus-bury-window-configuration-non-gnus nil)
  (unless gnus-bury-window-configuration-non-gnus
    (setq gnus-bury-window-configuration-non-gnus (current-window-configuration)))
  (when (and (boundp 'gnus-bury-window-configuration) gnus-bury-window-configuration)
    (set-window-configuration gnus-bury-window-configuration)))

(defun schnecki-bury-gnus ()
  (interactive)
  (setq gnus-bury-window-configuration nil)
  (let ((buf nil)
        (bufname nil))
    (dolist (buf (buffer-list))
      (setq bufname (buffer-name buf))
      (when (or
             (string-equal "*Group*" bufname)
             (string-equal "*BBDB*" bufname)
             (string-match "\*Summary" bufname)
             (string-match "\*Article" bufname))
        (unless gnus-bury-window-configuration
          (setq gnus-bury-window-configuration (current-window-configuration)))
        (delete-other-windows)
        (if (eq (current-buffer) buf)
            (bury-buffer)
          (bury-buffer buf)))))
  (when (and (boundp 'gnus-bury-window-configuration-non-gnus) gnus-bury-window-configuration-non-gnus)
    (set-window-configuration gnus-bury-window-configuration-non-gnus)))

(global-set-key (kbd (concat prefix-command-key "m o")) 'schnecki-gnus)

;; set visible headers
(setq gnus-visible-headers "^From:\\|^Newsgroups:\\|^Subject:\\|^Date:\\|^Followup-To:\\|^Reply-To:\\|^Summary:\\|^Keywords:\\|^To:\\|^[BGF]?Cc:\\|^Posted-To:\\|^Mail-Copies-To:\\|^Mail-Followup-To:\\|^Apparently-To:\\|^Gnus-Warning:\\|^Resent-From:\\|^X-Sent:\\|^User-Agent:\\|^X-Mailer:\\|^X-Newsreader:")
;; (setq gnus-sorted-header-list '("^From:" "^Subject:" "^Summary:" "^Keywords:" "^Newsgroups:" "^Followup-To:" "^To:" "^Cc:" "^Date:" "^User-Agent:" "^X-Mailer:" "^X-Newsreader:"))


;; Show '-> Recipient' instead of my name as sender for replies
(setq gnus-ignored-from-addresses "Manuel Schneckenreither")


;; ;; Group buffer
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(setq gnus-group-line-format "\t%M%S%p%P%4y: %B%*%(%-66,66g%)%6O\t%18ud [%5t]\n"
      gnus-check-new-newsgroups nil)
(add-hook 'gnus-select-group-hook 'gnus-group-set-timestamp)

(defun gnus-user-format-function-d (headers)
  (let ((time (gnus-group-timestamp gnus-tmp-group)))
    (if time
        (format-time-string "(%d.%m.%Y %H:%M)" time)
      "")))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ SIGNATURE ++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq mail-signature nil)
(setq message-signature nil)
(setq mail-signature-file "~/.emacs.d/signature")
(setq message-cite-reply-position (quote traditional))
;; (setq message-cite-reply-position (quote above))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ SCORES ++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq gnus-use-adaptive-scoring '(word line))

(setq gnus-default-adaptive-score-alist
      '((gnus-unread-mark)
        (gnus-ticked-mark (from 4))
        (gnus-dormant-mark (from 5))
        (gnus-del-mark (from -4) (subject -1))
        (gnus-read-mark (from 4) (subject 2))
        (gnus-expirable-mark (from -1) (subject -1))
        (gnus-killed-mark (from -1) (subject -3))
        (gnus-kill-file-mark)
        (gnus-ancient-mark)
        (gnus-low-score-mark)
        (gnus-catchup-mark (from -1) (subject -1))))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++ SENT MESSAGE FOLDERS +++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; Automatically put the sent messages in the input folder. This
;; enables a nice history view of the topics.

;; remove the prefix for storing sent mail (otherwise it won't work to
;; save the mail in the same folder)
;; (setq gnus-message-archive-method "")
;;
;; (setq gnus-message-archive-group
;;       '((lambda (x)
;;           (cond
;;            ;; Store personal mail messages in the same group I started
;;            ;; out in
;;            ((string-match "mail.*" group) group)
;;
;;            ;; I receive a copy of all messages I send to a list, so
;;            ;; there's no need to archive
;;            ((string-match "list.*" group) nil)
;;
;;            ;; If the group information is empty, e.g. when composing a
;;            ;; new mail outside of gnus, store it in the folder of the
;;            ;; default email address (set in settings.el). This folder
;;            ;; is INBOX for me.
;;            ("" "INBOX")
;;
;;            ;; Store everything else in misc until I can sort it out
;;            (t "mail.misc")))))
;;
;; ;; edit score for replying
;; (add-hook 'message-sent-hook 'gnus-score-followup-thread)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++++ CITING +++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; use the built in supercite for citing.
(add-hook 'mail-citation-hook 'sc-cite-original)


;; This prevents GNUS from inserting its default attribution header.
;; Otherwise, both GNUS and Supercite will insert an attribution
;; header:
;; (setq news-reply-header-hook nil)

;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++ SET DEFAULT MAIL USER AGENT +++++++++++++++++++++
;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; (setq mail-user-agent 'gnus-user-agent)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++ SIGNING MESSAGES ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; ;; Always sign encrypted messages
;; (setq mc-pgp-always-sign t)
;; ;; How long should mailcrypt remember your passphrase
;; (setq mc-passwd-timeout 600)

;; ;; Automagically sign all messages
;; ;; (add-hook 'message-send-hook 'will-you-sign)
;; (defun will-you-sign ()
;;   (interactive)
;;   (if (y-or-n-p "Do you want to sign this message? ")
;;       (mml-secure-sign-pgp)))


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ FORMATING LISTS ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; article lists
(setq gnus-face-0 'gnus-server-offline
      gnus-face-1 'gnus-server-agent
      gnus-face-2 'gnus-server-opened
      gnus-summary-line-format "%U%R%z | %6i | %(%-16,16&user-date;  %-20,20f  %2uj  %*%B%s%)\n"
      gnus-user-date-format-alist '(((gnus-seconds-today) . "Today      %2H:%2M")
                                    ((+ 86400 (gnus-seconds-today)) . "Yesterday  %H:%M")
                                    ;; (604800 . "%A %2H:%2M") ;; that's one week
                                    (t . "%d.%m.%Y %2H:%2M"))
      gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
      gnus-thread-sort-functions '(gnus-thread-sort-by-date)
      gnus-sum-thread-tree-false-root ""
      gnus-sum-thread-tree-indent " "
      gnus-sum-thread-tree-leaf-with-other "├► "
      gnus-sum-thread-tree-root ""
      gnus-sum-thread-tree-single-leaf "╰► "
      gnus-sum-thread-tree-vertical "│")


;; show “»” if i’m the only recipient of the message, or a “~” if i’m
;; in the To:, Cc: or BCc: headers among others:
(defun gnus-user-format-function-j (headers)
  (let ((to (gnus-extra-header 'To headers)))
    (if (string-match your-mail-addresses to)
        (if (string-match "[\"\' \<.[:alnum:]]*@[\>.[:alnum:]]*[:space]*,[\"\' \<\>.[:alnum:]]*@" to) "~" "»")
      (if (or (string-match your-mail-addresses
                            (gnus-extra-header 'Cc headers))
              (string-match your-mail-addresses
                            (gnus-extra-header 'BCc headers)))
          "~"
        (if (string-match your-mail-addresses (mail-header-from headers))
            "m"
          " ")
        ))))

;; Coloring empty topics differently from non-empty topics is a nice idea.
(setq gnus-topic-line-format "%i[ %u&topic-line; ] %v\n")

;; this corresponds to a topic line format of "%n %A"
(defun gnus-user-format-function-topic-line (dummy)
  (let ((topic-face (if (zerop total-number-of-articles)
                        'italic
                      'bold)))
    (propertize
     (format "%s %d" name total-number-of-articles)
     'face topic-face)))
;;
;;
;; ;;; turn on debug info
;; (setq smtpmail-debug-info t)
;;
;;; add cc and bcc when composing emails
;; (setq message-default-mail-headers "Cc: \nBcc: manuel.schnecki@gmail.com\n")
;;
;; ;;; If nil, attach files as normal parts in Fcc copies; if it is non-nil, attach
;; ;;; local files as external parts.
;; (setq message-interactive t)
;;
;;
;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++++++ FINALLY OPEN GNUS +++++++++++++++++++++++++++
;; ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;
;; ;; do not download everyting when gnus starts
;; (setq gnus-read-active-file 'some)
;;
;;
;; ;; set timeout so we don't get stuck
;; ;; (setq nntp-connection-timeout 3
;; ;;       nntp-command-timeout 8)
;;
;;
;; ;; open gnus
;; ;; (gnus) ;; is done in init.el if gnus is loaded and user does not decline
;;
;; ;; gnus function for system wide mail editor
;; (defun mailto-compose-mail (mailto-url)
;;   "Parse MAILTO-URL and start composing mail."
;;   (if (and (stringp mailto-url)
;;            (string-match "\\`mailto:" mailto-url))
;;       (progn
;;         (require 'rfc2368)
;;         (require 'rfc2047)
;;         (require 'mailheader)
;;
;;         (let ((hdr-alist (rfc2368-parse-mailto-url mailto-url))
;;               (body "")
;;               to subject
;;               ;; In addition to To, Subject and Body these headers are
;;               ;; allowed:
;;               (allowed-xtra-hdrs '(cc bcc in-reply-to)))
;;
;;           (with-temp-buffer
;;             ;; Extract body if it's defined
;;             (when (assoc "Body" hdr-alist)
;;               (dolist (hdr hdr-alist)
;;                 (when (equal "Body" (car hdr))
;;                   (insert (format "%s\n" (cdr hdr)))))
;;               (rfc2047-decode-region (point-min) (point-max))
;;               (setq body (buffer-substring-no-properties
;;                           (point-min) (point-max)))
;;               (erase-buffer))
;;
;;             ;; Extract headers
;;             (dolist (hdr hdr-alist)
;;               (unless (equal "Body" (car hdr))
;;                 (insert (format "%s: %s\n" (car hdr) (cdr hdr)))))
;;             (rfc2047-decode-region (point-min) (point-max))
;;             (goto-char (point-min))
;;             (setq hdr-alist (mail-header-extract-no-properties)))
;;
;;           (setq to (or (cdr (assq 'to hdr-alist)) "")
;;                 subject (or (cdr (assq 'subject hdr-alist)) "")
;;                 hdr-alist
;;                 (remove nil (mapcar
;;                              #'(lambda (item)
;;                                  (when (memq (car item) allowed-xtra-hdrs)
;;                                    (cons (capitalize (symbol-name (car item)))
;;                                          (cdr item))))
;;                              hdr-alist)))
;;
;;           (compose-mail to subject hdr-alist nil nil
;;                         (list (lambda (string)
;;                                 (insert string))
;;                               body))))
;;     (compose-mail)))


(defun my-gnus-group-list-subscribed-groups ()
  "List all subscribed groups with or without un-read messages"
  (interactive)
  (gnus-group-list-all-groups 5))

(define-key gnus-group-mode-map
  ;; list all the subscribed groups even they contain zero un-read messages
  (kbd "o") 'my-gnus-group-list-subscribed-groups)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; gnus_config.el ends here
