;;; kingsajz-theme.el --- kingsajz theme

;; Copyright (C) 2001 by Olgierd "Kingsajz" Ziolko
;; Copyright (C) 2013 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>
;; URL: https://github.com/emacs-jp/replace-colorthemes

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Port of kingsajz theme from `color-themes'

;;; Code:

(deftheme kingsajz
  "kingsajz theme")

(custom-theme-set-faces
 'kingsajz

 '(default ((t (:background "darkslategrey" :foreground "wheat"))))
 '(mouse ((t (:background "Grey"))))
 '(cursor ((t (:background "LightGray"))))
 '(border ((t (:background "black"))))

 '(bbdb-field-name ((t (:foreground "green"))))
 '(bg:erc-color-face0 ((t (:background "White"))))
 '(bg:erc-color-face1 ((t (:background "black"))))
 '(bg:erc-color-face10 ((t (:background "lightblue1"))))
 '(bg:erc-color-face11 ((t (:background "cyan"))))
 '(bg:erc-color-face12 ((t (:background "blue"))))
 '(bg:erc-color-face13 ((t (:background "deeppink"))))
 '(bg:erc-color-face14 ((t (:background "gray50"))))
 '(bg:erc-color-face15 ((t (:background "gray90"))))
 '(bg:erc-color-face2 ((t (:background "blue4"))))
 '(bg:erc-color-face3 ((t (:background "green4"))))
 '(bg:erc-color-face4 ((t (:background "red"))))
 '(bg:erc-color-face5 ((t (:background "brown"))))
 '(bg:erc-color-face6 ((t (:background "purple"))))
 '(bg:erc-color-face7 ((t (:background "orange"))))
 '(bg:erc-color-face8 ((t (:background "yellow"))))
 '(bg:erc-color-face9 ((t (:background "green"))))
 '(blue ((t (:foreground "cyan"))))
 '(bold ((t (:bold t :foreground "OrangeRed" :weight bold))))
 '(bold-italic ((t (:italic t :bold t :slant italic :weight bold))))
 '(calendar-today-face ((t (:underline t))))
 '(comint-highlight-input ((t (:bold t :weight bold))))
 '(comint-highlight-prompt ((t (:foreground "cyan"))))
 '(cperl-array-face ((t (:foreground "Yellow"))))
 '(cperl-hash-face ((t (:foreground "White"))))
 '(cperl-nonoverridable-face ((t (:foreground "SkyBlue"))))
 '(custom-button-face ((t (:foreground "MediumSlateBlue" :underline t))))
 '(custom-button-pressed-face ((t (:background "lightgrey" :foreground "black" :box (:line-width 2 :style pressed-button)))))
 '(custom-changed-face ((t (:background "blue" :foreground "white"))))
 '(custom-comment-face ((t (:background "dim gray"))))
 '(custom-comment-tag-face ((t (:foreground "gray80"))))
 '(custom-documentation-face ((t (:foreground "Grey"))))
 '(custom-face-tag-face ((t (:bold t  :weight bold :height 1.2))))
 '(custom-group-tag-face ((t (:foreground "MediumAquamarine"))))
 '(custom-group-tag-face-1 ((t (:bold t  :foreground "pink" :weight bold :height 1.2))))
 '(custom-invalid-face ((t (:background "red" :foreground "yellow"))))
 '(custom-modified-face ((t (:background "blue" :foreground "white"))))
 '(custom-rogue-face ((t (:background "black" :foreground "pink"))))
 '(custom-saved-face ((t (:underline t))))
 '(custom-set-face ((t (:background "white" :foreground "blue"))))
 '(custom-state-face ((t (:foreground "Coral"))))
 '(custom-variable-button-face ((t (:underline t))))
 '(custom-variable-tag-face ((t (:foreground "Aquamarine"))))
 '(date ((t (:foreground "green"))))
 '(diary-face ((t (:bold t :foreground "IndianRed" :weight bold))))
 '(dired-face-directory ((t (:bold t :foreground "sky blue" :weight bold))))
 '(dired-face-executable ((t (:foreground "green yellow"))))
 '(dired-face-flagged ((t (:foreground "tomato"))))
 '(dired-face-marked ((t (:foreground "light salmon"))))
 '(dired-face-permissions ((t (:foreground "aquamarine"))))
 '(erc-action-face ((t (:bold t :weight bold))))
 '(erc-bold-face ((t (:bold t :weight bold))))
 '(erc-default-face ((t (nil))))
 '(erc-direct-msg-face ((t (:foreground "pale green"))))
 '(erc-error-face ((t (:bold t :foreground "IndianRed" :weight bold))))
 '(erc-highlight-face ((t (:bold t :foreground "pale green" :weight bold))))
 '(erc-host-danger-face ((t (:foreground "red"))))
 '(erc-input-face ((t (:foreground "light blue"))))
 '(erc-inverse-face ((t (:background "steel blue"))))
 '(erc-notice-face ((t (:foreground "light salmon"))))
 '(erc-pal-face ((t (:foreground "pale green"))))
 '(erc-prompt-face ((t (:bold t :foreground "light blue" :weight bold))))
 '(erc-underline-face ((t (:underline t))))
 '(eshell-ls-archive-face ((t (:bold t :foreground "IndianRed" :weight bold))))
 '(eshell-ls-backup-face ((t (:foreground "Grey"))))
 '(eshell-ls-clutter-face ((t (:bold t :foreground "DimGray" :weight bold))))
 '(eshell-ls-directory-face ((t (:bold t :foreground "MediumSlateBlue" :weight bold))))
 '(eshell-ls-executable-face ((t (:bold t :foreground "Coral" :weight bold))))
 '(eshell-ls-missing-face ((t (:bold t :foreground "black" :weight bold))))
 '(eshell-ls-picture-face ((t (:foreground "Violet"))))
 '(eshell-ls-product-face ((t (:foreground "LightSalmon"))))
 '(eshell-ls-readonly-face ((t (:foreground "Aquamarine"))))
 '(eshell-ls-special-face ((t (:bold t :foreground "Gold" :weight bold))))
 '(eshell-ls-symlink-face ((t (:bold t :foreground "White" :weight bold))))
 '(eshell-ls-text-face ((t (:foreground "medium aquamarine"))))
 '(eshell-ls-todo-face ((t (:bold t :foreground "aquamarine" :weight bold))))
 '(eshell-ls-unreadable-face ((t (:foreground "DimGray"))))
 '(eshell-prompt-face ((t (:foreground "powder blue"))))
 '(face-1 ((t (:stipple nil :foreground "royal blue"))))
 '(face-2 ((t (:stipple nil :foreground "DeepSkyBlue1"))))
 '(face-3 ((t (:stipple nil :foreground "NavajoWhite3"))))
 '(fg:erc-color-face0 ((t (:foreground "white"))))
 '(fg:erc-color-face1 ((t (:foreground "beige"))))
 '(fg:erc-color-face10 ((t (:foreground "pale goldenrod"))))
 '(fg:erc-color-face11 ((t (:foreground "light goldenrod yellow"))))
 '(fg:erc-color-face12 ((t (:foreground "light yellow"))))
 '(fg:erc-color-face13 ((t (:foreground "yellow"))))
 '(fg:erc-color-face14 ((t (:foreground "light goldenrod"))))
 '(fg:erc-color-face15 ((t (:foreground "lime green"))))
 '(fg:erc-color-face2 ((t (:foreground "lemon chiffon"))))
 '(fg:erc-color-face3 ((t (:foreground "light cyan"))))
 '(fg:erc-color-face4 ((t (:foreground "powder blue"))))
 '(fg:erc-color-face5 ((t (:foreground "sky blue"))))
 '(fg:erc-color-face6 ((t (:foreground "dark sea green"))))
 '(fg:erc-color-face7 ((t (:foreground "pale green"))))
 '(fg:erc-color-face8 ((t (:foreground "medium spring green"))))
 '(fg:erc-color-face9 ((t (:foreground "khaki"))))

 '(font-lock-builtin-face ((t (:bold t :foreground "PaleGreen" :weight bold))))
 '(font-lock-comment-face ((t (:foreground "White"))))
 '(font-lock-constant-face ((t (:bold t :foreground "Aquamarine" :weight bold))))
 '(font-lock-doc-face ((t (:italic t :slant italic :foreground "LightSalmon"))))
 '(font-lock-doc-string-face ((t (:foreground "LightSalmon"))))
 '(font-lock-function-name-face ((t (:bold t :foreground "MediumSlateBlue" :weight bold))))
 '(font-lock-keyword-face ((t (:foreground "Salmon"))))
 '(font-lock-preprocessor-face ((t (:foreground "Salmon"))))
 '(font-lock-reference-face ((t (:foreground "pale green"))))
 '(font-lock-string-face ((t (:italic t :foreground "LightSalmon" :slant italic))))
 '(font-lock-type-face ((t (:bold t :foreground "YellowGreen" :weight bold))))
 '(font-lock-variable-name-face ((t (:italic t :bold t :foreground "Aquamarine" :slant italic :weight bold))))
 '(font-lock-warning-face ((t (:bold t :foreground "IndianRed" :weight bold))))
 '(fringe ((t (:background "darkslategrey"))))
 '(gnus-cite-face-1 ((t (:foreground "DarkGoldenrod3"))))
 '(gnus-cite-face-10 ((t (nil))))
 '(gnus-cite-face-11 ((t (nil))))
 '(gnus-cite-face-2 ((t (:foreground "IndianRed3"))))
 '(gnus-cite-face-3 ((t (:foreground "tomato"))))
 '(gnus-cite-face-4 ((t (:foreground "yellow green"))))
 '(gnus-cite-face-5 ((t (:foreground "SteelBlue3"))))
 '(gnus-cite-face-6 ((t (:foreground "Azure3"))))
 '(gnus-cite-face-7 ((t (:foreground "Azure4"))))
 '(gnus-cite-face-8 ((t (:foreground "SpringGreen4"))))
 '(gnus-cite-face-9 ((t (:foreground "SlateGray4"))))
 '(gnus-emphasis-bold ((t (:bold t :foreground "greenyellow" :weight bold))))
 '(gnus-emphasis-bold-italic ((t (:italic t :bold t :foreground "OrangeRed1" :slant italic :weight bold))))
 '(gnus-emphasis-highlight-words ((t (:background "black" :foreground "khaki"))))
 '(gnus-emphasis-italic ((t (:italic t :bold t :foreground "orange" :slant italic :weight bold))))
 '(gnus-emphasis-underline ((t (:foreground "greenyellow" :underline t))))
 '(gnus-emphasis-underline-bold ((t (:bold t :foreground "khaki" :underline t :weight bold))))
 '(gnus-emphasis-underline-bold-italic ((t (:italic t :bold t :underline t :slant italic :weight bold))))
 '(gnus-emphasis-underline-italic ((t (:italic t :foreground "orange" :underline t :slant italic))))
 '(gnus-group-mail-1-empty-face ((t (:foreground "Salmon4"))))
 '(gnus-group-mail-1-face ((t (:bold t :foreground "firebrick1" :weight bold))))
 '(gnus-group-mail-2-empty-face ((t (:foreground "turquoise4"))))
 '(gnus-group-mail-2-face ((t (:bold t :foreground "turquoise" :weight bold))))
 '(gnus-group-mail-3-empty-face ((t (:foreground "LightCyan4"))))
 '(gnus-group-mail-3-face ((t (:bold t :foreground "LightCyan1" :weight bold))))
 '(gnus-group-mail-low-empty-face ((t (:foreground "SteelBlue4"))))
 '(gnus-group-mail-low-face ((t (:bold t :foreground "SteelBlue2" :weight bold))))
 '(gnus-group-news-1-empty-face ((t (:foreground "Salmon4"))))
 '(gnus-group-news-1-face ((t (:bold t :foreground "FireBrick1" :weight bold))))
 '(gnus-group-news-2-empty-face ((t (:foreground "darkorange3"))))
 '(gnus-group-news-2-face ((t (:bold t :foreground "dark orange" :weight bold))))
 '(gnus-group-news-3-empty-face ((t (:foreground "turquoise4"))))
 '(gnus-group-news-3-face ((t (:bold t :foreground "Aquamarine" :weight bold))))
 '(gnus-group-news-4-empty-face ((t (:foreground "SpringGreen4"))))
 '(gnus-group-news-4-face ((t (:bold t :foreground "SpringGreen2" :weight bold))))
 '(gnus-group-news-5-empty-face ((t (:foreground "OliveDrab4"))))
 '(gnus-group-news-5-face ((t (:bold t :foreground "OliveDrab2" :weight bold))))
 '(gnus-group-news-6-empty-face ((t (:foreground "DarkGoldenrod4"))))
 '(gnus-group-news-6-face ((t (:bold t :foreground "DarkGoldenrod3" :weight bold))))
 '(gnus-group-news-low-empty-face ((t (:foreground "wheat4"))))
 '(gnus-group-news-low-face ((t (:bold t :foreground "tan4" :weight bold))))
 '(gnus-header-content-face ((t (:foreground "LightSkyBlue3"))))
 '(gnus-header-from-face ((t (:bold t :foreground "light cyan" :weight bold))))
 '(gnus-header-name-face ((t (:bold t :foreground "DodgerBlue1" :weight bold))))
 '(gnus-header-newsgroups-face ((t (:italic t :bold t :foreground "LightSkyBlue3" :slant italic :weight bold))))
 '(gnus-header-subject-face ((t (:bold t :foreground "light cyan" :weight bold))))
 '(gnus-signature-face ((t (:italic t :foreground "salmon" :slant italic))))
 '(gnus-splash-face ((t (:foreground "Firebrick1"))))
 '(gnus-summary-cancelled-face ((t (:background "black" :foreground "yellow"))))
 '(gnus-summary-high-ancient-face ((t (:bold t :foreground "MistyRose4" :weight bold))))
 '(gnus-summary-high-read-face ((t (:bold t :foreground "tomato3" :weight bold))))
 '(gnus-summary-high-ticked-face ((t (:bold t :foreground "coral" :weight bold))))
 '(gnus-summary-high-unread-face ((t (:italic t :bold t :foreground "red1" :slant italic :weight bold))))
 '(gnus-summary-low-ancient-face ((t (:italic t :foreground "DarkSeaGreen4" :slant italic))))
 '(gnus-summary-low-read-face ((t (:foreground "SeaGreen4"))))
 '(gnus-summary-low-ticked-face ((t (:italic t :foreground "Green4" :slant italic))))
 '(gnus-summary-low-unread-face ((t (:italic t :foreground "green3" :slant italic))))
 '(gnus-summary-normal-ancient-face ((t (:foreground "RoyalBlue"))))
 '(gnus-summary-normal-read-face ((t (:foreground "khaki4"))))
 '(gnus-summary-normal-ticked-face ((t (:foreground "khaki3"))))
 '(gnus-summary-normal-unread-face ((t (:foreground "khaki"))))
 '(gnus-summary-selected-face ((t (:foreground "gold" :underline t))))
 '(green ((t (:foreground "green"))))
 '(gui-button-face ((t (:foreground "red" :background "black"))))
 '(gui-element ((t (:bold t :background "#ffffff" :foreground "#000000" :weight bold))))
 '(header-line ((t (:box (:line-width -1 :style released-button) :background "grey20" :foreground "grey90" :box nil))))
 '(highlight ((t (:background "PaleGreen" :foreground "DarkGreen"))))
 '(highline-face ((t (:background "SeaGreen"))))
 '(holiday-face ((t (:background "DimGray"))))
 '(info-menu-5 ((t (:underline t))))
 '(info-node ((t (:bold t :foreground "DodgerBlue1" :underline t :weight bold))))
 '(info-xref ((t (:bold t :foreground "DodgerBlue3" :weight bold))))
 '(isearch ((t (:background "sea green" :foreground "black"))))
 '(isearch-lazy-highlight-face ((t (:background "paleturquoise4"))))
 '(italic ((t (:italic t :foreground "chocolate3" :slant italic))))
 '(menu ((t (nil))))
 '(message-cited-text-face ((t (:foreground "White"))))
 '(message-header-cc-face ((t (:foreground "light cyan"))))
 '(message-header-name-face ((t (:foreground "DodgerBlue1"))))
 '(message-header-newsgroups-face ((t (:italic t :bold t :foreground "LightSkyBlue3" :slant italic :weight bold))))
 '(message-header-other-face ((t (:foreground "LightSkyBlue3"))))
 '(message-header-subject-face ((t (:bold t :foreground "light cyan" :weight bold))))
 '(message-header-to-face ((t (:bold t :foreground "light cyan" :weight bold))))
 '(message-header-xheader-face ((t (:foreground "DodgerBlue3"))))
 '(message-mml-face ((t (:foreground "ForestGreen"))))
 '(message-separator-face ((t (:background "cornflower blue" :foreground "chocolate"))))
 '(mode-line ((t (:background "dark olive green" :foreground "wheat" :box (:line-width -1 :style released-button)))))
 '(mode-line-buffer-id ((t (:bold t :background "dark olive green" :foreground "beige" :weight bold))))
 '(mode-line-mousable ((t (:bold t :background "dark olive green" :foreground "yellow green" :weight bold))))
 '(mode-line-mousable-minor-mode ((t (:bold t :background "dark olive green" :foreground "wheat" :weight bold))))
 '(paren-blink-off ((t (:foreground "brown"))))
 '(region ((t (:background "dark cyan" :foreground "cyan"))))
 '(ruler-mode-column-number-face ((t (:box (:color "grey76" :line-width 1 :style released-button) :background "grey76" :foreground "black"))))
 '(ruler-mode-current-column-face ((t (:bold t :box (:color "grey76" :line-width 1 :style released-button) :background "grey76" :foreground "yellow" :weight bold))))
 '(ruler-mode-default-face ((t (:background "grey76" :foreground "grey64" :box (:color "grey76" :line-width 1 :style released-button)))))
 '(ruler-mode-fill-column-face ((t (:box (:color "grey76" :line-width 1 :style released-button) :background "grey76" :foreground "red"))))
 '(ruler-mode-margins-face ((t (:box (:color "grey76" :line-width 1 :style released-button) :foreground "grey64" :background "grey64"))))
 '(ruler-mode-tab-stop-face ((t (:box (:color "grey76" :line-width 1 :style released-button) :background "grey76" :foreground "steelblue"))))
 '(scroll-bar ((t (nil))))
 '(secondary-selection ((t (:background "Aquamarine" :foreground "SlateBlue"))))
 '(show-paren-match-face ((t (:bold t :background "Aquamarine" :foreground "steel blue" :weight bold))))
 '(show-paren-mismatch-face ((t (:background "Red" :foreground "White"))))
 '(swbuff-current-buffer-face ((t (:bold t :foreground "red" :weight bold))))
 '(text-cursor ((t (:background "Red" :foreground "white"))))
 '(tool-bar ((t (:background "grey75" :foreground "black" :box (:line-width 1 :style released-button)))))
 '(trailing-whitespace ((t (:background "red"))))
 '(underline ((t (:underline t))))
 '(w3m-anchor-face ((t (:bold t :foreground "DodgerBlue1" :weight bold))))
 '(w3m-arrived-anchor-face ((t (:bold t :foreground "DodgerBlue3" :weight bold))))
 '(w3m-header-line-location-content-face ((t (:background "dark olive green" :foreground "wheat"))))
 '(w3m-header-line-location-title-face ((t (:background "dark olive green" :foreground "beige"))))
 '(widget-button-face ((t (:bold t :foreground "green" :weight bold))))
 '(widget-button-pressed-face ((t (:foreground "red"))))
 '(widget-documentation-face ((t (:foreground "lime green"))))
 '(widget-field-face ((t (:foreground "LightBlue"))))
 '(widget-inactive-face ((t (:foreground "DimGray"))))
 '(widget-single-line-field-face ((t (:foreground "LightBlue"))))
 '(woman-bold-face ((t (:bold t :weight bold))))
 '(woman-italic-face ((t (:italic t :foreground "beige" :slant italic))))
 '(woman-unknown-face ((t (:foreground "LightSalmon"))))
 '(zmacs-region ((t (:background "dark cyan" :foreground "cyan")))))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'kingsajz)

;;; kingsajz-theme.el ends here
