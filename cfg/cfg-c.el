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

(provide 'cfg-c)
