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

;; (use-package helm-ls-git
;;   :ensure t)

(use-package projectile
  :ensure t
  :config (projectile-mode))

(use-package helm-projectile
  :ensure t
  :bind (("s-p s" . helm-projectile-switch-project)
	 ("s-p p" . helm-projectile-find-file))
  :config (helm-projectile-on))

(defun back-to-cfg ()
  (interactive)
  (find-file user-emacs-directory))

(global-set-key (kbd "s-o i")  'back-to-cfg)


(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)


(provide 'cfg-nav)
