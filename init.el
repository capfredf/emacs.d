(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize) ;; You might already have this line
(add-to-list 'load-path (expand-file-name "cfg" user-emacs-directory))
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/agda")
(package-install 'use-package)
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(setq make-backup-files nil)

(define-coding-system-alias 'UTF-8 'utf-8)
(define-coding-system-alias 'utf8 'utf-8)
(set-language-environment 'utf-8)

(defun read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

(setq old-paths
      (split-string (getenv "PATH") ":"))


(setq exec-paths
      (append
       (mapcar (lambda (x)
		 (expand-file-name x))
		 (read-lines "~/dotconf/path"))
       old-paths))

(setenv "PATH" (mapconcat 'identity exec-paths ":"))

(dolist
    (elt '(cfg-base
           cfg-workspace
           cfg-visual
           cfg-c
           cfg-racket
           cfg-edit
           cfg-vcs
           cfg-rust))
  (require elt))

(server-start)
