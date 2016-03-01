;;; inming.el ---

;; Copyright 2012
;;
;; Author: inming521@gmail.com
;; Version: $Id: inming.el,v 0.0 2012/11/28 15:19:50 yinming Exp $
;; Keywords:
;; X-URL: not distributed yet

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;;

;; Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'inming)

;;; Code:

(provide 'inming)
(eval-when-compile
  (require 'cl))


;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################

(defun inming-get-headname ()
  "get head name"
  (car (nthcdr 4 (org-heading-components)))
  )

(defun inming-goto-heading (headname)
  "goto heading named"
  (goto-char (point-min))
  (if (equal "main" (inming-get-headname))
      (progn
        (org-goto-first-child)
        (while (and (not (equal headname (inming-get-headname)))
                    (org-goto-sibling))
          )
        )
    )
  )

(defun inming-create-task-structure (path taskname filename)
  "���������Ŀ¼�ṹ"
  (if (not (file-exists-p path))
      (progn
        (make-directory path t)
        (set-buffer (find-file-noselect filename))
        (insert (format "* %s" taskname))
        (save-buffer)
        (kill-buffer)
        )
    (message "path %s exists!" path)
    )
  )

(defun inming-create-task-heading (targetname path taskname filename)
  "���������"
  (let* ((mainopened (get-file-buffer "~/workspace/main.org"))
                                        ; main.org�Ƿ��Ѿ����򿪣�����򿪹�����֮ǰ��buffer
         (mainfile (if mainopened mainopened (find-file-noselect "~/workspace/main.org")))
         )
    (set-buffer mainfile)
    (inming-goto-heading "todo")   ; �ҵ�todo�ڵ�
    (end-of-line)
    (org-insert-heading)           ; ���������µ�heading
    (insert (format "TODO [#C] [[%s][%s]]([[%s][dir]])" filename taskname path))
    (org-demote)
    ;; ���֮ǰû�д򿪹�main.org���򱣴沢�ر�
    (if (not mainopened)
        (progn
          (save-buffer)
          (kill-buffer))
      )
    )
)

(defun inming-open-att-directory (open_type)
  "����Դ�������д�org�ļ��ĸ���Ŀ¼"
  (if (equal major-mode 'org-mode)
      (let ((dir (format "%s.att/%s/"
                         (file-name-directory buffer-file-name)  ; org�ļ�����Ŀ¼
                         (file-name-nondirectory (file-name-sans-extension buffer-file-name)) ; org�ļ������ƣ�ȥ����չ��
                         )))
        ; ��Ŀ¼������ʱ������Ŀ¼
        (when (and (not (file-exists-p dir))
                   (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
          (make-directory dir t))
        ; ��Ŀ¼
        (if (equal open_type 'dired)
            ; ��dired�д�
            (dired dir)
            ; ��explorer�д�
          (inming-explorer dir nil)
            )
        )
    )
  )

(defun inming-open-att-directory-in-explorer ()
  "����Դ�������д�org�ļ��ĸ���Ŀ¼"
  (interactive)
  (inming-open-att-directory nil)
)

(defun inming-open-att-directory-in-dired ()
  "��dired�д�org�ļ��ĸ���Ŀ¼"
  (interactive)
  (inming-open-att-directory 'dired)
)

(defun inming-add-task (taskname)
;  (interactive "MTask Description:")
  (interactive
   (list (read-string "Task Name: ")
         ))
  "add a task"
  (let* ((path (format "~/workspace/notes/%s/%s_%s"
                     (format-time-string "%Y")
                     (format-time-string "%Y%m%d")
                     taskname))
        (filename (format "%s/%s.org" path taskname)))
    (if (not (file-exists-p path))
        (save-excursion
          ;; ���������Ŀ¼
          (inming-create-task-structure path taskname filename)
          ;; ��������main.org
          (inming-create-task-heading "todo" path taskname filename)
          )
      (message "Task %s exists!" taskname)
      )
    )
  )

(defun inming-switch-view-mode ()
  (interactive)
  (if buffer-read-only
      (progn
        (view-mode-disable) ; disable
        (setq cursor-type default-cursor-type)
        )
    (progn
      (view-mode-enable) ; enable
      (setq cursor-type 'hollow)
      )
    )
)

;(defun copy-line (num)
;  (interactive "p")
;  "copy one line"
;  (kill-ring-save (line-beginning-position) (line-beginning-position (+ 1 num)))
;  )

(defun inming-open-default-directory-in-dired ()
  "open default directory in dired"
  (interactive)
  (dired default-directory)
)

(defun inming-copy-buffer-filename-to-clipboard ()
  "copy buffer filename to clipboard"
  (interactive)
  (let ((filename (if (buffer-file-name)
                      (buffer-file-name)
                      default-directory))
        )
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message (concat "copy '" filename "' to clipboard"))
      )
    )
  )

(defun inming-explorer (filename select)
  "open file in explorer"
  (if (file-exists-p filename)
      (w32-shell-execute
       "open"
       "explorer"
       (concat "/e,/"
               (let ((start 0) ; ��Ŀ¼�ṹת����explorer����ʶ�����ʽ
                     (name
                      (format "%s" (if select
                                       (concat "select," filename)
                                     (concat "root," filename)))
                     ))
                 (message name)
                 (while (string-match "/" name start)
                   (aset name (match-beginning 0) ?\\)
                   (setq start (match-end 0)))
                 name)
               )
       )
    )
)

(defun inming-open-default-directory-in-explorer ()
  "Open Directory In Explorer"
  (interactive)
  (w32-shell-execute
   "open"
   "explorer"
   (concat "/e,/"
           (let ((start 0) ; ��Ŀ¼�ṹת����explorer����ʶ�����ʽ
                 (name
                  (format "%s" (if (file-exists-p (buffer-file-name))
                                   (concat "select," (buffer-file-name))
                                 (concat "root," default-directory)))) ; let ��ȡ���Ǵ����ã�
                 )
             (while (string-match "/" name start)
               (aset name (match-beginning 0) ?\\)
               (setq start (match-end 0)))
             name)
           )
   )
)

;(defun my-put-file-name-on-clipboard ()
;  "Put the current file name on the clipboard"
;  (interactive)
;  (let ((filename (if (equal major-mode 'dired-mode)
;                      default-directory
;                    (buffer-file-name))))
;    (when filename
;      (with-temp-buffer
;        (insert filename)
;        (clipboard-kill-region (point-min) (point-max)))
;      (message filename))))

;;; inming.el ends here
