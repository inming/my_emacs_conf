(deftheme inming-default
  "Created 2013-03-15.")

(custom-theme-set-faces
 'inming-default
 '(cursor ((t (:background "navy"))))
 '(outline-1 ((t (:foreground "brown" :weight bold :height 1.0))))
 '(outline-2 ((t (:foreground "chocolate" :weight bold :height 1.0))))
 '(outline-3 ((t (:foreground "black" :weight bold :height 1.0))))
 '(outline-4 ((t (:foreground "black" :weight bold :height 1.0))))
 '(outline-5 ((t (:foreground "black" :weight normal :height 1.0))))
 '(outline-6 ((t (:foreground "black" :weight normal :height 1.0))))
 '(outline-7 ((t (:foreground "black" :weight normal :height 1.0))))
 '(outline-8 ((t (:foreground "black" :weight normal :height 1.0))))
 '(org-hide ((t (:foreground "#fff8dc"))))
 '(org-tag ((t (:background "gold" :foreground "blue" :height 1.0))))
 '(org-special-keyword ((t (:foreground "DeepPink3"))))
 '(org-checkbox ((t (:foreground "DarkOrchid3"))))
 '(mode-line ((t (:box (:line-width -1 :style released-button) :foreground "white" :background "forest green"))))
 '(mode-line-buffer-id ((t (:foreground "orange" :weight normal))))
 '(font-lock-builtin-face ((t (:foreground "#ad7fa8"))))
 '(font-lock-comment-delimiter-face ((t (:inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((t (:foreground "deep sky blue" :slant italic))))
 '(font-lock-constant-face ((t (:foreground "#e6a8df"))))
 '(font-lock-doc-face ((t (:inherit (font-lock-string-face)))))
 '(font-lock-function-name-face ((t (:foreground "blue3" :weight bold :height 1.1))))
 '(font-lock-keyword-face ((t (:foreground "purple" :weight bold))))
 '(font-lock-negation-char-face ((t nil)))
 '(font-lock-preprocessor-face ((t (:inherit (font-lock-builtin-face)))))
 '(font-lock-regexp-grouping-backslash ((t (:inherit (bold)))))
 '(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
 '(font-lock-string-face ((t (:foreground "forest green"))))
 '(font-lock-type-face ((t (:foreground "firebrick" :underline t :weight normal))))
 '(font-lock-variable-name-face ((t (:foreground "firebrick" :weight normal))))
 '(font-lock-warning-face ((t (:weight bold :foreground "#F5666D" :background "yellow" :inherit (error)))))
 '(mode-line-highlight ((t (:box (:line-width 1 :color "pale green" :style released-button)))))
 '(link ((t (:foreground "blue" :underline nil))))
 '(highlight ((t (:background "#ffc0cb" :foreground "blue" :underline t))))
 '(org-document-title ((t (:foreground "midnight blue" :weight semibold :height 1.2))))
 '(tooltip ((t (:foreground "white" :background "forest green" :inherit variable-pitch))))
 '(vertical-border ((t (:foreground "forest green"))))
 '(default ((t (:stipple nil :background "#fff8dc" :foreground "#000000" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 128 :width normal :foundry "outline" :family "Consolas")))))

(provide-theme 'inming-default)