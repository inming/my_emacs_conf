(transient-mark-mode 1)
;(global-set-key "\C-cc" 'org-capture)
;(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
;(global-set-key "\C-cb" 'org-iswitchb)
(setq org-startup-indented t)
(setq org-return-follows-link t)
(setq org-hide-leading-stars-before-indent-mode t)
(setq org-startup-folded "content")
(setq org-src-preserve-indentation t)
(add-hook 'org-mode-hook
          (lambda ()
            (turn-on-font-lock) ; not needed when global-font-lock-mode is on
            ; 当文件已经存在且不为空时，设为view-mode
            (if (and (buffer-file-name) (file-exists-p (buffer-file-name))
                    (> (buffer-size) 0))
                (progn
                  (view-mode-enable)
;                  (setq cursor-type 'hollow)
                  )
              )
;            (setq org-enable-table-editor nil)
            (setq truncate-lines nil)
            (linum-mode 0)   ; org-mode下不显示行号
            (iimage-mode t)
            (setq line-spacing 6)
            )
          )
;(linum-mode nil)
;(setq org-todo-keywords
;      (quote ((sequence "TODO(t)" "CONTINUE(c)" "WAIT(w)" "HOLD(h)" "|" "CLOSE(d)" "CANCEL(C@/!)"))))
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "CONTINUE(c)" "WAIT(w)" "HOLD(h)" "|" "DONE(d)" "CANCEL(C)"))))

(setq org-support-shift-select t)

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "blue" :weight bold)
              ("CONTINUE" :foreground "forest green" :weight bold)
              ("DONE" :foreground "orange" :weight bold)
              ("WAIT" :foreground "red" :weight bold)
              ("HOLD" :foreground "forest green" :background "gold" :weight bold)
              ("CANCEL" :foreground "gray" :weight bold))))

(setq org-export-html-style "
<style type=\"text/css\">
    p { text-indent: 2em; }
    html { font-family: 宋体; line-height: 1.4}
    .todo.TODO { color: blue; }
    .todo.HOLD {color: orange; }
    h1 { font-size: 2.0em; margin-top: 0.5em; margin-bottom: 0.5em;}
    h2 { font-size: 1.8em; margin-top: 0.5em; margin-bottom: 0.5em;}
    h3 { font-size: 1.5em; margin-top: 0.5em; margin-bottom: 0.5em;}
    h4 { font-size: 1.2em; margin-top: 0.5em; margin-bottom: 0.5em;}
</style>")

(setq org-link-frame-setup
      '((vm . vm-visit-folder-other-frame)
        (gnus . org-gnus-no-new-news)
        (file . find-file)
        (wl . wl-other-frame))
      )

(setq org-file-apps
      '(
        (auto-mode . emacs)
        ("\\.mm\\'" . default)
        ("\\.x?html?\\'" . default)
        ("\\.pdf\\'" . system)
        ("\\.pptx?\\'" . system)
        )
      )

(setq org-refile-targets (quote ((org-agenda-files :tag . "archive"))))
(setq org-refile-use-outline-path 'file)
;(setq org-archive-location "%_archive")

(if (eq system-type 'windows-nt)
    (progn
      (require 'org-outlook)
      (org-add-link-type "outlook" 'org-outlook-open)
      (defun org-outlook-open (id)
        "Open the Outlook item identified by ID.  ID should be an Outlook GUID."
        (w32-shell-execute "open" "C:/Program Files/Microsoft Office/Office14/OUTLOOK.exe" (concat "outlook:" id))))
  )

(provide 'org-mode-settings)
