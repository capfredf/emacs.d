(defun jump-to-file-and-line ()
  (interactive)
  (let ((line (buffer-substring-no-properties (point-at-bol) (point-at-eol))))
    (let ((tuple (string-match "\\([a-zA-Z/._]+\\):\\([0-9]+\\)" line)))
      (let ((file (match-string 1 line))
            (lnum (match-string 2 line))
            (dir (projectile-project-root)))
        (when (and file (file-exists-p (concat dir file)))
          (find-file-other-window (concat dir file))
          (and lnum (goto-line (string-to-number lnum))))))))

(global-set-key (kbd "s-]") 'jump-to-file-and-line)

(global-set-key (kbd "C-s-h")  'windmove-left)
(global-set-key (kbd "C-s-l")  'windmove-right)
(global-set-key (kbd "C-s-k")  'windmove-up)
(global-set-key (kbd "C-s-j")  'windmove-down)

(use-package helm
  :ensure t
  :config (setq helm-mode-fuzzy-match 1)
  :bind (("M-x" . helm-M-x)
	 ("C-x b" . helm-buffers-list)
	 ("C-x r" . helm-recentf)
	 ("C-x C-f" . helm-find-files)
	 ("M-y" . helm-show-kill-ring)))

(use-package projectile
  :ensure t)

(use-package helm-projectile
  :ensure t
  :bind (("s-p p" . helm-projectile-find-file)
	 ("s-p s" . helm-projectile-switch-project))
  :config ((helm-projectile-on)))

(defun back-to-cfg ()
  (interactive)
  (find-file user-emacs-directory))

(global-set-key (kbd "C-c C-i")  'back-to-cfg)

(provide 'cfg-nav)
