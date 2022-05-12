;;; keybindings_hooks.el ---
;;
;; Filename: keybindings_hooks.el
;; Status:
;; Author: Manuel Schneckenreither
;; Created: So Sep 29 14:21:26 2013 (+0200)
;; Version:
;; Last-Updated:
;;           By:
;;     Update #: 146
;; URL:
;; Description:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


;;; package -- Summary
;;; Commentary:

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++++++ DEFAULT KEYS +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;            in my eyes these keys should work out of the box


;; fix identation for splitting lines
(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)
(global-set-key [C-tab] 'bs-cycle-next) ;; next buffer
(global-set-key [C-S-iso-lefttab] 'bs-cycle-previous) ;; previous buffer
(global-set-key (kbd "C-x C-b") 'ibuffer)  ;; ibuffer
(global-set-key [f11] 'my-toggle-fullscreen) ;; defined in basics.el
(define-key isearch-mode-map [(control h)] 'isearch-mode-help) ;; help during search
(global-set-key (kbd "C-c DEL") 'delete-trailing-whitespace) ;; delete trailing whitespaces

;; window resizing
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)


;; M-x withouth using the ALT key
;; defined in helm_config.el
;; (global-set-key "\C-x\C-m" 'execute-extended-command)
;; (global-set-key "\C-c\C-m" 'execute-extended-command)

;; Kill words with C-w: the standard unix way
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++ SHOW THE MARK +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;; Author: Patrick Gundlach
;; nice mark - shows mark as a highlighted 'cursor' so user 'always'
;; sees where the mark is. Especially nice for killing a region.

;; (defvar pg-mark-overlay nil
;;   "Overlay to show the position where the mark is")
;; (make-variable-buffer-local 'pg-mark-overlay)

;; (put 'pg-mark-mark 'face 'secondary-selection)

;; (defvar pg-mark-old-position nil
;;   "The position the mark was at. To be able to compare with the
;; current position")

;; (defun pg-show-mark ()
;;   "Display an overlay where the mark is at. Should be hooked into
;; activate-mark-hook"
;;   (unless pg-mark-overlay
;;     (setq pg-mark-overlay (make-overlay 0 0))
;;     (overlay-put pg-mark-overlay 'category 'pg-mark-mark))
;;   (let ((here (mark t)))
;;     (when here
;;       (move-overlay pg-mark-overlay here (1+ here)))))

;; (defadvice  exchange-point-and-mark (after pg-mark-exchange-point-and-mark)
;;   "Show visual marker"
;;   (pg-show-mark))

;; (ad-activate 'exchange-point-and-mark)
;; (add-hook 'activate-mark-hook 'pg-show-mark)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++ BASICS KEYS +++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; KEYBOARD SHORTCUTS
(global-set-key (kbd "C-x C-SPC") 'compile-again) ;; compile
(global-set-key (kbd "C-x SPC") 'compile-closest-Makefile) ;; compile
;; (global-set-key (kbd "C-c SPC") 'compile-closest-Makefile) ;; compile
(global-set-key (kbd (concat prefix-command-key " c")) 'shell) ;;  start shell
(global-set-key (kbd (concat prefix-command-key " r")) 'replace-regexp) ;; regex replace
(global-set-key (kbd (concat prefix-command-key " s l")) 'list-matching-lines) ;; Regex search and show in other buffer

;;; easily insert the current date
(global-set-key (kbd "C-c d") 'insert-date)

;; Change delete backward char to bash default
(global-set-key (kbd (concat prefix-command-key " h")) 'help) ;;  start shell
(global-set-key (kbd "C-h") 'delete-backward-char)

;; buffer/frame switching
(global-set-key (kbd (concat prefix-command-key " b t")) 'transpose-buffers)
(global-set-key (kbd (concat prefix-command-key " b s")) 'switch-buffers-between-frames)

;; TAGS
(global-set-key (kbd "C-c C-.") 'find-tag-other-window) ; pointer moves
(global-set-key (kbd "C-.") 'view-tag-other-window)     ; pointer stays
(global-set-key (kbd (concat prefix-command-key " t r")) 'tags-reset-tags-tables);; Reset tags table
(global-set-key (kbd (concat prefix-command-key " t v")) 'visit-tags-table) ;; Visit tags table
(global-set-key (kbd "M-*") 'pop-tag-mark)

;; UNDO TREE
(global-undo-tree-mode) ;; set undo tree mode
(global-set-key (kbd (concat prefix-command-key " u")) 'undo-tree-visualize) ;; show undo tree

;; AUTO FILL COLUMN
(global-set-key (kbd (concat prefix-command-key " a"))  'auto-fill-mode)

;; browse kill ring (done by counsel, see package_configs/counsel_config.el)
;; (global-set-key (kbd "C-c y") 'browse-kill-ring)

;; align with regex
(global-set-key (kbd "C-x a r") 'align-regexp)

;; comment uncomment
(global-set-key (kbd "C-c c") 'comment-or-uncomment-region) ;; un/comment region
(global-set-key (kbd "C-c TAB") 'iwb) ;; intend whole buffer
(global-set-key (kbd "C-x TAB") 'iwb) ;; intend whole buffer

;; copy line instead of kill line
(defun copy-line (&optional arg)
  "Do a kill-line but copy rather than kill.  This function directly calls
kill-line, so see documentation of kill-line for how to use it including prefix
argument and relevant variables.  This function works by temporarily making the
buffer read-only, so I suggest setting kill-read-only-ok to t."
  (interactive "P")
  (toggle-read-only 1)
  (kill-line arg)
  (toggle-read-only 0))

(setq-default kill-read-only-ok t)
(global-set-key "\C-c\C-k" 'copy-line)


;; move to another buffer easily
(global-set-key [M-left] 'windmove-left)          ; move to left windnow
(global-set-key [M-right] 'windmove-right)        ; move to right window
(global-set-key [M-up] 'windmove-up)              ; move to upper window
(global-set-key [M-down] 'windmove-down)          ; move to downer window

;; don't kill Emacs that easily
(defun dont-kill-emacs ()
  (interactive)
  (error (substitute-command-keys "To exit emacs: \\[save-buffers-kill-emacs]")))


;; quit gnus properly instead of leaving auto-save files around
(defadvice save-buffers-kill-emacs (before quit-gnus (&rest args) activate)
  ;; (if org-gcal-client-id (org-gcal-sync))
  (let (buf)
    (when (and (fboundp 'gnus-alive-p)
               (gnus-alive-p)
               (bufferp (setq buf (get-buffer "*Group*"))))
      (with-current-buffer buf
        (gnus-group-exit)))))


(global-set-key "\C-x\C-c" 'dont-kill-emacs)
(global-set-key (kbd (concat prefix-command-key " C-q")) 'save-buffers-kill-emacs)


;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++ TOGGLE LINE TRUNCATION +++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

(setq-default truncate-lines 1)
(global-set-key [f12] 'toggle-truncate-lines)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++ FLYSPELL ++++++++++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; (require 'flyspell-correct-helm)
;; (define-key flyspell-mode-map (kbd "C-;") 'flyspell-correct-previous)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; keybindings_hooks.el ends here
