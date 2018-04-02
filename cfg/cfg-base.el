(setq ring-bell-function 'ignore)

;; (use-package which-key
;;   :ensure t
;;   :demand t)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(global-set-key (kbd "M-y") 'counsel-yank-pop)

(use-package hydra
  :ensure t
  :demand t)

(use-package ivy
  :ensure t
  :demand t)

(use-package ivy-hydra
  :ensure t
  :demand t)
(use-package counsel
  :ensure t
  :demand t
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  :config
  (ivy-mode)
  (counsel-mode))

(defvar variable-tuple (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
                             ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                             ((x-list-fonts "Verdana")         '(:font "Verdana"))
                             ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                             (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
(defvar base-font-color (face-foreground 'default nil 'default))
(defvar headline `(:inherit default :weight bold :foreground ,base-font-color))

(use-package org
  :ensure t
  :init
  (use-package org-bullets :ensure t)
  (add-hook 'org-mode-hook (lambda ()
                             (org-bullets-mode 1)
                             (visual-line-mode)))
  :custom
  (org-hide-emphasis-markers t)
  :custom-face
  (org-level-8 ((t (headline variable-tuple))))
  (org-level-7 ((t (headline variable-tuple))))
  (org-level-6 ((t (headline variable-tuple))))
  (org-level-5 ((t (headline variable-tuple))))
  (org-level-4 ((t (headline variable-tuple :height 1.1))))
  (org-level-3 ((t (headline variable-tuple :height 1.25))))
  (org-level-2 ((t (headline variable-tuple :height 1.5))))
  (org-level-1 ((t (headline variable-tuple :height 1.75))))
  (org-document-title ((t (headline variable-tuple :height 1.5 :underline nil)))))

(setq tramp-default-method "ssh")

(provide 'cfg-base)
