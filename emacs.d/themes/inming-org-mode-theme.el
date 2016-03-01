(deftheme inming-org-mode
  "Created 2013-02-27.")

(custom-theme-set-faces
 'inming-org-mode
 '(outline-1 ((t (:foreground "blue" :inverse-video nil :underline nil :slant normal :weight semi-bold :height 1.0 :width normal))))
 '(outline-2 ((t (:foreground "DarkOrchid4" :overline nil :underline nil :slant normal :weight semi-bold :height 1.0 :width normal))))
 '(outline-3 ((t (:foreground "firebrick4" :overline nil :underline nil :slant normal :weight semi-bold :height 1.0 :width normal))))
 '(outline-4 ((t (:foreground "black" :overline nil :underline nil :slant normal :weight semi-bold :height 1.0 :width normal))))
 '(outline-5 ((t (:foreground "purple4" :overline nil :underline nil :slant normal :weight semi-bold :height 1.0 :width normal))))
 '(outline-6 ((t (:foreground "purple3" :overline nil :underline nil :slant normal :weight semi-bold :height 1.0 :width normal))))
 '(outline-7 ((t (:foreground "purple2" :overline nil :underline nil :slant normal :weight semi-bold :height 1.0 :width normal))))
 '(outline-8 ((t (:foreground "purple1" :overline nil :underline nil :slant normal :weight semi-bold :height 1.0 :width normal))))
 '(org-hide ((t (:foreground "#e5e5e5"))))
 '(cursor ((((background light)) (:background "black")) (((background dark)) (:background "white"))))
 '(org-tag ((t (:background "gold" :box (:line-width 2 :color "grey75" :style released-button)))))
 '(org-special-keyword ((t (:foreground "DeepPink3"))))
 '(org-checkbox ((t (:foreground "DarkOrchid3"))))
 '(mode-line ((((class color) (min-colors 88)) (:foreground "black" :background "grey75" :box (:line-width -1 :color nil :style released-button))) (t (:inverse-video t))))
 '(mode-line-buffer-id ((t (:weight bold))))
 '(default ((t (:inherit nil :stipple nil :background "#e5e5e5" :foreground "gray10" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 128 :width normal :foundry "outline" :family "Consolas")))))

(provide-theme 'inming-org-mode)
