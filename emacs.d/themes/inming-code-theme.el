(deftheme inming-code
  "Created 2013-02-12.")

(custom-theme-set-faces
 'inming-code
 '(cursor ((t (:background "#fce94f"))))
 '(font-lock-builtin-face ((t (:foreground "#ad7fa8"))))
 '(font-lock-comment-delimiter-face ((t (:inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((t (:slant italic :foreground "#00A6FF"))))
 '(font-lock-constant-face ((t (:foreground "#e6a8df"))))
 '(font-lock-doc-face ((t (:inherit (font-lock-string-face)))))
 '(font-lock-function-name-face ((t (:height 1.2 :weight bold :foreground "#fce94f"))))
 '(font-lock-keyword-face ((t (:weight bold :foreground "#FC6F09"))))
 '(font-lock-negation-char-face ((t nil)))
 '(font-lock-preprocessor-face ((t (:inherit (font-lock-builtin-face)))))
 '(font-lock-regexp-grouping-backslash ((t (:inherit (bold)))))
 '(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
 '(font-lock-string-face ((t (:foreground "#8DFF0A"))))
 '(font-lock-type-face ((t (:weight normal :underline t :foreground "#00FFF8"))))
 '(font-lock-variable-name-face ((t (:weight normal :foreground "#fcaf3e"))))
 '(font-lock-warning-face ((t (:weight bold :foreground "#F5666D" :background "yellow" :inherit (error)))))
 '(mode-line ((t (:box (:line-width -1 :color nil :style released-button) :foreground "black" :background "lightgreen"))))
 '(mode-line-buffer-id ((t (:foreground "DeepPink3" :weight bold))))
 '(mode-line-highlight ((((class color) (min-colors 88)) (:box (:line-width 2 :color "grey40" :style released-button))) (t (:inherit (highlight)))))
 '(default ((t (:stipple nil :background "#002240" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 128 :width normal :foundry "outline" :family "Consolas")))))

(provide-theme 'inming-code)
