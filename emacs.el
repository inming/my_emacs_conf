; 运行环境设定
(setq load-path (cons (expand-file-name "~/.emacs.d/lisp") load-path))  ; 加载个人配置
(setq visible-bell t)                                                   ; 不想听到响铃
(setq ring-bell-function (lambda ()  t))                                ; 也不想看到屏幕闪烁
(setq auto-save-default nil)                                            ; 关闭auto save
(menu-bar-mode -1)
(if (display-graphic-p)
    (progn
      (tool-bar-mode -1)
      ;;(menu-bar-mode -1)
      (scroll-bar-mode -1)
      )
)
;(set-background-color "black")
;(set-foreground-color "white")
;(require 'hideshow-org)
;
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(require 'linum-off)
(global-linum-mode t)  ; show line number
(linum-mode 1)
(setq linum-format "%4d  ")
(setq default-directory "~/")
;(global-hl-line-mode 1)
;(set-face-background hl-line-face "midnight blue")

; http://cx4a.org/software/auto-complete/
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/lisp/ac-dict")
(ac-config-default)

; 语言和编码设定
(set-language-environment 'Chinese-GB)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(if (eq system-type 'windows-nt)
    (set-clipboard-coding-system 'euc-cn))
(if (or (eq system-type 'gnu/linux) (eq system-type 'darwin))
    (set-clipboard-coding-system 'utf-8))
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
(setq-default pathname-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

; 不同环境下的字体设置
(if (and (eq system-type 'windows-nt) (display-graphic-p))
    (progn
      (set-face-attribute
       'default nil :font "Consolas 13")
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font (frame-parameter nil 'font)
                          charset
                          (font-spec :family "Microsoft Yahei")))
  ))
;(setq face-font-rescale-alist '(("微软雅黑" . 1.1) ("Microsoft Yahei" . 1.1)))
(if (and (eq system-type 'gnu/linux) (display-graphic-p))
    (progn
      (set-face-attribute
       'default nil :font "WenQuanYi Micro Hei Mono 11")
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font (frame-parameter nil 'font)
                          charset
                          (font-spec :family "WenQuanYi Micro Hei" :size 18)))
      ))
(if (and (eq system-type 'darwin) (display-graphic-p))
    (progn
      (set-face-attribute
       'default nil :font "Monaco 12")
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "STHeiti" :size 14)))
      ))

; theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(require 'load-theme-buffer-local)
(load-theme 'inming t)

; 滚动设定，参考：http://www.emacswiki.org/emacs/SmoothScrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))                     ; 一次滚动一行
(setq mouse-wheel-progressive-speed nil)                                ; 关闭滚动加速
(setq scroll-conservatively 10000)                                      ; 当光标在窗口顶部或底部移动时，每次只滚动一行

(require 'template)
(setq template-default-directories (cons (expand-file-name "~/.template/") template-default-directories))
(template-initialize)

; 编辑设定
(setq-default indent-tabs-mode nil)        ; 用空格替换TAB
(setq-default require-final-newline nil)   ; 文件通过空行结束
(setq-default tab-width 4)                 ; TAB的长度为4个空格
(show-paren-mode 1)                        ; 显示对应的括号
(setq show-paren-delay 0)                  ; 显示对应的括号的延迟为0，立即显示
(setq whitespace-style '(trailing tabs newline tab-mark newline-mark))
(require 'blank-mode)
(global-blank-mode t)
(setq blank-style 'color)
(setq blank-chars '(trailing tabs empty))
;(require 'session)
;(add-hook 'after-init-hook 'session-initialize)
(size-indication-mode 1)

; 保存文件的时候，如果文件目录不存在，自动创建目录
(defadvice save-buffer (before make-directory-maybe (&optional args) activate)
  "Create parent directory if not exists while visiting file."
  (when buffer-file-name
    (let ((dir (file-name-directory buffer-file-name)))
      (when (and (not (file-exists-p dir))
                 (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
        (make-directory dir t)))))

;; maximize the frame at startup
(require 'maxframe)
(add-hook 'window-setup-hook `maximize-frame t)

;; emacs layout

; for backup
(setq make-backup-files t)
(setq version-control t)
(setq kept-old-versions 1)
(setq kept-new-versions 16)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/.backup")))
(setq backup-by-copying t)
(defun force-backup-of-buffer () ; backup after each save
  (let ((buffer-backed-up nil))
    (backup-buffer)))
(add-hook 'before-save-hook  'force-backup-of-buffer)

; buffer间切换优化
(require 'iswitchb)
(if (> 24 (string-to-number(substring (emacs-version) 10 12)))
    (iswitchb-default-keybindings)
  (iswitchb-mode 1))
; Using the arrow keys to select a buffer
; http://emacswiki.org/emacs/IswitchBuffers#toc4
(defun iswitchb-local-keys ()
  (mapc (lambda (K)
          (let* ((key (car K)) (fun (cdr K)))
            (define-key iswitchb-mode-map (edmacro-parse-keys key) fun)))
        '(("<right>" . iswitchb-next-match)
          ("<left>"  . iswitchb-prev-match)
          ("<up>"    . ignore             )
          ("<down>"  . ignore             ))))
(add-hook 'iswitchb-define-mode-map-hook 'iswitchb-local-keys)
; for easy switch buffer
; http://technotes-himanshu.blogspot.jp/2010/08/ignoring-emacs-auto-buffers-in.html
(defun emacs-buffer-p (name)
  (string-match-p "\\*.*\\*" name))
(defun next-non-emacs-buffer (&optional original)
  "Similar to next-buffer, but ignores emacs buffer such as *scratch*, *messages* etc."
  (interactive)
  (let ((tmp-orig (or original (buffer-name))))
    (next-buffer)
    (if (and
         (not (eq (buffer-name) tmp-orig))
         (emacs-buffer-p (buffer-name)))
        (next-non-emacs-buffer tmp-orig))))
(defun previous-non-emacs-buffer (&optional original)
  "Similar to previous-buffer, but ignores emacs buffer such as *scratch*, *messages* etc."
  (interactive)
  (let ((tmp-orig (or original (buffer-name))))
    (previous-buffer)
    (if (and
         (not (eq (buffer-name) tmp-orig))
         (emacs-buffer-p (buffer-name)))
        (previous-non-emacs-buffer tmp-orig))))
(global-set-key (kbd "C-<left>") 'previous-non-emacs-buffer)
(global-set-key (kbd "C-<right>") 'next-non-emacs-buffer)
(global-set-key (kbd "C-x C-b") 'iswitchb-buffer) ; 不喜欢手误的时候调出切换buffer的窗口
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)

; for cscope
(defun my-cscope-mode-hook ()
  (interactive)
  (define-key cscope-list-entry-keymap (kbd "q") 'delete-window)
)
(add-hook 'cscope-list-entry-hook 'my-cscope-mode-hook)

; for tags
; http://www.emacswiki.org/emacs/EmacsTags
; build tags
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (eshell-command
   (format "find %s -type f -name \"*.[ch]\" | etags -" dir-name)))
(defun find-file-upwards (file-to-find)
  "Recursively searches each parent directory starting from the default-directory.
looking for a file with name file-to-find.  Returns the path to it
or nil if not found."
  (labels
      ((find-file-r (path)
                    (let* ((parent (file-name-directory path))
                           (possible-file (concat parent file-to-find)))
                      (cond
                       ((file-exists-p possible-file) possible-file) ; Found
                       ;; The parent of ~ is nil and the parent of / is itself.
                       ;; Thus the terminating condition for not finding the file
                       ;; accounts for both.
                       ((or (null parent) (equal parent (directory-file-name parent))) nil) ; Not found
                       (t (find-file-r (directory-file-name parent))))))) ; Continue
    (find-file-r default-directory)))
(defun search-and-load-tags ()
  (let ((my-tags-file (find-file-upwards "TAGS")))
    (when (not (equal my-tags-file tags-file-name))   ; 避免重复加载，目前的判断方式比较简单，需要改进
      (message "Loading tags file: %s" my-tags-file)
      (visit-tags-table my-tags-file)))
  )
; 打开c/c++文件时自动加载可能的TAGS文件
(add-hook 'c-mode-common-hook 'search-and-load-tags)

; so that C-b works when search, otherwise, Enter will be the only way to exit search
(setq search-exit-option nil)

; for mode line
(require 'mode-line-settings)

;--------------------------------
; for org-mode
;--------------------------------
(setq load-path (cons "~/.emacs.d/lisp/org/lisp" load-path))
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(require 'org-mode-settings)

; HOME键定位到文件开头
(global-set-key [(home)] 'beginning-of-buffer)
; END键定位到文件末尾
(global-set-key [(end)] 'end-of-buffer)

; 复制一行
;(defun kill-ring-save-current-line ()
;  "copy the current non-empty line to the kill-ring"
;  (interactive)
;  (unless (equal (line-beginning-position) (line-end-position))
;    (kill-ring-save (line-beginning-position) (line-end-position))))
;(global-set-key [f8] 'kill-ring-save-current-line)

(setq vc-follow-symlinks t)

; 为了能通过C-SPC调出输入法，改变默认的绑定
;(global-set-key (kbd "C-SPC") 'nil)
;(global-set-key [?\S- ] 'set-mark-command)

;(global-set-key [f2] 'list-bookmarks)

; MS BAT mode
(require 'bat-mode)
(setq auto-mode-alist
      (append
       (list (cons "\\.[bB][aA][tT]$" 'bat-mode))
       ;; For DOS init files
       (list (cons "CONFIG\\."   'bat-mode))
       (list (cons "AUTOEXEC\\." 'bat-mode))
       auto-mode-alist))
(autoload 'bat-mode "bat-mode"
  "DOS and WIndows BAT files" t)

(load "vimrc-mode")
(add-to-list 'auto-mode-alist '(".vim\\(rc\\)?$" . vimrc-mode))

(require 'saveplace)
(setq-default save-place t)

(setq shell-file-name "bash")

(put 'narrow-to-region 'disabled nil)

;; For EOS(Emacs Octave Support)
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))


(add-hook 'c++-mode-hook
          (lambda ()
            (hs-minor-mode 1)
            (hs-org/minor-mode 1)
            )
          )

(require 'xcscope)
(setq cscope-do-not-update-database t)

(add-hook 'php-mode-hook
          (lambda ()
            (hs-minor-mode 1)
            (hs-org/minor-mode 1)
            )
          )
(global-set-key [f1] 'hs-toggle-hiding)

(c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
(c-set-offset 'arglist-cont-nonempty 'c-lineup-math) ; for DBTNG fields and values
(c-set-offset 'arglist-close 0)

;; recent file list
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key [f5] 'recentf-open-files)

;; for tab
(setq default-tab-width 4)
(setq tab-width 4)
(setq c-basic-offset 4)
(setq-default indent-tabs-mode nil)
(setq tab-stop-list (let ((stops '(4)))
                      (while (< (car stops) 120)
                        (setq stops (cons (+ 4 (car stops)) stops)))
                      (nreverse stops)))

;----------------------------------------
; for php developement
;----------------------------------------

; web mode
; http://web-mode.org/
(require 'web-mode)
(setq web-mode-enable-current-element-highlight t)
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-style-padding 4)
  (setq web-mode-script-padding 4)
  (setq web-mode-block-padding 0)
  (setq web-mode-comment-style 2)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-css-colorization t)
  (local-set-key (kbd "RET") 'newline-and-indent)
  (set-face-attribute 'web-mode-html-tag-face nil :foreground "yellow")
  (set-face-attribute 'web-mode-current-element-highlight-face nil :background "sienna4")
)
(add-hook 'web-mode-hook  'my-web-mode-hook)
(add-to-list 'auto-mode-alist '("\\.tpl$" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))

; ---- php mode settings -----
; http://php-mode.sourceforge.net/php-mode.htmlxc
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
;(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
;(add-to-list 'auto-mode-alist '("\\.tpl$" . nxml-mode))

; for php/html/javascript/css indent
; https://github.com/sabof/web-mixed-indentation-mode
(require 'wmi)
(add-hook 'php-mode-hook  (lambda () (wmi 1)))
(add-hook 'css-mode-hook  (lambda () (wmi 1)))
(add-hook 'nxml-mode-hook (lambda () (wmi 1)))
(add-hook 'js-mode-hook   (lambda () (wmi 1)))

; for html edit
;(require 'hl-tags-mode)
;(fset 'xml-mode 'nxml-mode)
;(add-hook 'sgml-mode-hook (lambda () (hl-tags-mode 1)))
;(add-hook 'nxml-mode-hook (lambda () (hl-tags-mode 1)))

(which-function-mode 1)

;(require 'modtime-skip-mode)
;(modtime-skip-mode)


;; my note shortcut
;(defun my-open-note ()
;  "open my current note"
;  (interactive)
;)


(defun kill-till-start-of-line ()
  "kill from point to start of line"
  (interactive)
  (kill-line 0)
)
(global-set-key (kbd "C-S-k") 'kill-till-start-of-line)
(global-set-key [(control *)] 'highlight-symbol-at-point) ; just like * in vim
;; (global-set-key [f3] 'highlight-symbol-next)
;; (global-set-key [(shift f3)] 'highlight-symbol-prev)
;; (global-set-key [(meta f3)] 'highlight-symbol-query-replace)

;(require 'table)

;(when window-system
;  (speedbar t))

;(load-file "~/.emacs.d/cedet-1.1/common/cedet.el")
;(semantic-mode 1)
;(global-ede-mode 1)                      ; Enable the Project management system
;(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion
;(global-srecode-minor-mode 1)            ; Enable template insertion menu

;(setq imenu-auto-rescan t)
; http://www.emacswiki.org/emacs/SrSpeedbar
(require 'sr-speedbar)
(global-set-key [f6] 'sr-speedbar-toggle)
(eval-after-load "speedbar" '(speedbar-add-supported-extension ".php"))
(setq speedbar-use-images nil)
(require 'highlight-symbol)

; https://github.com/capitaomorte/yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
        ))
(define-key yas-minor-mode-map [(tab)] nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(yas-global-mode 1)

;(require 'python)


(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
;(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
;(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(setq markdown-command "multimarkdown")

(setq load-path (cons "~/.emacs.d/lisp/ess-14.09/lisp" load-path))
(require 'ess-site)
(ess-toggle-S-assign nil)



; so that customize system will not write to .emacs
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
