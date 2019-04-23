(defvar variable-tuple (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
                             ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                             ((x-list-fonts "Verdana")         '(:font "Verdana"))
                             ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                             (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
(defvar base-font-color (face-foreground 'default nil 'default))
(defvar headline `(:inherit default :weight bold :foreground ,base-font-color))


(use-package visual-fill-column
  :ensure t
  :hook (visual-line-mode . visual-fill-column-mode))

(use-package org
  :ensure t
  :mode ("\\.org" . org-mode)
  :init
  (add-hook 'org-mode-hook (lambda ()
                             (org-bullets-mode 1)
                             (org-indent-mode t)
                             ;; (variable-pitch-mode t)
                             ;; (face-remap-add-relative 'default :family "Source Sans Pro" :height 140)
                             (visual-line-mode)
                             ))
  :custom
  (org-hide-emphasis-markers t)
  (org-fontify-done-headline t)
  (org-src-fontify-natively t)
  (org-image-actual-width 500)
  (org-agenda-files (list "~/captainwiki/plan"))
  (org-refile-targets '((nil :maxlevel . 3)
                        (org-agenda-files :maxlevel . 3)))
  (org-refile-use-outline-path 'file) ;; use file path as refile targets
  (org-outline-path-complete-in-steps nil) ;; show all headlines in a file when refiling a substree

  :custom-face
  ;; (org-quote ((t (:height 2.0))))
  (org-done ((t (:foreground "dim gray" :strike-through t))))
  (org-block ((t (:inherit fixed-pitch))))
  (org-headline-done ((t (:foreground "dim gray" :strike-through t))))
  ;; (org-level-8 ((t (:family "Source Han Sans SC"))))
  ;; (org-level-7 ((t (:family "Source Han Sans SC"))))
  ;; (org-level-6 ((t (:family "Source Han Sans SC"))))
  ;; (org-level-5 ((t (:family "Source Han Sans SC"))))
  ;; (org-level-4 ((t (:family "Source Han Sans SC" :height 1.1))))
  ;; (org-level-3 ((t (:family "Source Han Sans SC" :height 1.25))))
  ;; (org-level-2 ((t (:family "Source Han Sans SC" :height 1.5))))
  ;; (org-level-1 ((t (:family "Source Han Sans SC" :height 1.75))))
  (org-document-title ((t (:family "Source Han Sans SC" :height 1.5 :underline nil)))))

(use-package org-bullets :ensure t :after org)


(use-package org-journal
  :ensure t
  :init
  (require 'org) ;; not the idomatic way to load the org package
  :custom
  (org-journal-dir "~/captainwiki/journal/")
  (org-journal-file-format "%Y%m%d.jnl")
  :bind ("C-c C-k" . org-journal-new-entry))


;; Tex
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)

(use-package markdown-mode
  :ensure t
  :ensure-system-package
  (multimarkdown . "brew install multimarkdown")

  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

(provide 'mod-writing)
