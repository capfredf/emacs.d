(use-package ace-window
  :ensure t
  :config
  (defhydra hydra-window-rator (:hint nil :idle 2)
	"manipulate windows"
	("h" windmove-left "left" :column "movement")
	("l" windmove-right "right" :column "movement")
	("k" windmove-up "up" :column "movement")
	("j" windmove-down "down" :column "movement")
    ("M-n" make-frame-command "new frame" :color blue :column "frame")
    ("M-q" delete-frame "close current frame" :color blue :column "frame")
    ("M-p" select-frame-by-name "select frame by name" :color blue :column "frame")
    ("f" toggle-frame-maximized "toggle full screen" :color blue :column "frame")
	("v" scroll-other-window "scroll up other window" :column "misc")
	("V" scroll-other-window-down "scroll other window down" :column "misc")
	("o" ace-window "switch to window?" :color blue :column "movement" :column "movement")
	("d" ace-delete-window "del window?" :color blue :column "deletion")
	("0" delete-other-windows "del others" :color blue :column "deletion")
	("e" ace-delete-other-windows "keep one" :color blue :column "deletion"))
  :bind (("C-M-o" . hydra-window-rator/body)))

(use-package projectile
  :ensure t
  :custom
  (projectile-completion-system 'ivy)
  (projectile-enable-caching t)
  (projectile-use-git-grep t)
  (projectile-git-submodule-command "")
  (projectile-indexing-method 'alien)
  :config
  (projectile-mode)
  (defun back-to-cfg ()
    (interactive)
    (projectile-switch-project-by-name "~/.emacs.d/"))

  (defhydra hydra-projectile-rator (:color blue :idle 2)
	"projectile"
	("f" projectile-find-file "find file" :column "project")
	("g" projectile-grep "grep" :column "project")
    ("c" projectile-invalidate-cache "invalidate cache" :color red :column "meta")
    ("h" back-to-cfg "back to cfg" :column "shortcut")
	("s" projectile-switch-project "switch-project" :column "shortcut"))

  :bind (("C-M-p" . hydra-projectile-rator/body)
         ;;("C-x b" . projectile-switch-to-buffer)
         ))

(use-package diff-hl :ensure t)
(use-package magit
  :ensure t
  :bind (("s-m m" . magit-status))
  :config (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))


(provide 'mod-workspace)
;; (defun print-elements-of-list (list)
;;        "Print each element of LIST on a line of its own."
;;        (while list
;;          (print (car list))
;;          (setq list (cdr list))))
;; (print-elements-of-list (projectile-ignored-directories))
