(use-package ace-window
  :ensure t
  :config
  (defhydra hydra-window-rator (:hint nil)
	"manipulate windows"
	("h" windmove-left)
	("l" windmove-right)
	("k" windmove-up)
	("j" windmove-down)
    ("M-n" make-frame-command "new frame" :color blue)
    ("M-q" delete-frame "close current frame" :color blue)
    ("M-p" select-frame-by-name "select frame by name" :color blue)
    ("f" toggle-frame-maximized "toggle full screen" :color blue)
	("v" scroll-other-window "scroll other")
	("V" scroll-other-window-down "scroll other down")
	("o" ace-window "ace" :color blue)
	("d" ace-delete-window "del" :color blue)
	("0" delete-other-windows "del others" :color blue)
	("e" ace-delete-other-windows "keep one" :color blue))
  :bind (("C-M-o" . hydra-window-rator/body)))

(use-package projectile
  :ensure t
  :custom
  (projectile-completion-system 'ivy)
  (projectile-enable-caching t)
  (projectile-use-git-grep t)
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
  :bind (("s-p" . hydra-projectile-rator/body)
         ("C-x b" . projectile-switch-to-buffer)))

(provide 'cfg-workspace)
