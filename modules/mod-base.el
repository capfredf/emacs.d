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
;; disable destop-save-mode if something visual goes wrong, because it tends to save *everything*
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

;; (global-set-key (kbd "C-x b") 'counsel-switch-buffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
(global-set-key (kbd "C-x C-b") 'ibuffer)


(use-package which-key
  :ensure t
  :config
  (setq which-key-show-early-on-C-h t)
  (setq which-key-idle-delay 10000)
  (setq which-key-idle-secondary-delay 0.05)
  (which-key-mode))

;; (use-package ivy
;;   :ensure t
;;   :config
;;   (global-set-key (kbd "s-m r") 'ivy-resume)
;;   (ivy-mode))

;; (use-package counsel
;;   :ensure t
;;   :init
;;   (setq ivy-use-virtual-buffers nil)
;;   (setq ivy-count-format "(%d/%d) ")
;;   :config
;;   (global-set-key (kbd "M-y") 'counsel-yank-pop)
;;   (global-set-key (kbd "s-m s") 'counsel-ag)
;;   (counsel-mode))

(add-hook 'eshell-mode-hook
  (lambda ()
    (define-key eshell-mode-map (kbd "<tab>")
      'completion-at-point)))

;; faster than the default "scp"
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
;; (add-hook 'server-swtich-hook
;;           (lambda nil
;;             (let ((server-buf (current-buffer)))
;;               (bury-buffer)
;;               (switch-to-buffer-other-frame server-buf))))

;; (custom-set-variables '(server-kill-new-buffers t))
;; (add-hook 'server-done-hook (lambda () (delete-frame)))

(global-unset-key (kbd "M-z")) ;; unbind (suspend-frame) to C-z
(global-unset-key (kbd "C-x z")) ;; unbind repeat to C-x
(global-set-key (kbd "M-z") 'repeat)
(icomplete-mode +1)


(use-package ace-window
  :ensure t
  :custom
  (aw-dispatch-always t) ;; this is the default value
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind (("M-o" . ace-window)))

(require 'subr-x)
(use-package projectile
  :ensure t
  :demand t
  :custom
  (projectile-completion-system 'default)
  (projectile-enable-caching t)
  (projectile-use-git-grep t)
  (projectile-git-submodule-command "")
  (projectile-indexing-method 'alien)
  :bind
  ("s-m s" . projectile-ag)
  :bind-keymap
  ("s-m p" . projectile-command-map)
  :config
  (which-key-add-key-based-replacements "s-m p" "projectile")
  (projectile-mode)
  (projectile-register-project-type 'racket '(".racket_prj")
				  :compile "raco setup typed-racket typed"
				  :test "raco make -v typed-racket-test/main.rkt && racket typed-racket-test/main.rkt --unit"
				  :run "echo 'hell world'"))

(use-package diff-hl :ensure t)

(use-package magit
  :ensure t
  :bind (("s-m m" . magit-status))
  :config (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(define-key icomplete-minibuffer-map (kbd "<s-tab>") 'icomplete-force-complete)

(winner-mode t)
;;(abbrev-mode t)
(setq-default abbrev-mode t)


;; (defun clear-invisible-buffer ()
;;   (interactive)
;;   (let* ((whitelisted (seq-filter (lambda (b) (string-prefix-p " " (buffer-name b))) (buffer-list)))
;;          (bl-in-other-tabs (apply #'seq-concatenate 'list
;;                                   (seq-map (lambda (f)
;;                                              (apply #'seq-concatenate 'list
;;                                                     (seq-map (lambda (tab)
;;                                                                (alist-get 'wc-bl tab))
;;                                                              (tab-bar--tabs-recent nil f))))
;;                                            (frame-list)))))
;;     (seq-do (lambda (b)
;;               (unless (or (get-buffer-window b)
;;                           (seq-contains bl-in-other-tabs b)
;;                           (seq-contains whitelisted b))
;;                 ;; (message (buffer-name b))
;;                 ;; (error nil)
;;                 (kill-buffer b)))
;;             (apply #'seq-concatenate 'list
;;                    (mapcar (lambda (f) (buffer-list f))
;;                            (frame-list))))))

;; (advice-add #'desktop-save :before (lambda (dirname &optional release only-if-changed version)
;;                                      (clear-invisible-buffer)))


(global-set-key (kbd "s-m t") tab-prefix-map)
;; (use-package eyebrowse
;;   :ensure t
;;   :custom
;;   (eyebrowse-keymap-prefix (kbd "s-m e"))
;;   :config
;;   (require 'eyebrowse)
;;   (which-key-add-key-based-replacements "s-m e" "eyebrowse")
;;   (eyebrowse-mode t)
;;   ;; (eyebrowse-switch-to-window-config 0)
;;   ;; (eyebrowse-rename-window-config 0 "emacs")
;;   ;; (find-file "~/.emacs.d/init.el")
  
;;   ;; (eyebrowse-switch-to-window-config 1)
;;   ;; (eyebrowse-rename-window-config 1 "typed-racket")
;;   ;; (find-file "~/code/racket-extra-pkgs/typed-racket/")
  
;;   ;; (eyebrowse-switch-to-window-config 2)
;;   ;; (eyebrowse-rename-window-config 2 "racket")
;;   ;; (find-file "~/code/racket/racket/")

;;   ;; (eyebrowse-switch-to-window-config 3)
;;   ;; (eyebrowse-rename-window-config 3 "pie")
;;   ;; (find-file "~/code/lecture-types-2020/")

;;   ;; (eyebrowse-switch-to-window-config 4)
;;   ;; (eyebrowse-rename-window-config 4 "sp-model")
;;   ;; (find-file "~/code/struct-properties/")
;;   )

(defun rename-current-file-and-buffer ()
  ;; from Batsov
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(defvar tab-cfg '(("Dev" . "~/code/racket-extra-pkgs/typed-racket")
                  ("Thoughts" . "~/brain")))

(defun recreate-main-workspace ()
  "Recreate all my main tabs in a current frame.  

This function doesn't check if there are pre-existing tabs with
the same name or for the same purpose "
  (interactive)
  (dolist (c tab-cfg)
    (tab-rename (car c))
    (dired (expand-file-name (cdr c)))
    (tab-new)))


(provide 'mod-base)
