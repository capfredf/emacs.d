(put 'upcase-region 'disabled nil)

(delete-selection-mode 1)

(use-package multiple-cursors
  ;; :config
  ;; (define-key mc/keymap (kbd "C-'") 'mc-hide-unmatched-lines-mode)
  :ensure t
  :bind (("C-M-e" . mc/edit-lines)
         ("C-." . mc/mark-next-like-this)
         ("C-," . mc/mark-previous-like-this)
         ("C->" . mc/skip-to-next-like-this)
         ("C-<" . mc/skip-to-previous-like-this)))

(use-package expand-region
  :ensure t
  :bind (("C-=" . er/expand-region)))

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

(global-set-key (kbd "C-l") nil)
(global-set-key (kbd "C-l j") 'myjoin-line)
(global-set-key (kbd "C-l l") 'beacon-blink)
(global-set-key (kbd "C-l s") 'select-line)
(global-set-key (kbd "C-l o") 'open-line-after)
(global-set-key (kbd "C-l O") 'open-line-before)

(global-set-key (kbd "M-k") nil)
(global-set-key (kbd "M-k k") 'kill-whole-line)

(use-package yasnippet
  :ensure t
  :hook ((prog-mode . yas-minor-mode)
         (org-mode . yas-minor-mode)
         (tex-mode . yas-minor-mode))
  :config
  (setq yas-snippet-dirs
		'("~/.emacs.d/yasnippet-snippets/snippets"                 ;; personal snippets
		  "~/.emacs.d/snippets"                 ;; personal snippets
		  ))
  (yas-reload-all))
;;(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package paredit
  :ensure t
  :init
  (add-hook 'racket-mode-hook #'enable-paredit-mode)
  (add-hook 'racket-repl-mode-hook #'enable-paredit-mode)
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
  (unbind-key "M-s" paredit-mode-map)
  :bind (:map paredit-mode-map
         ("s-l" . paredit-forward)
         ("s-h" . paredit-backward)
         ("s-r" . paredit-raise-sexp)
         ("s-s" . paredit-splice-sexp-killing-backward)
         ("s-j" . paredit-backward-down)
         ("s-J" . paredit-backward-up)
         ("s-k" . paredit-forward-down)
         ("s-K" . paredit-forward-up)
         ("s-." . paredit-forward-slurp-sexp)
         ("s->" . paredit-forward-barf-sexp)
         ("s-," . paredit-backward-slurp-sexp)
         ("s-<" . paredit-backward-barf-sexp)
         ("s-S" . paredit-splice-sexp)
         ("s-(" . paredit-wrap-round)
         ("s-o" . paredit-close-round-and-newline)))


(use-package swiper
  :ensure t
  :bind
  (("C-s" . swiper)))

(use-package scribble
  :load-path "site-lisp/scribble-emacs")

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

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

(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.33)))

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

(defun with-face (str &rest face-plist)
  (propertize str 'face face-plist))

(defun shk-eshell-prompt ()
  (let ((header-bg "#fafafa"))
    (concat
     (with-face "\n" :background header-bg)
     (with-face (concat (eshell/pwd) " ") :background header-bg)
     (with-face
      (or (ignore-errors (format "(%s)" (vc-responsible-backend default-directory))) "")
      :background header-bg)
     (with-face "\n" :background header-bg)
     (with-face user-login-name :foreground "#64a6ae")
     "@"
     (with-face (system-name) :foreground "#889a2e")
     (if (= (user-uid) 0)
         (with-face " #" :foreground "red")
       " $")
     " ")))
(setq eshell-prompt-function 'shk-eshell-prompt)
(setq eshell-highlight-prompt nil)

(setq org-reveal-root "file:///Users/capfredf/Downloads/reveal.js-3.8.0/")
(setq org-reveal-history t)
(provide 'mod-edit)
