;; to ensure system-wise dependencies
(use-package use-package-ensure-system-package
  :ensure t)

(setq custom-file (expand-file-name "~/tmp/custom.el")) ;; discard the custom file
;; (when (file-exists-p custom-file)
;;   (load custom-file))

(setq make-backup-files nil)
(define-coding-system-alias 'UTF-8 'utf-8)
(define-coding-system-alias 'utf8 'utf-8)
(set-language-environment 'utf-8)

(defun xah-new-empty-buffer ()
  "Create a new empty buffer.
New buffer will be named “untitled” or “untitled<2>”, “untitled<3>”, etc.

It returns the buffer (for elisp programing).

URL `http://ergoemacs.org/emacs/emacs_new_empty_buffer.html'
Version 2017-11-01"
  (interactive)
  (let (($buf (generate-new-buffer "untitled")))
    (switch-to-buffer $buf)
    (funcall initial-major-mode)
    (setq buffer-offer-save t)
    $buf
    ))

(setq initial-major-mode (quote text-mode))
(setq initial-buffer-choice 'xah-new-empty-buffer)


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

(setq ring-bell-function 'ignore)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)


;; for some reasons, use-package on hydra with customizations to
;; hydra-is-helpful and -lv inteferes with load-theme, so I used plain install
;; and require
(use-package ivy
  :ensure t)

(use-package swiper
  :ensure t
  :after ivy)

(use-package counsel
  :ensure t
  :after swiper
  :init
  (setq ivy-use-virtual-buffers nil)
  (setq ivy-count-format "(%d/%d) ")
  :config
  (global-set-key (kbd "M-y") 'counsel-yank-pop)
  (ivy-mode)
  (counsel-mode))

(add-hook 'eshell-mode-hook
  (lambda ()
    (define-key eshell-mode-map (kbd "<tab>")
      'completion-at-point)))

(setq tramp-default-method "ssh")

(require 'server)
(unless (server-running-p) (server-start))
(add-hook 'server-switch-hook
          (lambda nil
            (let ((server-buf (current-buffer)))
              (bury-buffer)
              (switch-to-buffer-other-frame server-buf))))

(custom-set-variables '(server-kill-new-buffers t))
(add-hook 'server-done-hook (lambda () (delete-frame)))

(global-unset-key (kbd "C-z")) ;; unbind (suspend-frame) to C-z
(global-unset-key (kbd "C-x z")) ;; unbind repeat to C-x
(global-set-key (kbd "C-z") 'repeat)

(provide 'mod-base)
