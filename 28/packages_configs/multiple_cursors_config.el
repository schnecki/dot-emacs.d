
(require 'multiple-cursors)

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;; +++++++++++++++++++++++ MULTIPLE CURSORS CONFIG ++++++++++++++++++++++
;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; KEYS

;;When you have an active region that spans multiple lines, the following will
;;add a cursor to each line:
(global-set-key  (kbd (concat prefix-command-key " m r")) 'mc/edit-lines)

;; When you want to add multiple cursors not based on continuous lines, but
;; based on keywords in the buffer, use:
(global-set-key  (kbd (concat prefix-command-key " m m")) 'mc/mark-more-like-this-extended)
(global-set-key  (kbd (concat prefix-command-key " m n")) 'mc/mark-next-like-this)
(global-set-key  (kbd (concat prefix-command-key " m p")) 'mc/mark-previous-like-this)
(global-set-key  (kbd (concat prefix-command-key " m a")) 'mc/mark-all-like-this)
