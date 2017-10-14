(use-package multiple-cursors
  :config
  (defhydra hydra-multi-cursors (:hint nil)
  "multiple cursors"
	("e" mc/edit-lines "split selected lines into cursors")
	("d" mc/mark-next-like-this "mark next")
	("s" mc/skip-to-next-like-this "skip next")
	("p" mc/mark-previous-like-this "mark previous")
	("<" mc/mark-all-like-this "mark all"))
  :ensure t
  :bind (("s-d" . hydra-multi-cursors/body)))


(use-package iy-go-to-char
  :ensure t
  :config
  (defhydra hydra-iy-go-to-char (:hint nil :idle 5)
	"go to char in line"
	("f" iy-go-to-char "to some char foward")
	("F" iy-go-to-char-backward "to some char backward")
	(";" iy-go-to-or-up-to-continue "repeat foward")
	("," iy-go-to-or-up-to-continue-backward "repeat backward"))
  :bind (("s-f" . hydra-iy-go-to-char/body)))

(use-package expand-region
  :ensure t
  :demand t)

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1)
  (define-key undo-tree-map (kbd "C-/") nil)

  (defhydra hydra-undo-tree (:hint nil)
	"undo!"
	("/" undo-tree-undo "undo")
	("r" undo-tree-redo "redo")
	("u" undo-tree-visualize "visualize"))

  :bind (("C-" . hydra-undo-tree/body)))

(defun select-line ()
  (interactive)
  (move-beginning-of-line nil)
  (push-mark (point) nil t)
  (next-line 1)
  (move-beginning-of-line 1))

;; (defun myjoin-line ()
;;   (interactive)
;;   (next-line 1)
;;   (join-line))

(defun open-line-before()
  (interactive)
  (previous-line)
  (open-line-after))

(defun open-line-after()
  (interactive)
  (move-end-of-line nil)
  (newline)
  (indent-for-tab-command))

(defhydra hydra-line-rator (:hint nil)
  "To manipulate the line"
  ("o" open-line-after "open line after")
  ("s" select-line "select current line")
  ("O" open-line-before "open line before"))

(global-set-key (kbd "C-l") 'hydra-line-rator/body)


(delete-selection-mode 1)

;; (global-set-key (kbd "j")myjoin-line)
(global-set-key (kbd "M-y") 'counsel-yank-pop)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippet-dirs
		'("~/.emacs.d/yasnippet-snippets/snippets"                 ;; personal snippets
		  "~/.emacs.d/snippets"                 ;; personal snippets
		  ))
  (yas-global-mode t))
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(provide 'cfg-text-operation)
