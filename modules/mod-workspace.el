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

(use-package eyebrowse
  :ensure t
  :custom
  (eyebrowse-keymap-prefix (kbd "s-m e"))
  :config
  (which-key-add-key-based-replacements "s-m e" "eyebrowse")
  (eyebrowse-mode t))

(provide 'mod-workspace)
;; (defun print-elements-of-list (list)
;;        "Print each element of LIST on a line of its own."
;;        (while list
;;          (print (car list))
;;          (setq list (cdr list))))
;; (print-elements-of-list (projectile-ignored-directories))
