(require 'package) ;; You might already have this line
(setq gc-cons-threshold 100000000)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize) ;; You might already have this line
(add-to-list 'load-path (expand-file-name "cfg" user-emacs-directory))
(package-install 'use-package)
(setq custom-file (expand-file-name "~/tmp/custom.el")) ;; discard the custom file
;; (when (file-exists-p custom-file)
;;   (load custom-file))

(setq make-backup-files nil)

(define-coding-system-alias 'UTF-8 'utf-8)
(define-coding-system-alias 'utf8 'utf-8)
(set-language-environment 'utf-8)

(use-package benchmark-init
  :ensure t
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

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

(require 'server)
(unless (server-running-p) (server-start))
(add-hook 'server-switch-hook
          (lambda nil
            (let ((server-buf (current-buffer)))
              (bury-buffer)
              (switch-to-buffer-other-frame server-buf))))

(custom-set-variables '(server-kill-new-buffers t))
(add-hook 'server-done-hook (lambda () (delete-frame)))
