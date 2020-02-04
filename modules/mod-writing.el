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
                             (setq fill-column 100)
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
  (org-export-with-toc nil)
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
  (org-document-title ((t (:family "Source Han Sans SC" :height 1.5 :underline nil))))
  :bind (("C-c a" . org-agenda)
         ("C-c g" . counsel-org-goto-all))
  :config
  (require 'ox-publish)
  (setq org-publish-project-alist
        '(("org"
           :base-directory "~/brain/"
           :publishing-directory "~/captainwiki"
           :publishing-function org-html-publish-to-html
           :exclude "talks"
           :section-numbers nil
           :recursive t
           :with-toc nil
           :html-preamble t
           :html-preamble-format (("en"  "<div class='container'><nav role='navigation'><div class='logo'><a class='logo_link' href='/' title='Wiki'>Inside Yet Another Hello World</a></div></nav></div>"))
           :html-postamble nil
           :html-head "<link rel=\"stylesheet\" href=\"/static/css/style.css\" type=\"text/css\"/>"
           :auto-sitemap t                ; Generate sitemap.org automagically...
           :sitemap-filename "index.org"  ; ... call it sitemap.org (it's the default)...
           :sitemap-title "Inside:"        ; ... with title 'Sitemap'.
           :sitemap-sort-files anti-chronologically
           :with-author nil
           )
          ("static"
           :base-directory "~/brain/static/"
           :base-extension any
           :recursive t
           :publishing-directory "~/captainwiki/static"
           :publishing-function org-publish-attachment
           ))))

(use-package org-bullets :ensure t :after org)

;; (use-package org-journal
;;   :ensure t
;;   :init
;;   (require 'org) ;; not the idomatic way to load the org package
;;   :custom
;;   (org-journal-dir "~/brain/journal/")
;;   (org-journal-file-format "%Y%m%d.jnl")
;;   :bind ("C-c C-k" . org-journal-new-entry))


;; Tex

(use-package markdown-mode
  :ensure t
  :ensure-system-package
  (multimarkdown . "brew install multimarkdown")

  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

(use-package tex
  :defer t
  :ensure auctex
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq TeX-save-query nil))

(use-package deft
  :ensure t
  :bind ("<f8>" . deft)
  :custom
  (deft-directory "~/brain/")
  (deft-auto-save-interval 0)
  (deft-extensions '("org" "md" "txt" "tex")))

(provide 'mod-writing)
