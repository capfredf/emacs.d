(use-package diff-hl :ensure t)
(use-package magit
  :ensure t
  :bind (("s-m m" . magit-status))
  :config (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(provide 'cfg-vcs)
