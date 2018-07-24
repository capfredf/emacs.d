(require 'bind-key)
(use-package racket-mode
  :ensure t
  :mode "\\.rkt"
  :init
  (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
  (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)
  (add-to-list 'auto-mode-alist '("\\.pie$" . racket-mode))
  :config
  (setq racket-racket-program "/Applications/Racket_v6.90.0.901/bin/racket")
  (setq racket-raco-program "/Applications/Racket_v6.90.0.901/bin/raco"))

(provide 'cfg-racket)
