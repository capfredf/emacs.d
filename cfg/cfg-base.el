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
  :ensure t)

(use-package ivy
  :ensure t)

(use-package ivy-hydra
  :ensure t)
(use-package counsel
  :ensure t
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
  :mode ("\\.org" . org-mode)
  :init
  (use-package org-bullets :ensure t)
  (add-hook 'org-mode-hook (lambda ()
                             (org-bullets-mode 1)
                             ;; (face-remap-add-relative 'default :family "Source Sans Pro" :height 140)
                             (visual-line-mode)))
  :custom
  (org-hide-emphasis-markers t)
  (org-fontify-done-headline t)
  (org-src-fontify-natively t)
  :custom-face
  ;; (org-quote ((t (:height 2.0))))
  (org-done ((t (:foreground "dim gray" :strike-through t))))
  (org-headline-done ((t (:foreground "dim gray" :strike-through t))))
  (org-level-8 ((t (:family "Source Sans Pro"))))
  (org-level-7 ((t (:family "Source Sans Pro"))))
  (org-level-6 ((t (:family "Source Sans Pro"))))
  (org-level-5 ((t (:family "Source Sans Pro"))))
  (org-level-4 ((t (:family "Source Sans Pro" :height 1.1))))
  (org-level-3 ((t (:family "Source Sans Pro" :height 1.25))))
  (org-level-2 ((t (:family "Source Sans Pro" :height 1.5))))
  (org-level-1 ((t (:family "Source Sans Pro" :height 1.75))))
  (org-document-title ((t (:family "Source Sans Pro" :height 1.5 :underline nil)))))

(use-package org-journal
  :ensure t
  :defer t
  :custom
  (org-journal-dir "~/captainwiki/journal/"))

(setq tramp-default-method "ssh")

(provide 'cfg-base)
