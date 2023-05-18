;;; bbdb_config.el ---
;;
;; Filename: bbdb_config.el
;; Description:
;; Author: Manuel Schneckenreither
;; Maintainer:
;; Created: Di Feb  4 18:27:15 2014 (+0100)
;; Version:
;; Package-Requires: ()
;; Last-Updated: So Mär  2 13:12:42 2014 (+0100)
;;           By: Manuel Schneckenreither
;;     Update #: 28
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

(setq bbdb-file "~/.mail/bbdb_addresses")

;; init bbdb for gnus
(require 'bbdb)
(bbdb-initialize 'gnus 'message 'sc 'w3)
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)


;; ;; gnus scores
;; (setq gnus-score-find-score-files-function
;;       '(gnus-score-find-bnews bbdb/gnus-score))

;; supercite
(setq sc-preferred-attribution-list
  '("sc-lastchoice" "x-attribution" "sc-consult"
    "initials" "firstname" "lastname"))

(setq sc-attrib-selection-list
             '(("sc-from-address"
                ((".*" . (bbdb/sc-consult-attr
                          (sc-mail-field "sc-from-address")))))))


(setq sc-mail-glom-frame
   '((begin                        (setq sc-mail-headers-start (point)))
     ("^x-attribution:[ \t]+.*$"   (sc-mail-fetch-field t) nil t)
     ("^\\S +:.*$"                 (sc-mail-fetch-field) nil t)
     ("^$"                         (progn (bbdb/sc-default)
                                   (list 'abort '(step . 0))))
     ("^[ \t]+"                    (sc-mail-append-field))
     (sc-mail-warn-if-non-rfc822-p (sc-mail-error-in-mail-field))
     (end                          (setq sc-mail-headers-end (point)))))


;; always display the names
(setq bbdb-dwim-net-address-allow-redundancy t)
(setq bbdb/gnus-summary-prefer-bbdb-data t)
(setq bbdb/gnus-header-prefer-real-names t)
(setq bbdb/gnus-header-show-bbdb-names t)


(setq
    bbdb-offer-save 1                        ;; 1 means save-without-asking


    bbdb-use-pop-up t                        ;; allow popups for addresses
    bbdb-electric-p t                        ;; be disposable with SPC
    bbdb-popup-target-lines  1               ;; very small

    bbdb-dwim-net-address-allow-redundancy t ;; always use full name
    bbdb-quiet-about-name-mismatches 2       ;; show name-mismatches 2 secs

    bbdb-always-add-address t                ;; add new addresses to existing...
                                             ;; ...contacts automatically
    bbdb-canonicalize-redundant-nets-p t     ;; x@foo.bar.cx => x@bar.cx

    bbdb-completion-type nil                 ;; complete on anything

    bbdb-complete-mail-allow-cycling t       ;; cycle through matches
    bbdb-complete-name-allow-cycling t       ;; this only works partially


    bbbd-message-caching-enabled t           ;; be fast
    bbdb-use-alternate-names t               ;; use AKA


    bbdb-elided-display t                    ;; single-line addresses

    ;; auto-create addresses from mail
    bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook
    bbdb-ignore-some-messages-alist ;; don't ask about fake addresses
    ;; NOTE: there can be only one entry per header (such as To, From)
    ;; http://flex.ee.uec.ac.jp/texi/bbdb/bbdb_11.html

    '(( "From" . "no.?reply\\|DAEMON\\|daemon\\|facebookmail\\|twitter")))


;; enable automatic creation of the address book
(setq bbdb/news-auto-create-p t)
(setq bbdb/mail-auto-create-p t)
(setq bbdb-north-american-phone-numbers-p nil)
(setq bbdb-default-area-code 0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; bbdb_config.el ends here
