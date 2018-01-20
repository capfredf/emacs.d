(use-package ace-window
  :ensure t
  :config
  (defhydra hydra-window-rator (:hint nil)
	"manipulate windows"
	("h" windmove-left)
	("l" windmove-right)
	("k" windmove-up)
	("j" windmove-down)
	("v" scroll-other-window "scroll other")
	("V" scroll-other-window-down "scroll other down")
	("o" ace-window "ace" :color blue)
	("1" ace-delete-window "del" :color blue)
	("0" delete-other-windows "del others" :color blue)
	("e" ace-delete-other-windows "keep one" :color blue))
  :bind (("C-M-o" . hydra-window-rator/body)))

(use-package projectile
  :ensure t
  :init
  (setq projectile-completion-system 'ivy)
  (setq projectile-enable-caching t)
  :config
  (projectile-mode)

  (defun back-to-cfg ()
    (interactive)
    (projectile-switch-project-by-name "~/.emacs.d/"))

  (defhydra hydra-projectile-rator (:hint nil :color blue)
	"projectile:"
	("f" projectile-find-file "find file")
	("g" projectile-grep "grep")
    ("c" projectile-invalidate-cache "invalidate cache")
    ("h" back-to-cfg "back to cfg")
	("s" projectile-switch-project "switch-project"))
  :bind (("s-p" . hydra-projectile-rator/body)))

(provide 'cfg-workspace)
