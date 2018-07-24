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
  :bind (("C-M-d" . hydra-multi-cursors/body)))


(use-package iy-go-to-char
  :ensure t
  :config
  (defhydra hydra-iy-go-to-char (:hint nil :idle 5)
	"go to char in line"
	("f" iy-go-to-char "to some char foward")
	("F" iy-go-to-char-backward "to some char backward")
	(";" iy-go-to-or-up-to-continue "repeat foward")
	("," iy-go-to-or-up-to-continue-backward "repeat backward"))
  :bind (("C-M-f" . hydra-iy-go-to-char/body)))

(use-package expand-region
  :ensure t
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
  :hook ((prog-mode . yas-minor-mode)
         (org-mode . yas-minor-mode))
  :config
  (setq yas-snippet-dirs
		'("~/.emacs.d/yasnippet-snippets/snippets"                 ;; personal snippets
		  "~/.emacs.d/snippets"                 ;; personal snippets
		  ))
  (yas-reload-all))
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package paredit
  :ensure t
  :init
  (add-hook 'racket-mode-hook #'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
  :config
  (unbind-key "C-M-f" paredit-mode-map)
  (unbind-key "C-(" paredit-mode-map)
  (unbind-key "C-)" paredit-mode-map)
  (unbind-key "C-{" paredit-mode-map)
  (unbind-key "C-}" paredit-mode-map)
  (unbind-key "C-M-b" paredit-mode-map)
  (unbind-key "C-M-d" paredit-mode-map)
  (unbind-key "C-M-n" paredit-mode-map)
  (unbind-key "C-M-p" paredit-mode-map)
  :bind (:map paredit-mode-map
         ("s-l" . paredit-forward)
         ("s-h" . paredit-backward)
         ("s-r" . paredit-raise-sexp)
         ("s-s" . paredit-splice-sexp-killing-backward)
         ("s-j" . paredit-backward-up)
         ("s-J" . paredit-forward-up)
         ("s-k" . paredit-forward-down)
         ("s-K" . paredit-backward-down)
         ("s-." . paredit-forward-slurp-sexp)
         ("s-," . paredit-forward-barf-sexp)
         ("s-<" . paredit-backward-slurp-sexp)
         ("s->" . paredit-backward-barf-sexp)
         ("s-S" . paredit-splice-sexp)
         ("s-(" . paredit-wrap-round)
         ("s-o" . paredit-close-round-and-newline)))


(use-package swiper
  :ensure t
  :bind
  (("C-s" . swiper)))

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

(global-set-key (kbd "C-M-]") 'jump-to-file-and-line)

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
