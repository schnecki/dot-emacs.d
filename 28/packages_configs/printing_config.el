;;Printing
(require 'printing nil t)
;; (setq pr-gv-command ghostview-executable)
(setq pr-faces-p t)

;print some faces in bold or italic, available faces are:
;font-lock-comment-face, font-lock-attribute-face, font-lock-value-face,
;font-lock-type-face, font-lock-keyword-face, font-lock-function-name-face,
;font-lock-string-face, font-lock-doc-string-face
(setq ps-italic-faces '(font-lock-comment-face))
(setq ps-bold-faces '(font-lock-keyword-face font-lock-function-name-face))
;(setq-default ps-underlined-faces nil)

(setq ps-print-use-faces t)  ; always print using faces
(setq ps-print-color-p nil)  ; don't use colors for printing
(setq  ps-paper-type 'a4 ) ; the type of paper

; page margins
(setq ps-left-margin  (/ (* 72  1.5) 2.54)) ;   1.5 cm
(setq ps-right-margin (/ (* 72  0.7) 2.54)) ;   0.7 cm
(setq ps-inter-column (/ (* 72  1.0) 2.54)) ;   1 cm

;(setq ps-bottom-margin (/ (* 72  0.5) 2.54)) ; 0.5 cm
(setq ps-bottom-margin (/ (* 72  0.9) 2.54)) ; 0.9 cm
(setq ps-top-margin    (/ (* 72  0.8) 2.54)) ; 0.8 cm
(setq ps-header-offset (/ (* 72  0.3) 2.54)) ; 0.3 cm
(setq ps-header-line-pad 0.15)

(setq ps-n-up-margin (/ (* 72  0.5) 2.54)) ; 0.5 cm

;print 2 columns
(setq ps-n-up-printing 2)

;(ps-line-lengths)
;(setq ps-font-size   '(7 . 8.5))
;(setq ps-font-size   '(5 . 6.5))
;(setq ps-font-size   '(14 . 6.5))
;(setq ps-font-size   14)
(setq ps-font-size 7)
;(setq ps-header-font-size       '(10 . 12))
;(setq ps-header-title-font-size '(12 . 14))


;; If you have a duplex-capable printer (one that prints both sides of
;; the paper), set ps-spool-duplex to t.  Ps-print will insert blank
;; pages to make sure each buffer starts on the correct side of the
;; paper.
(setq ps-spool-duplex t)

;(setq ps-spool-tumble nil) ; binding on left or right of page
(setq ps-spool-tumble t) ; binding on top or bottom of page
