(put 'upcase-region 'disabled nil)

(delete-selection-mode 1)

(use-package multiple-cursors
  :config
  (define-key mc/keymap (kbd "C-'") nil)
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
  :demand t
  :bind (("C-=" . er/expand-region)))

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1)
  (define-key undo-tree-map (kbd "C-/") nil)
  (define-key undo-tree-map (kbd "C-x u") nil)

  (defhydra hydra-undo-tree (:hint nil)
	"undo!"
	("/" undo-tree-undo "undo")
	("r" undo-tree-redo "redo")
	("u" undo-tree-visualize "visualize"))

  :bind (("C-/" . hydra-undo-tree/body)))

(defun select-line ()
  (interactive)
  (move-beginning-of-line nil)
  (push-mark (point) nil t)
  (next-line 1)
  (move-beginning-of-line 1))

(defun myjoin-line ()
  (interactive)
  (next-line 1)
  (join-line))

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
  ("j" myjoin-line "join line and after")
  ("O" open-line-before "open line before"))

(global-set-key (kbd "C-l") 'hydra-line-rator/body)

(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippet-dirs
		'("~/.emacs.d/yasnippet-snippets/snippets"                 ;; personal snippets
		  "~/.emacs.d/snippets"                 ;; personal snippets
		  ))
  (yas-global-mode t))
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package paredit
  :ensure t
  :init
  (add-hook 'racket-mode-hook #'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
  :config
  (defhydra hydra-paredit ()
	"In Paredit"
    ("l" paredit-forward "f")
	("j" paredit-backward-up "b-up")
	("J" paredit-forward-up "f-up")
	("k" paredit-forward-down "f-down")
	("K" paredit-backward-down "b-down")
	("h" paredit-backward "b")
	("." paredit-forward-slurp-sexp "f-slurp")
	("," paredit-forward-barf-sexp "f-barf")
	("<" paredit-backward-slurp-sexp "b-slurp")
	(">" paredit-backward-barf-sexp "b-barf")
	("s" paredit-splice-sexp "splice")
	("(" paredit-wrap-round "wrap")
	("r" paredit-raise "raise")
	("d" paredit-splice-sexp-killing-backward "splice & b-kill")
	("o" paredit-close-round-and-newline "close & newline"))
  :bind (("M-i" . hydra-paredit/body)))

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

;; remap C-a to `smarter-move-beginning-of-line'"e
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

(provide 'cfg-edit)
