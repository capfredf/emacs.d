(use-package ace-window
  :ensure t
  :custom
  (aw-dispatch-always t) ;; this is the default value
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind (("M-o" . ace-window)))

(require 'subr-x)
(use-package projectile
  :ensure t
  :custom
  (projectile-completion-system 'ivy)
  (projectile-enable-caching t)
  (projectile-use-git-grep t)
  (projectile-git-submodule-command "")
  (projectile-indexing-method 'alien)
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

(winner-mode t)


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


(global-set-key (kbd "s-m e") tab-prefix-map)
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


(provide 'mod-workspace)
;; (defun print-elements-of-list (list)
;;        "Print each element of LIST on a line of its own."
;;        (while list
;;          (print (car list))
;;          (setq list (cdr list))))
;; (print-elements-of-list (projectile-ignored-directories))
