;;; gnus.el ---
;;
;; Filename: gnus.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Di Feb  4 17:01:05 2014 (+0100)
;; Version:
;; Package-Requires: ()
;;           By: Manuel Schneckenreither
;;     Update #: 247
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;  This file gets loaded by the file ~/.gnus.el on each Gnus startup.
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

(global-set-key (kbd "C-x m") 'gnus-msg-mail)

;; INCOMING MAIL CONFIG
(setq gnus-select-method '(nnnil nil))
(setq gnus-secondary-select-methods
      '((nnimap "uibk_exchange"
                (nnimap-address "exchange.uibk.ac.at")
                (nnimap-server-port 993)
                (nnimap-stream ssl)
                (nnir-search-engine imap))
        (nnimap "uibk"
                (nnimap-address "mail.uibk.ac.at")
                (nnimap-stream ssl)
                (nnimap-server-port 993)
                (nnir-search-engine imap))
        (nnimap "gmail"
                (nnimap-address "imap.gmail.com")
                (nnimap-stream ssl)
                (nnimap-server-port 993)
                (nnir-search-engine imap)
                ;; (nnmail-expiry-target "nnimap+work:[Gmail]/Trash")
                ;; (nnmail-expiry-wait 'immediate)
                )
        (nnimap "globalpont-info"
                (nnimap-address "imap.easyname.com")
                (nnimap-stream ssl)
                (nnimap-server-port 993)
                (nnir-search-engine imap))
        (nnimap "globalpont-ms"
                (nnimap-address "imap.easyname.com")
                (nnimap-stream ssl)
                (nnimap-server-port 993)
                (nnir-search-engine imap))
        ))


;; OUTGOING MAIL CONFIG

;; Emacs prompts for passwords and saves them in ~/.authinfo
(setq smtp-accounts
      '(("manuel.schnecki@gmail.com" "smtp.gmail.com" 587 "manuel.schnecki@gmail.com")
        ;; ("manuel.schneckenreither@uibk.ac.at" "smtp.uibk.ac.at" 587 "c4371143")
        ("manuel.schneckenreither@student.uibk.ac.at" "smtp.uibk.ac.at" 587 "csap3804")
        ("info@globalpont.com" "smtp.easyname.com" 587 "146315mail4")
        ("ms@globalpont.com" "smtp.easyname.com" 587 "146315mail6")
        ))


;; Set the SMTP Server according to the mail address we use for sending
(defun set-smtp-server-message-send-and-exit ()
  "Set SMTP server from list of multiple ones and send mail."
  (interactive)
  (message-remove-header "X-Message-SMTP-Method") ;; Remove. We always determine it by the From field
  (let ((sender
         (message-fetch-field "From")))
    (loop for (addr server port usr) in smtp-accounts
          when (string-match addr sender)
          do (message-add-header (format "X-Message-SMTP-Method: smtp %s %d %s" server port usr)))
    (let ((xmess
           (message-fetch-field "X-Message-SMTP-Method")))
      (if xmess
          (progn
            (message (format "Sending message using '%s' with config '%s'" sender xmess))
            (message-send-and-exit))
        (error "Could not find SMTP Server for this Sender address: %s. You might want to correct it or add it to the SMTP Server list 'smtp-accounts'" sender)))))

;; Send emails via multiple servers
(defun local-gnus-compose-mode ()
  "Keys."
  (local-set-key (kbd "C-c C-c")  'set-smtp-server-message-send-and-exit)
  )


;; set in group mode hook
(add-hook 'gnus-message-setup-hook 'local-gnus-compose-mode)


;; Evaluated from top to bottom
(setq gnus-posting-styles
      '((".*")
        ;; ((header "from" "manuel.schneckenreither@uibk.ac.at")
        ;;  (address "Manuel Schneckenreither <manuel.schneckenreither@uibk.ac.at>")
        ;;  (organization "University of Innsbruck")
        ;;  ;; (signature-file "~/.signature-work")
        ;;  )
        ((header "from" "manuel.schneckenreither@student.uibk.ac.at")
         (address "Manuel Schneckenreither <manuel.schneckenreither@student.uibk.ac.at>")
         (organization "University of Innsbruck")
         ;; (signature-file "~/.signature-work")
         )
        ((header "from" "manuel.schnecki@gmail.com")
         (address "Manuel Schneckenreither <manuel.schnecki@gmail.com>")
         ;; (organization "")
         ;; (signature-file "~/.signature-work")
         )
        ((header "from" "info@globalpont.com")
         (address "GlobalPont Info <info@globalpont.com>")
         (organization "GlobalPont")
         ;; (signature-file "~/.signature-work")
         )
        ((header "from" "ms@globalpont.com")
         (address "Manuel Schneckenreither <ms@globalpont.com>")
         (organization "GlobalPont")
         ;; (signature-file "~/.signature-work")
         )
        ;; Reply from the address it was send to
        ((header "x-original-to" "\\(\\+.+\\)@globalpont.com")
         (address "\\1@globalpont.com"))
        ((header "x-original-to" "schnecki@gmail.com")
         (address "schnecki@gmail.com.com"))
        ;; ((header "x-original-to" "manuel.schneckenreither@uibk.ac.at")
        ;;  (address "manuel.schneckenreither@uibk.ac.at"))
        ((header "x-original-to" "manuel.schneckenreither@student.uibk.ac.at")
         (address "manuel.schneckenreither@uibk.ac.at"))
        ((header "cc" "\\(\\+.+\\)@globalpont.com")
         (address "\\1@globalpont.com"))
        ((header "cc" "schnecki@gmail.com")
         (address "schnecki@gmail.com.com"))
        ;; ((header "cc" "manuel.schneckenreither@uibk.ac.at")
        ;;  (address "manuel.schneckenreither@uibk.ac.at"))
        ((header "cc" "manuel.schneckenreither@student.uibk.ac.at")
         (address "manuel.schneckenreither@uibk.ac.at"))
        )
      )


;; (require 'cl)
;; (setq smtpmail-stream-type 'ssl) ;; If using TLS/SSL.  Use C-h v smtpmail-stream-type RET to see possible values

;; (defun my-change-smtp ()
;;   (save-excursion
;;     (loop with from = (save-restriction
;;                         (message-narrow-to-headers)
;;                         (message-fetch-field "from"))
;;           for (addr fname server usr) in smtp-accounts
;;           when (string-match addr from)
;;           do (setq user-mail-address addr
;;                    user-full-name fname
;;                    smtpmail-smtp-user usr
;;                    smtpmail-smtp-server server))))

;; (defadvice smtpmail-via-smtp
;;     (before change-smtp-by-message-from-field (recipient buffer &optional ask) activate)
;;   (with-current-buffer buffer (my-change-smtp)))

;; (setq user-mail-address "manuel.schnecki@gmail.com"
;;       user-full-name "Manuel Schneckenreither"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-auth-credentials (expand-file-name "~/.authinfo"))

(setq gnus-posting-styles
      '(((header "to" "manuel.schnecki@gmail.com")
         (address "manuel.schnecki@gmail.com"))
        ((header "to" "manuel.schneckenreither@student.uibk.ac.at")
         (address "manuel.schneckenreither@student.uibk.ac.at"))
        ;; ((header "to" "manuel.schneckenreither@uibk.ac.at")
        ;;  (address "manuel.schneckenreither@uibk.ac.at"))
        ((header "to" "info@globalpont.com")
         (address "info@globalpont.com")
         ;; (signature-file "~/.signature-work")
         ("X-Message-SMTP-Method" "smtp smtp.easyserver.com 587 info@globalpont.com"))
        ((header "to" "ms@globalpont.com")
         (address "ms@globalpont.com")
         ;; (signature-file "~/.signature-work")
         ("X-Message-SMTP-Method" "smtp smtp.easyserver.com 587 ms@globalpont.com"))
        ((header "cc" "manuel.schneckenreither@student.uibk.ac.at")
         (address "manuel.schneckenreither@student.uibk.ac.at"))
        ;; ((header "cc" "manuel.schneckenreither@uibk.ac.at")
        ;;  (address "manuel.schneckenreither@uibk.ac.at"))
        ((header "cc" "manuel.schnecki@gmail.com")
         (address "manuel.schnecki@gmail.com"))
        ((header "cc" "info@globalpont.com")
         (address "info@globalpont.com")
         ;; (signature-file "~/.signature-work")
         ("X-Message-SMTP-Method" "smtp smtp.easyserver.com 587 info@globalpont.com"))
        ((header "cc" "ms@globalpont.com")
         (address "ms@globalpont.com")
         (organization "GlobalPont")
         ;; (signature-file "~/.signature-work")
         ("X-Message-SMTP-Method" "smtp smtp.easyserver.com 587 ms@globalpont.com")
         )
        ;; (".*"
        ;;  (signature-file "~/News/signature")
        ;;  (name "Manuel Schneckenreither")))
        ))


;; (add-to-list 'gnus-secondary-select-methods '(nnimap "gmail"
;;                                                      (nnimap-stream ssl)
;;                                                      (nnimap-address "imap.gmail.com")
;;                                                      (nnimap-server-port 993)
;;                                                      ))

;; (add-to-list 'gnus-secondary-select-methods '(nnimap "globalpont-info"
;;                                                      (nnimap-stream ssl)
;;                                                      (nnimap-address "imap.easyname.com")
;;                                                      (nnimap-server-port 993)
;;                                                      ))

;; (add-to-list 'gnus-secondary-select-methods '(nnimap "globalpont-ms"
;;                                                      (nnimap-stream ssl)
;;                                                      (nnimap-address "imap.easyname.com")
;;                                                      (nnimap-server-port 993)
;;                                                      ))


;; (setq gnus-select-method
;; '((nnimap "uibk_exchange"
;;                             (nnimap-stream ssl)
;;                             (nnimap-address "exchange.uibk.ac.at")
;;                             (nnimap-server-port "imaps")
;;                             ))

;; (add-to-list 'gnus-secondary-select-methods '(nnimap "uibk_exchange"
;;                                   (nnimap-stream ssl)
;;                                   (nnimap-address "exchange.uibk.ac.at")
;;                                   (nnimap-server-port "imaps")
;;                                   ))

;; '(nnimap "uibk"
;;                                                     (nnimap-stream ssl)
;;                                                     (nnimap-server-port 993)
;;                                                     (nnimap-address "mail.uibk.ac.at")
;;                                                     ))

;; (add-to-list 'gnus-secondary-select-methods '(nnimap "uibk-c703"
;;                                                      (nnimap-stream ssl)
;;                                                      (nnimap-address "exchange.uibk.ac.at")
;;                                                      (nnimap-server-port "imaps")
;;                                                      ))


;; (add-to-list 'gnus-secondary-select-methods '(nnimap "gmail"
;;                                                      (nnimap-stream ssl)
;;                                                      (nnimap-address "imap.gmail.com")
;;                                                      (nnimap-server-port 993)
;;                                                      ))

;; (add-to-list 'gnus-secondary-select-methods '(nnimap "globalpont-info"
;;                                                      (nnimap-stream ssl)
;;                                                      (nnimap-address "imap.easyname.com")
;;                                                      (nnimap-server-port 993)
;;                                                      ))

;; (add-to-list 'gnus-secondary-select-methods '(nnimap "globalpont-ms"
;;                                                      (nnimap-stream ssl)
;;                                                      (nnimap-address "imap.easyname.com")
;;                                                      (nnimap-server-port 993)
;;                                                      ))

;; (add-to-list 'gnus-secondary-select-methods '(nnimap "oculytics"
;;                                                      (nnimap-stream ssl)
;;                                                      (nnimap-address "outlook.office365.com")
;;                                                      (nnimap-server-port "imaps")
;;                                                      ;; (nnimap-server-port 993)
;;                                                      ))


;; (add-to-list 'gnus-secondary-select-methods '(nnimap "hasktor"
;;                                                      (nnimap-stream ssl)
;;                                                      (nnimap-address "imap.easyname.com")
;;                                                      (nnimap-server-port 993)
;;                                                      ))

;; (add-to-list 'gnus-secondary-select-methods '(nnimap "uibk_exchange"
;;                                                      (nnimap-stream tls)
;;                                                      (nnimap-address "exchange.uibk.ac.at")
;;                                                      (nnimap-server-port "imaps")
;;                                                      ))

;; Gwene news and Gmane Mailgroups
;; (add-to-list 'gnus-secondary-select-methods '(nntp "news.gwene.org"))
;; (add-to-list 'gnus-secondary-select-methods '(nntp "news.gmane.org"))

;; Periodically check for mail/news
;; (gnus-demon-init)
;; (gnus-demon-add-handler 'gnus-demon-scan-news 5 t)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ BBDB address book ++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq bbdb/news-auto-create-p t)
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
;; (add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++ Do not ask me for exit +++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq
 ;; gnus-save-newsrc-file nil
 ;; gnus-read-newsrc-file nil
 ;; gnus-use-dribble-file nil
 gnus-interactive-exit nil
 ;; gnus-save-killed-list nil
 )

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ QUITING GNUS ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

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
;; +++++++++++++++++++++++++++ Sent messages ++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


(setq message-kill-buffer-on-exit t)
(setq gnus-gcc-mark-as-read t)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++ Shortcut for Showing/Hiding Gnus ++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


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


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ SIGNATURE ++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq mail-signature t)
(setq mail-signature-file "~/Mail/signature")
(setq message-cite-reply-position (quote traditional))

;; Sign messages by default.
;; (add-hook 'message-setup-hook 'mml-secure-message-sign-pgpmime)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++++ CITING +++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; use the built in supercite for citing.
(add-hook 'mail-citation-hook 'sc-cite-original)


;; This prevents GNUS from inserting its default attribution header.
;; Otherwise, both GNUS and Supercite will insert an attribution
;; header:
;; (setq news-reply-header-hook nil)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ GNUS NOTIFY ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; (require 'gnus-desktop-notify)
;; (gnus-desktop-notify-mode)
;; (gnus-demon-add-scanmail)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++ SPLITTING MAIL +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; 6.4.3 Splitting Mail
;; --------------------

;; The ‘nnmail-split-methods’ variable says how the incoming mail is to be
;; split into groups.

;;      (setq nnmail-split-methods
;;        '(("mail.junk" "^From:.*Lars Ingebrigtsen")
;;          ("mail.crazy" "^Subject:.*die\\|^Organization:.*flabby")
;;          ("mail.other" "")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; gnus.el ends here
