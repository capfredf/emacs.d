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
	("o" ace-window "ace")
	("1" ace-delete-window "del")
	("0" delete-other-windows "del others")
	("e" ace-delete-other-windows "keep one"))
  :bind (("C-M-o" . hydra-window-rator/body)))


(use-package projectile
  :ensure t
  :init
  (setq projectile-completion-system 'ivy)
  (setq projectile-enable-caching t)
  :config
  (projectile-mode)
  (defhydra hydra-projectile-rator (:hint nil)
	"projectile:"
	("f" projectile-find-file "find file")
	("g" projectile-grep "grep")
	("s" projectile-switch-project "switch-project"))
  :bind (("s-p" . hydra-projectile-rator/body)))

(use-package ivy
  :ensure t
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  :config (ivy-mode)
  :demand t
  :bind (("C-c C-r" . ivy-resume)))

(use-package counsel
  :ensure t
  :bind (("s-o i" . back-to-cfg)))

(defun back-to-cfg ()
  (interactive)
  (counsel-find-file "~/.emacs.d/cfg"))

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

(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(setq tramp-default-method "ssh")

(require 'ivy)
(require 'counsel)

(provide 'cfg-nav)
