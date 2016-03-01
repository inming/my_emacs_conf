(require 'inming)

(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output)))
    output))

(setq-default mode-line-format
              (list
               '(:eval
                 (if (buffer-file-name)
                     (propertize
                      (shorten-directory default-directory 30)
                      'local-map '(keymap
                                   (mode-line
                                    keymap
                                    (mouse-1 . inming-open-default-directory-in-explorer)
                                    (mouse-2 . inming-copy-buffer-filename-to-clipboard)
                                    (mouse-3 . inming-open-default-directory-in-dired)
                                    ))
                      'face 'mode-line-directory
                      'mouse-face 'mode-line-highlight
                      'help-echo (concat
                                  "Buffer Folder\n"
                                  "mouse-1: open folder in explorer\n"
                                  "mouse-2: copy full path to clipboard (include filename)\n"
                                  "mouse-3: open folder in dired"
                                  )
                      )
                   )
                 )
               mode-line-buffer-identification
               ;; was this buffer modified since the last save?
               '(:eval (if (buffer-modified-p) "[*]" "[-]"))
               " (%l,%c) "
               "[%p/%I]"
               "[%m"
               ;; i don't want to see minor-modes; but if you want, uncomment this:
               ;; minor-mode-alist  ;; list of minor modes
               "]"
               '(:eval (propertize
                        (if overwrite-mode "[Ovr]" "[Ins]")
                        'mouse-face 'mode-line-highlight
                        'local-map '(keymap
                                     (mode-line
                                      keymap
                                      (mouse-1 . overwrite-mode)
                                      ))
                        ))
               '(:eval (propertize
                        (if buffer-read-only "[RO]" "[RW]")
                        'mouse-face 'mode-line-highlight
                        'local-map '(keymap
                                     (mode-line
                                      keymap
                                      (mouse-1 . view-mode)
                                      ))
                        'help-echo "toggle-read-only"
                        ))
               '(which-func-mode ("" which-func-format))
               '(:eval
                 (if (equal major-mode 'org-mode)
                     (if (member (buffer-file-name) org-agenda-files)
                         "[Idx]"
                       )
                   )
                 )
               ;'(:eval (propertize (format-time-string "%Y/%m/%d %H:%M:%S")))
               '(:eval
                 (if (equal major-mode 'org-mode)
                     (propertize
                      "[att]"
                      'mouse-face 'mode-line-highlight
                      'local-map '(keymap
                                   (mode-line
                                    keymap
                                    (mouse-1 . inming-open-att-directory-in-explorer)
                                    (mouse-3 . inming-open-att-directory-in-dired)
                                    ))
                      'help-echo (concat
                                  "Attachment Folder\n"
                                  "mouse-1: open attachment folder in explorer\n"
                                  "mouse-3: open attachment folder in dired"
                                  )
                      ))
                 )
               '(:eval
                 (if buffer-read-only ; read only use hollow
                     (if (not (equal cursor-type 'hollow))
                         (setq cursor-type 'hollow)
                       )
                   (if overwrite-mode
                       (if (not (equal cursor-type 'box))
                           (setq cursor-type 'box)
                         )
                     (if (not (equal cursor-type 'bar))
                         (setq cursor-type 'bar)
                       )
                     )
                   )
                 )
              "%-" ;; fill with '-'
              )
              )

(defface mode-line-directory
  '((((class color) (background dark))
     (:foreground "blue" :inherit mode-line))
    (((class color) (background light))
     (:foreground "blue" :inherit mode-line))
    (t (:foreground "blue" :inherit mode-line)))
  "Face use to show directory in mode line"
  )

; 标题栏显示打开的buffer文件名
(setq frame-title-format
      '((:eval (or (buffer-file-name) (buffer-name)))))

(provide 'mode-line-settings)
