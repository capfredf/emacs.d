;; to ensure system-wise dependencies
(use-package use-package-ensure-system-package
  :ensure t)

(setq custom-file (concat user-emacs-directory "setting.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(setq make-backup-files nil)
(define-coding-system-alias 'UTF-8 'utf-8)
(define-coding-system-alias 'utf8 'utf-8)
(set-language-environment 'utf-8)

(defalias 'yes-or-no-p 'y-or-n-p)

(defun splash-head ()
  "Insert the head part of the splash screen into the current buffer."
  (let* ((image-file (expand-file-name "~/.emacs.d/ThereIsNoLinearTime1.png"))
         (img (create-image image-file))
         (image-width (and img (car (image-size img))))
         (window-width (window-width)))
    (when img
      (when (> window-width image-width)
        ;; Center the image in the window.
        (insert (propertize " " 'display
                            `(space :align-to (+ center (-0.5 . ,img)))))

        ;; Change the color of the XPM version of the splash image
        ;; so that it is visible with a dark frame background.

        ;; Insert the image with a help-echo and a link.
        (make-button (prog1 (point) (insert-image img)) (point)
                     'face 'default
                     'help-echo "mouse-2, RET: Browse https://www.yahw.io"
                     'action (lambda (_button) (browse-url "https://www.yahw.io"))
                     'follow-link t)
        (insert "\n\n")))))

(defun welcome-buffer ()
  (interactive)
  (let (($buf (get-buffer-create "*Aye, aye, Captain*")))
    (with-current-buffer $buf
      (erase-buffer)
      (funcall initial-major-mode)
      (setq buffer-offer-save t)
      (splash-head)
      (insert "Thirteen years ago I knew the carpets would need vacuuming around now and having a baby seemd to be the easist and cheapest way to get the job done\n\n")
      (insert "                                                                                                                 -- Ted Chiang, Stories of Your Life")
      (setq buffer-read-only t)
      (set-buffer-modified-p nil))
    (switch-to-buffer $buf)))

;; (setq initial-major-mode (quote fundamental-mode))
;; (setq initial-buffer-choice 'welcome-buffer)
;; (setq initial-buffer-choice nil)

(setq desktop-restore-eager 10)
(desktop-save-mode t)
(use-package benchmark-init
  :ensure t
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(use-package ag :ensure t)



(use-package dired
  :hook (dired-mode . dired-hide-details-mode))


(defun read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

;; (setq old-paths
;;       (split-string (getenv "PATH") ":"))


;; (setq exec-paths
;;       (append
;;        (mapcar (lambda (x)
;; 		 (expand-file-name x))
;; 		 (read-lines "~/dotconf/path"))
;;        old-paths))

;; (setenv "PATH" (mapconcat 'identity exec-paths ":"))

(setq ring-bell-function 'ignore)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(define-key global-map [?\s-m] nil)

(global-set-key (kbd "C-x b") 'counsel-switch-buffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
(global-set-key (kbd "C-x C-b") 'ibuffer)


(use-package which-key
  :ensure t
  :config
  (setq which-key-show-early-on-C-h t)
  (setq which-key-idle-delay 10000)
  (setq which-key-idle-secondary-delay 0.05)
  (which-key-mode))

(use-package ivy
  :ensure t)

(use-package swiper
  :ensure t
  :after ivy
  :config
  (global-set-key (kbd "s-m r") 'ivy-resume))

(use-package counsel
  :ensure t
  :after swiper
  :init
  (setq ivy-use-virtual-buffers nil)
  (setq ivy-count-format "(%d/%d) ")
  :config
  (global-set-key (kbd "M-y") 'counsel-yank-pop)
  (global-set-key (kbd "s-m s") 'counsel-ag)
  (ivy-mode)
  (counsel-mode))

(add-hook 'eshell-mode-hook
  (lambda ()
    (define-key eshell-mode-map (kbd "<tab>")
      'completion-at-point)))

(setq tramp-default-method "ssh")

(require 'server)
(when (eq system-type 'darwin)
  (setq mac-mouse-wheel-mode t)
  (setq mac-mouse-wheel-smooth-scroll t))

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(unless (server-running-p) (server-start))

;; I don't know the reason that I added the code below
;; (add-hook 'server-switch-hook
;;           (lambda nil
;;             (let ((server-buf (current-buffer)))
;;               (bury-buffer)
;;               (switch-to-buffer-other-frame server-buf))))

;; (custom-set-variables '(server-kill-new-buffers t))
;; (add-hook 'server-done-hook (lambda () (delete-frame)))

(global-unset-key (kbd "M-z")) ;; unbind (suspend-frame) to C-z
(global-unset-key (kbd "C-x z")) ;; unbind repeat to C-x
(global-set-key (kbd "M-z") 'repeat)

(provide 'mod-base)
