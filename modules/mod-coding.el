(setq-default c-basic-offset 4
			  tab-width 4
			  indent-tabs-mode nil)

(use-package agda2-mode
  :mode "\\.agda"
  :load-path "/usr/local/share/emacs/site-lisp/agda"
  :custom-face
   (agda2-highlight-datatype-face ((t (:foreground "dodger blue"))))
   (agda2-highlight-function-face ((t (:foreground "dodger blue"))))
   (agda2-highlight-postulate-face ((t (:foreground "dodger blue"))))
   (agda2-highlight-primitive-face ((t (:foreground "dodger blue"))))
   (agda2-highlight-primitive-type-face ((t (:foreground "dodger blue")))))

(use-package haskell-mode
  :ensure t
  :mode "\\.hs")

(use-package proof-general
  :mode ("\\.v" . coq-mode)
  :load-path "$HOME/.emacs.d/PG/generic/proof-site")


(require 'bind-key)
(use-package racket-mode
  :ensure t
  :no-require t
  :mode "\\.rkt"
  ;;:load-path "/Users/capfredf/code/racket-mode"
  :init
  (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
  (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)
  (add-to-list 'auto-mode-alist '("\\.pie$" . racket-mode))
  :config
  (setq racket-racket-program "/Applications/Racket_v7.0/bin/racket")
  (setq racket-raco-program "/Applications/Racket_v7.0/bin/raco")
  (racket-unicode-input-method-enable)
  (with-temp-buffer
    (set-input-method "racket-unicode")
    (let ((quail-current-package (assoc "racket-unicode" quail-package-alist)))
      (quail-define-rules ((append . t))
                          ("vdash" ["⊢"])
                          ("^o" ["ᵒ"])))))

;; (load "/Users/phay/.opam/system/share/emacs/site-lisp/tuareg-site-file")

(use-package rust-mode
  :ensure t)

(provide 'mod-coding)
