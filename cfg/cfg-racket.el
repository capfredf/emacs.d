(use-package racket-mode
  :ensure t
  :mode "\\.rkt"
  :init
  (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
  (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable))

(defun del-iwm ()
  (interactive)
  (if (use-region-p) (delete-selection-helper 'supersede)
	(paredit-forward-delete)))

(use-package paredit
  :ensure t
  :init
  (add-hook 'racket-mode-hook #'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
  :config
  (show-paren-mode t))

(defhydra hydra-paredit ()
  "In Paredit"
  ("." paredit-forward-slurp-sexp "forward slurp")
  ("," paredit-forward-barf-sexp "forward bar")
  ("<" paredit-backward-slurp-sexp "backward slurp")
  (">" paredit-backward-barf-sexp "backward barf")
  ("s" paredit-splice-sexp "splice")
  ("(" paredit-wrap-round "wrap")
  ("o" paredit-close-round-and-newline "close sexp and newline"))

(global-set-key (kbd "C-'") 'hydra-paredit/body)
  ;; :config
  ;; (put 'paredit-forward-delete 'delete-selection 'supersede)
  ;; :bind ("DEL" . del-iwm))


(setq racket-racket-program "/usr/local/bin/racket")
(setq racket-raco-program "/usr/local/bin/raco")

(provide 'cfg-racket)
