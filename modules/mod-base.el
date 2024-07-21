;; to ensure system-wise dependencies of executable programs


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

;; (use-package benchmark-init
;;   :ensure t
;;   :config
;;   ;; To disable collection of benchmark data after init is done.
;;   (add-hook 'after-init-hook 'benchmark-init/deactivate))



(defun read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

;; (setq old-paths
;;       (split-string (getenv "PATH") ":"))


;; (push  "/usr/local/texlive/2023/bin/x86_64-linux" exec-path)
;; (setq exec-path
;;       (append
;;        (mapcar (lambda (x)
;; 		         (expand-file-name x))
;; 		       (read-lines "~/dotconf/extra/path"))
;;        old-paths))

(push "/usr/local/texlive/2023/bin/x86_64-linux" exec-path)
(push "/home/capfredf/.racket/bin" exec-path)
(push "/home/capfredf/.cabal/bin" exec-path)
;; (setenv "PATH" (concat "/home/capfredf/.racket/bin:/home/capfredf/.cabal/bin:/usr/local/texlive/2023/bin/x86_64-linux:" (getenv "PATH")))
;; (setenv "PATH" (mapconcat 'identity exec-path ":"))

(setq ring-bell-function 'ignore)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(define-key global-map [?\s-m] nil)

;; (global-set-key (kbd "C-x b") 'counsel-switch-buffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; (add-hook 'eshell-mode-hook
;;   (lambda ()
;;     (define-key eshell-mode-map (kbd "<tab>")
;;       'completion-at-point)))

;; faster than the default "scp"
(setq tramp-default-method "ssh")

(require 'server)
(when (eq system-type 'darwin)
  (setq mac-mouse-wheel-mode t)
  (setq mac-mouse-wheel-smooth-scroll t))


;; (use-package exec-path-from-shell
;;   :ensure t
;;   :config
;;   (when (memq window-system '(mac ns x))
;;     (exec-path-from-shell-initialize)))

(defun mean (lst)
  (/ (apply '+ lst) (length lst)))

;; (unless (server-running-p) (server-start))

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
;; (icomplete-mode +1)
;; (icomplete-vertical-mode +1)


;; (use-package ace-window
;;   :ensure t
;;   :custom
;;   (aw-dispatch-always t) ;; this is the default value
;;   (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
;;   :bind (("M-o" . ace-window)))

(require 'subr-x)
;; (use-package projectile
;;   :custom
;;   (projectile-completion-system 'default)
;;   (projectile-enable-caching t)
;;   (projectile-use-git-grep t)
;;   (projectile-git-submodule-command "")
;;   (projectile-indexing-method 'alien)
;;   :bind
;;   ("C-x s" . projectile-ag)
;;   :config
;;   (which-key-add-key-based-replacements "C-x p" "projectile")
;;   (projectile-mode)
;;   (projectile-register-project-type 'racket '(".racket_prj")
;; 				  :compile "raco setup typed-racket typed"
;; 				  :test "raco make -v typed-racket-test/main.rkt && racket typed-racket-test/main.rkt --unit"
;; 				  :run "echo 'hell world'"))


(defun helm-project-switch-project ()
  (interactive)
  (helm :sources (helm-build-sync-source "Helm-project-switch-project"
                   :candidates (project-known-project-roots) ;; the list is in the form of (("project-name") ...)
                   :action
                   '(("find files" . (lambda (dir)
                                       (let ((default-directory dir)
                                             ;; FIXME: use (project-current-inhibit-prompt t) for 28 and below
                                             ;; (project-current-directory-override "t")
                                             )
                                         (project-find-file))))
                     ("magit" . (lambda (dir)
                                  (magit-status dir)))))))


;; (defun helm-project-find-file-dwim (&optional include-all)
;;   "Find file at point based on context"
;;   (interactive)
;;   (let* ((pr (project-current t))
;;          (root (project-root pr))
;;          (dirs (list root)))
;;     (my-project-find-file-in
;;      (or (thing-at-point 'filename)
;;          (and buffer-file-name (file-relative-name buffer-file-name root)))
;;      dirs pr include-all)))

;; (let ((default-directory "/home/capfredf/.emacs.d/"))
;;   (file-relative-name "/home/capfredf/.emacs.d/modules/init.el"))

;; adapt project-find-file-in from project.el
;; (defun my-project-find-file-in (suggested-filename dirs project &optional include-all)
;;   "Complete a file name in DIRS in PROJECT and visit the result.

;; SUGGESTED-FILENAME is a relative file name, or part of it, which
;; is used as part of \"future history\".

;; If INCLUDE-ALL is non-nil, or with prefix argument when called
;; interactively, include all files from DIRS, except for VCS
;; directories listed in `vc-directory-exclusion-list'."
;;   (let* ((vc-dirs-ignores (mapcar
;;                            (lambda (dir)
;;                              (concat dir "/"))
;;                            vc-directory-exclusion-list))
;;          (default-directory (project-root project))
;;          ;; (file (funcall project-read-file-name-function
;;          ;;                "Find file" all-files nil 'file-name-history
;;          ;;                suggested-filename))
;;          ;; (helm-ff-default-directory (project-root project))
;;          (all-files (if include-all
;;                         (mapcan
;;                          (lambda (dir)
;;                            (project--files-in-directory dir vc-dirs-ignores))
;;                          dirs)
;;                       (project-files project dirs))))

;;     (helm :sources (helm-build-sync-source "helm-project-find-file"
;;                      :candidates all-files
;;                      :action  helm-find-files-actions))))


(winner-mode t)
(global-set-key (kbd "C-S-o") 'other-window)
(global-set-key (kbd "C-S-h") 'windmove-left)
(global-set-key (kbd "C-S-j") 'windmove-down)
(global-set-key (kbd "C-S-k") 'windmove-up)
(global-set-key (kbd "C-S-l") 'windmove-right)
(global-set-key (kbd "C-S-n") 'windmove-swap-states-left)
(global-set-key (kbd "C-S-m") 'windmove-swap-states-down)
(global-set-key (kbd "C-S-,") 'windmove-swap-states-up)
(global-set-key (kbd "C-S-.") 'windmove-swap-states-right)
;;(abbrev-mode t)


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


;; (global-set-key (kbd "C-M-m t") tab-prefix-map)

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

(defvar tab-cfg '(("Emacs" . "~/.emacs.d/init.el")
                  ("Mime" . "~/code/mime/mlsub")
                  ("TR" . "~/code/rkt-extra-packages/typed-racket")
                  ("Clang" . "~/code/llvm-project")
                  ("Brain" . "~/my-brain/main.org")))

(defun recreate-main-workspace ()
  "Recreate all my main tabs in a current frame.

This function doesn't check if there are pre-existing tabs with
the same name or for the same purpose "
  (interactive)
  (dolist (c tab-cfg)
    (tab-rename (car c))
    (find-file (expand-file-name (cdr c)))
    (tab-new)))


(defun ap/garbage-collect ()
  "Run `garbage-collect' and print stats about memory usage."
  (interactive)
  (message (cl-loop for (type size used free) in (garbage-collect)
                    for used = (* used size)
                    for free = (* (or free 0) size)
                    for total = (file-size-human-readable (+ used free))
                    for used = (file-size-human-readable used)
                    for free = (file-size-human-readable free)
                    concat (format "%s: %s + %s = %s\n" type used free total))))


(provide 'mod-base)
