(use-package racket-mode
  :ensure t
  :mode "\\.rkt"
  :init
  (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
  (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable))

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
  :bind (("C-'" . hydra-paredit/body)))


(setq racket-racket-program "/usr/local/bin/racket")
(setq racket-raco-program "/usr/local/bin/raco")

(provide 'cfg-racket)
