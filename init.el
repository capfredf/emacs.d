(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             t)
;; (add-to-list 'package-archives
;;              '("org" . "https://orgmode.org/elpa/"))
;; (add-to-list 'package-archives
;;              '("devel" . "https://elpa.gnu.org/devel/"))

;; (add-to-list 'package-archives
;;              '("gnu-devel" . "https://orgmode.org/elpa/"))
(package-initialize)
;; (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
;; (require 'racket-mode)

;; (add-to-list 'load-path (expand-file-name "lib/borg" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))
;; it looks the path to the two libraries below have to be added separately in
;; order to make epkg and/or borg work properly
;;(add-to-list 'load-path (expand-file-name "lib/compat" user-emacs-directory))
;; (add-to-list 'load-path (expand-file-name "lib/llama" user-emacs-directory))
;; (require 'borg)
;; (borg-initialize)


(with-eval-after-load 'magit
  (magit-add-section-hook 'magit-status-sections-hook
					                'magit-insert-modules
					                'magit-insert-stashes
					                'append))


(eval-and-compile
 (require 'use-package))
(require 'bind-key)


(require 'mod-base)
(require 'mod-visual)
(require 'mod-edit)
;;

(put 'downcase-region 'disabled nil)

(setq custom-file (concat user-emacs-directory "setting.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(setq make-backup-files nil)
(define-coding-system-alias 'UTF-8 'utf-8)
(define-coding-system-alias 'utf8 'utf-8)
(set-language-environment 'utf-8)

(defalias 'yes-or-no-p 'y-or-n-p)

(require 'treesit)
(setq treesit-extra-load-path
      '("/home/capfredf/code/tree-sitter-module/dist"))


(use-package use-package-ensure-system-package)
(use-package dired
  :hook (dired-mode . dired-hide-details-mode))

(use-package bind-key
  :ensure t
  :demand t)

;; (use-package helm
;;   :ensure t
;;   :init
;;   (setq helm--tramp-archive-maybe-loaded t) ;; dirty fix, because dbus-ping can't reach Avahi
;;   :bind
;;   ("M-x" . helm-M-x)
;;   ("C-x C-f" . helm-find-files)
;;   ("C-x b" . helm-mini)
;;   ("M-y" . helm-show-kill-ring)
;;   :config
;;   (helm-mode 1))


(use-package which-key
  :ensure t
  :config
  (add-to-list 'which-key-show-transient-maps text-scaling-map)
  (setq which-key-show-early-on-C-h t)
  (setq which-key-idle-delay 10000)
  (setq which-key-idle-secondary-delay 0.05)
  (which-key-mode))

(global-set-key (kbd "<f3>") 'scale-text)

;; (defun helm-project-ag-find ()
;;   (interactive)
;;   ;; (require 'project)
;;   ;; (require 'helm)
;;   (let* ((pr (project-current))
;;          (dir (project-root pr)))
;;     (helm-grep-ag (expand-file-name dir) nil)))

;; (defun helm-rifle-project ()
;;   (interactive)
;;   ;; (require 'project)
;;   ;; (require 'helm)
;;   (let* ((pr (project-current))
;;          (dir (project-root pr)))
;;     (helm-org-rifle-directories (expand-file-name dir) t)))

(defun up-directory (arg)
  "Move up a directory (delete backwards to /)."
  (interactive "p")
  (if (string-match-p "/." (minibuffer-contents))
      (zap-up-to-char (- arg) ?/)
    (delete-minibuffer-contents)))


(use-package vertico
  :ensure t
  :bind (:map vertico-map
              ("C-l" . up-directory))
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :ensure t
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :ensure t
  :defer t)

(use-package project
  ;; :after (helm helm-org-rifle)
  :bind
  ;; ("C-c s p" . helm-project-ag-find)
  ;; ("C-c s r" . helm-rifle-project)
  (:map project-prefix-map
        ("f" . project-find-file)
        ("g" . consult-ripgrep)
        ))

(use-package diff-hl
  :ensure t
  :demand t)

(use-package magit
  :ensure t
  :after (diff-hl)
  :bind (("C-x m" . magit-status))
  :config (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

;; (define-key icomplete-minibuffer-map (kbd "<s-tab>") 'icomplete-force-complete)

(use-package yasnippet
  :ensure t
  :hook ((prog-mode text-mode) . yas-minor-mode)
  :config (yas-reload-all))

(setq-default abbrev-mode t)

(use-package helm-org-rifle
  :ensure t)

(use-package solarized-theme
  :ensure t
  :config
  (switch-theme 'solarized-light)
  ;; make the fringe stand out from the background
  (setq solarized-distinct-fringe-background t)

  ;; Don't change the font for some headings and titles
  (setq solarized-use-variable-pitch nil)

  ;; make the modeline high contrast
  (setq solarized-high-contrast-mode-line t)

  ;; Use less bolding
  (setq solarized-use-less-bold t)

  ;; Use more italics
  (setq solarized-use-more-italic t)

  ;; Use less colors for indicators such as git:gutter, flycheck and similar
  (setq solarized-emphasize-indicators nil)

  ;; Don't change size of org-mode headlines (but keep other size-changes)
  (setq solarized-scale-org-headlines nil)

  ;; Avoid all font-size changes
  (setq solarized-height-minus-1 1.0)
  (setq solarized-height-plus-1 1.0)
  (setq solarized-height-plus-2 1.0)
  (setq solarized-height-plus-3 1.0)
  (setq solarized-height-plus-4 1.0))


(use-package highlight-parentheses
  :ensure t
  :init
  (add-hook 'racket-mode-hook (lambda () (highlight-parentheses-mode t)))
  (add-hook 'emacs-lisp-mode-hook (lambda () (highlight-parentheses-mode t))))



(use-package s
  :ensure t)
(use-package dash
  :ensure t)
(use-package wgrep
  :ensure t
  :after grep)

(use-package wgrep-ag
  :ensure t
  :defer t)


;; (use-package scribble
;;   :ensure t
;;   :mode "\\.scribl")

(use-package ag
  :ensure t
  :defer t
  :config
  (autoload 'wgrep-ag-setup "wgrep-ag")
  (add-hook 'ag-mode-hook 'wgrep-ag-setup))


(use-package flymake
  :ensure t
  :bind (:map flymake-mode-map
							("M-n" . 'flymake-goto-next-error)
							("M-p" . 'flymake-goto-prev-error)))


(use-package multiple-cursors
  :ensure t
  :defer t
  ;; :config
  ;; (define-key mc/keymap (kbd "C-'") 'mc-hide-unmatched-lines-mode)
  :bind (("C-M-e" . mc/edit-lines)
         ("C-." . mc/mark-next-like-this)
         ("C-," . mc/mark-previous-like-this)
         ("C->" . mc/skip-to-next-like-this)
         ("C-<" . mc/skip-to-previous-like-this)))

(use-package expand-region
  :ensure t
  :bind (("C-=" . er/expand-region)))


(use-package ws-butler
  :ensure t
  :hook (prog-mode . ws-butler-mode))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

(use-package embark
  :ensure t

  :bind
  (("C-;" . embark-act)         ;; pick some comfortable binding
   ("C-:" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc.  You may adjust the Eldoc
  ;; strategy, if you want to see the documentation from multiple providers.
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package paredit
  :ensure t
  :init
  (add-hook 'racket-mode-hook 'enable-paredit-mode)
  (add-hook 'racket-repl-mode-hook 'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  :config
  (unbind-key "C-M-f" paredit-mode-map)
  (unbind-key "C-M-s" paredit-mode-map)
  (unbind-key "C-(" paredit-mode-map)
  (unbind-key "C-)" paredit-mode-map)
  (unbind-key "C-{" paredit-mode-map)
  (unbind-key "C-}" paredit-mode-map)
  (unbind-key "C-M-b" paredit-mode-map)
  (unbind-key "C-M-d" paredit-mode-map)
  (unbind-key "C-M-n" paredit-mode-map)
  (unbind-key "C-M-p" paredit-mode-map)
  (unbind-key "M-s" paredit-mode-map)

  (defun swap-parens-brackets ()
    (interactive)
    (cond
     ((eq ?\[ (char-after))
      (paredit-open-parenthesis))
     ((eq ?\( (char-after))
      (paredit-open-bracket))
     (t (error "swap-parens-brackets: not an open bracket or parent")))
    (paredit-forward-slurp-sexp)
    (forward-char)
    (paredit-splice-sexp-killing-backward)
    (forward-char -1))

  :bind (:map paredit-mode-map
         ("C-M-l" . paredit-forward)
         ("C-M-h" . paredit-backward)
         ("C-M-r" . paredit-raise-sexp)
         ("C-M-s" . paredit-splice-sexp-killing-backward)
         ("C-M-j" . paredit-backward-down)
         ("C-M-S-j" . paredit-backward-up)
         ("C-M-k" . paredit-forward-down)
         ("C-M-S-k" . paredit-forward-up)
         ("C-M-." . paredit-forward-slurp-sexp)
         ("C-M->" . paredit-forward-barf-sexp)
         ("C-M-," . paredit-backward-slurp-sexp)
         ("C-M-<" . paredit-backward-barf-sexp)
         ("C-M-S-s" . paredit-splice-sexp)
         ("C-M-(" . paredit-wrap-round)
         ("C-M-o" . paredit-close-round-and-newline)))

(use-package olivetti
  :ensure t
  :hook (org-mode . olivetti-mode))


(use-package org
  :mode ("\\.org" . org-mode)
  :init
  (add-hook 'org-mode-hook (lambda ()
                             ;; (org-bullets-mode 1)
                             (variable-pitch-mode 1)
                             (setq fill-column 100)))
  :custom
  (org-latex-create-formula-image-program 'dvisvgm)
  (org-fontify-done-headline t)
  (org-src-fontify-natively t)
  (org-image-actual-width 500)
  (org-outline-path-complete-in-steps nil) ;; show all headlines in a file when refiling a substree
  (org-export-with-toc nil)
  (org-agenda-files (directory-files-recursively "~/my-brain/" "main\\.org$"))
  (org-agenda-custom-commands
   '(("z" "Daily Agenda View"
      ((agenda "" ((org-agenda-span 'day)
                   (org-super-agenda-groups
                    '((:log t)          ; Automatically named "Log"
                      (:name "Today"
                             :scheduled today)))))
       (todo "NEXT" ((org-agenda-overriding-header "Available")
                     (org-agenda-todo-ignore-scheduled t)
                     (org-super-agenda-groups
                      '((:log t)        ; Automatically named "Log"
                        (:name "Important"
                               ;; :not (:scheduled today)
                               :priority "A")))))))))
  :custom-face
  ;; (org-quote ((t (:height 2.0))))
  (org-done ((t (:foreground "dim gray" :strike-through t))))
  (org-block ((t (:inherit fixed-pitch))))
  (org-headline-done ((t (:foreground "dim gray" :strike-through t))))
  (org-document-title ((t (:height 1.5 :underline nil))))
  :bind (("C-c a" . org-agenda)
         ("<f9>" . org-capture)
         ;;("C-c g" . counsel-org-goto-all)
         :map org-mode-map
         ("C-c l" . org-store-link)
         ("C-c C-M-o" . org-mark-ring-goto)
         ("s-n" . org-next-visible-heading)
         ("s-p" . org-previous-visible-heading)
         ("s-u" . outline-up-heading)
         ("s-l" . org-forward-heading-same-level)
         ("s-h" . org-backward-heading-same-level))
  :config
  (require 'ox-publish)
  (setq org-latex-listings 'minted
        org-latex-packages-alist '(("" "minted")
                                   ("" "mathtools")
                                   ("" "amssymb")
                                   ("" "bbm"))
        org-latex-pdf-process
        '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
  (org-link-set-parameters "message" :follow (lambda (path)
                                               (browse-url (concat "message://" path))))
  (setq org-publish-project-alist
        '(("syntax-transformers"
           :base-directory "~/code/capfredf.github.io/org/"
           ;; the publish result will follow the directory structure in the base directory
           :publishing-directory "~/code/capfredf.github.io/"
           :publishing-function org-html-publish-to-html
           :headline-levels 4
           :html-extension "html"
           :body-only t
           :recursive t
           :with-author nil)
          ("org"
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
           :with-author nil)
          ("static"
           :base-directory "~/brain/static/"
           :base-extension any
           :recursive t
           :publishing-directory "~/captainwiki/static"
           :publishing-function org-publish-attachment))))

(use-package org-superstar
  :ensure t
  :hook (org-mode . org-superstar-mode))


(use-package org-super-agenda
  :ensure t
  :defer t
  :hook ((org-agenda-mode . org-super-agenda-mode)))



(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

(use-package auctex
  :ensure t
  :mode (("\\.tex" . TeX-latex-mode))
  :config
  (require 'reftex)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)

  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq TeX-save-query nil))


(use-package racket-unicode-input-method
  :commands racket-unicode-input-method-enable)

(use-package racket-mode
  :ensure t
  ;; :no-require t
  :mode "\\.rkt"
  ;; :load-path "site-lisp/racket-mode"
  :init
  (add-hook 'racket-mode-hook      #'racket-xp-mode)
  (add-to-list 'auto-mode-alist '("\\.pie$" . racket-mode))
  (add-to-list 'auto-mode-alist '("\\.scrbl$" . racket-mode))
  :config
  (setq racket-program (executable-find "racket"))
  (put 'Π 'racket-indent-function 1)
  (put 'type-case 'racket-indent-function 2)
  (racket-unicode-input-method-enable)
  (with-temp-buffer
    (racket-unicode-input-method-enable)
    (set-input-method "racket-unicode")
    (let ((quail-current-package (assoc "racket-unicode"
                                        quail-package-alist)))
      (quail-define-rules ((append . t))
                          ("TT " ["𝕋𝕋"])
                          ("FF " ["𝔽𝔽"])
                          ("ll " ["≪"])
                          ("lte " ["≤"])
                          ("gte " ["≥"])
                          ("bot " ["⊥"])
                          ("top " ["⊤"])
                          ("eqv " ["≡"])
                          ("dt " ["·"])
                          ("^c "  ["ᶜ"])
                          ("^D "  ["ᴰ"])
                          ("^d "  ["ᵈ"])
                          ("^n "  ["ⁿ"])
                          ("^f "  ["ᶠ"])
                          ("^- "  ["⁻"])
                          ("_p "  ["ₚ"])
                          ("_v "  ["ᵥ"])
                          ("_v "  ["ᵥ"])
                          ("pm " ["±"])
                          ("ring " ["⊚"])
                          ("aster " ["⊛"])
                          ("Vdash " ["⊩"])
                          ("diamond " ["◊"])
                          ("nexists " ["∄"]))))
  (put 'required/typed 'racket-indent-function 1)
  (put 'term-let 'racket-indent-function 1))

;; (use-package typescript-mode
;;   :ensure t
;;   :mode "\\.ts")

(use-package eshell
  :requires eat
  :hook ((eshell-load-hook . eat-shell-mode)
         (eshell-load-hook . eat-eshell-visual-command-mode)))

(load-file (let ((coding-system-for-read 'utf-8))
             (shell-command-to-string "agda-mode locate")))


;; (use-package ob-racket
;;   :ensure t
;;   :vc (url . "")
;;   :after org)
