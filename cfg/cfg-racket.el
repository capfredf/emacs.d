(require 'bind-key)
(use-package racket-mode
  :ensure t
  :mode "\\.rkt"
  :init
  (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
  (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable))



(setq racket-racket-program "/usr/local/bin/racket")
(setq racket-raco-program "/usr/local/bin/raco")
(provide 'cfg-racket)
