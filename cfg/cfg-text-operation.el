(use-package multiple-cursors
  :ensure t
  :bind (("s-e" . mc/edit-lines)
	 ("s-d" . mc/mark-next-like-this)
	 ("s-n" . mc/skip-to-next-like-this)
	 ("s-S-d" . mc/mark-previous-like-this)
	 ("C-c C-<" . mc/mark-all-like-this)))

(use-package iy-go-to-char
  :ensure t
  :bind (("s-f" . iy-go-to-char)
	 ("s-F" . iy-go-to-char-backward)
	 ("s-;" . iy-go-to-or-up-to-continue)
	 ("s-," . iy-go-to-or-up-to-continue-backward)))

(use-package expand-region
  :ensure t
  :bind (("C-=" . er/expand-region)))


(defun select-line ()
  (interactive)
  (move-beginning-of-line nil)
  (push-mark (point) nil t)
  (next-line 1))

(defun myjoin-line ()
  (interactive)
  (next-line 1)
  (join-line))

(global-set-key (kbd "C-l") 'select-line)
(global-set-key (kbd "s-j") 'myjoin-line)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)


(provide 'cfg-text-operation)
