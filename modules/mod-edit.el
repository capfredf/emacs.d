(put 'upcase-region 'disabled nil)

(delete-selection-mode 1)

(use-package s)
(use-package dash)
(use-package wgrep
  :after grep)

(use-package wgrep-ag
  :defer t)


(use-package scribble-mode
  :mode "\\.scribl")

(use-package ag
  :defer t
  :config
  (autoload 'wgrep-ag-setup "wgrep-ag")
  (add-hook 'ag-mode-hook 'wgrep-ag-setup))

(use-package multiple-cursors
  :defer t
  ;; :config
  ;; (define-key mc/keymap (kbd "C-'") 'mc-hide-unmatched-lines-mode)
  :bind (("C-M-e" . mc/edit-lines)
         ("C-." . mc/mark-next-like-this)
         ("C-," . mc/mark-previous-like-this)
         ("C->" . mc/skip-to-next-like-this)
         ("C-<" . mc/skip-to-previous-like-this)))

(use-package expand-region
  :bind (("C-=" . er/expand-region)))

(defun select-line ()
  (interactive)
  (move-beginning-of-line nil)
  (push-mark (point) nil t)
  (next-line 1)
  (move-beginning-of-line 1))

(defun myjoin-line ()
  (interactive)
  (next-line 1)
  (join-line)
  (indent-for-tab-command))

(defun open-line-before()
  (interactive)
  (previous-line)
  (open-line-after))

(defun open-line-after()
  (interactive)
  (move-end-of-line nil)
  (newline)
  (indent-for-tab-command))

(global-set-key (kbd "C-l") nil)
(global-set-key (kbd "C-l j") 'myjoin-line)
(global-set-key (kbd "C-l s") 'select-line)
(global-set-key (kbd "C-l o") 'open-line-after)
(global-set-key (kbd "C-l O") 'open-line-before)

(global-set-key (kbd "M-k") nil)
(global-set-key (kbd "M-k k") 'kill-whole-line)

;; (use-package yasnippet
;;   :hook ((prog-mode . yas-minor-mode)
;;          (org-mode . yas-minor-mode)
;;          (tex-mode . yas-minor-mode))
;;   :configt
;;   (setq yas-snippet-dirs
;; 		'("~/.emacs.d/yasnippet-snippets/snippets"                 ;; personal snippets
;; 		  "~/.emacs.d/snippets"                 ;; personal snippets
;; 		  ))
;;   (yas-reload-all))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; (use-package swiper
;;   :ensure t
;;   :bind
;;   (("C-s" . swiper-isearch)))


(use-package paredit
  :demand t
  :init
  (add-hook 'racket-mode-hook #'enable-paredit-mode)
  (add-hook 'racket-repl-mode-hook #'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
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

;; (use-package scribble
;;   :load-path "site-lisp/scribble-emacs")

;; (use-package flycheck
;;   :ensure t
;;   :init (global-flycheck-mode))

;; (require 'electric-pair)
;; (setq-local xxxxxxxxxxxx 10)

;; electric-pair-pairs
;; (use-package flycheck
;;   :ensure t)

(defun global-disable-mode (mode-fn)
  "Disable `MODE-FN' in ALL buffers."
  (interactive "a")
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      (funcall mode-fn -1))))

(defun jump-to-file-and-line ()
  (interactive)
  (let ((line (buffer-substring-no-properties (point-at-bol) (point-at-eol))))
    (let ((tuple (string-match "\\([a-zA-Z/._]+\\):\\([0-9]+\\)" line)))
      (let ((file (match-string 1 line))
            (lnum (match-string 2 line))
            (dir (projectile-project-root)))
        (when (and file (file-exists-p (concat dir file)))
          (find-file-other-window (concat dir file))
          (and lnum (goto-line (string-to-number lnum))))))))

(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.33)))

(global-set-key (kbd "C-M-]") 'jump-to-file-and-line)

(defun insert-current-time ()
  (interactive)
  (insert (format-time-string "%D, %R")))

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; remap C-a to `smarter-move-beginning-of-line'"e
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

(defun with-face (str &rest face-plist)
  (propertize str 'face face-plist))

(defun shk-eshell-prompt ()
  (let ((header-bg "#fafafa"))
    (concat
     (with-face "\n" :background header-bg)
     (with-face (concat (eshell/pwd) " ") :background header-bg)
     (with-face
      (or (ignore-errors (format "(%s)" (vc-responsible-backend default-directory))) "")
      :background header-bg)
     (with-face "\n" :background header-bg)
     (with-face user-login-name :foreground "#64a6ae")
     "@"
     (with-face (system-name) :foreground "#889a2e")
     (if (= (user-uid) 0)
         (with-face " #" :foreground "red")
       " $")
     " ")))
(setq eshell-prompt-function 'shk-eshell-prompt)
(setq eshell-highlight-prompt nil)


(defun insert-file-name-into-minibuffer (full-path)
  (interactive "P")
  (let ((path (buffer-file-name (window-buffer (minibuffer-selected-window)))))
    (insert (if full-path
                path
              (if (project-root (project-current))
                  (file-relative-name path (project-root (project-current)))
                (file-name-nondirectory path))))))

(define-key minibuffer-local-map (kbd "M-.") 'insert-file-name-into-minibuffer)
;; (setq org-reveal-root "file:///Users/capfredf/Downloads/reveal.js-3.8.0/")
;; (setq org-reveal-history t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; writing ;;;;;;;;;;;;;;;;;
;; (defvar variable-tuple (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
;;                              ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
;;                              ((x-list-fonts "Verdana")         '(:font "Verdana"))
;;                              ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
;;                              (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
;; (defvar base-font-color (face-foreground 'default nil 'default))
;; (defvar headline `(:inherit default :weight bold :foreground ,base-font-color))


;; conflict with olivetti
;; (use-package visual-fill-column
;;   :ensure t
;;   :hook (visual-line-mode . visual-fill-column-mode))

(use-package olivetti
  :hook (org-mode . olivetti-mode))

(use-package org
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
  (org-latex-create-formula-image-program 'dvisvgm)
  ;; (org-hide-emphasis-markers nil)
  (org-fontify-done-headline t)
  (org-src-fontify-natively t)
  (org-image-actual-width 500)
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

(use-package org-bullets :after org)

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
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

(use-package auctex
  :mode (("\\.tex" . TeX-latex-mode))
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq TeX-save-query nil))

(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

(use-package deft
  :bind ("<f8>" . deft)
  :custom
  (deft-directory "~/brain/")
  (deft-auto-save-interval 0)
  (deft-extensions '("org" "md" "txt" "tex")))


;; (use-package org-roam
;;   :ensure t
;;   :hook
;;   (org-mode . org-roam-mode)
;;   :bind (:map org-roam-mode-map
;;               (("C-c n l" . org-roam)
;;                ("C-c n f" . org-roam-find-file)
;;                ("C-c n b" . org-roam-switch-to-buffer)
;;                ("C-c n g" . org-roam-show-graph))
;;          :map org-mode-map
;;          (("C-c n i" . org-roam-insert))))

(defun formatted-copy ()
  "Export region to HTML, and copy it to the clipboard."
  (interactive)
  (save-window-excursion
    (let* ((buf (org-export-to-buffer 'html "*Formatted Copy*" nil nil t t))
           (html (with-current-buffer buf (buffer-string))))
      (with-current-buffer buf
        (shell-command-on-region
         (point-min)
         (point-max)
         "textutil -stdin -format html -convert rtf -stdout | pbcopy"))
      (kill-buffer buf))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; coding
;;;;;;;;;;;;;;;

(setq-default c-basic-offset 4
	          tab-width 4
	          indent-tabs-mode nil)

;; (use-package agda2-mode
;;   :mode "\\.agda"
;;   :load-path "/usr/local/share/emacs/site-lisp/agda"
;;   :defer nil
;;   ;; :custom-face
;;   ;;  (agda2-highlight-datatype-face ((t (:foreground "dodger blue"))))
;;   ;;  (agda2-highlight-function-face ((t (:foreground "dodger blue"))))
;;   ;;  (agda2-highlight-postulate-face ((t (:foreground "dodger blue"))))
;;   ;;  (agda2-highlight-primitive-face ((t (:foreground "dodger blue"))))
;;   ;; (agda2-highlight-primitive-type-face ((t (:foreground "dodger blue"))))
;;   )


;; (use-package haskell-mode
;;   :mode "\\.hs")

;; (use-package proof-general
;;   :mode ("\\.v" . coq-mode)
;;   :load-path "$HOME/.emacs.d/PG/generic/proof-site")



(setq shell-file-name "bash")

(setq comint-prompt-read-only t)

(setenv "PLT_TR_CONTRACTS" "1")

(defun open-dashboard ()
  (interactive)
  (find-file "~/brain/main.org"))

(bind-key "<f9>" 'open-dashboard)

(use-package racket-unicode-input-method
  :commands racket-unicode-input-method-enable)

(use-package racket-mode
  ;; :no-require t
  :mode "\\.rkt"
  ;; :load-path "/Users/capfredf/site-lisp/racket-mode"
  :init
  (add-hook 'racket-mode-hook      #'racket-xp-mode)
  (add-to-list 'auto-mode-alist '("\\.pie$" . racket-mode))
  :config
  (setq racket-racket-program (executable-find "racket"))
  (setq racket-raco-program (executable-find "raco"))
  (put 'Π 'racket-indent-function 1)
  (racket-unicode-input-method-enable)
  (put 'required/typed 'racket-indent-function 1))
;; (load "/Users/phay/.opam/system/share/emacs/site-lisp/tuareg-site-file")

;; (use-package rust-mode
;;   :ensure t)

;;(require 'flycheck)
;; (flycheck-define-checker pie
;;   "A Pie type error checker."
;;   ;:command ("/Users/capfredf/code/chaos/pie/tmp.sh")
;;   :command ("/Users/capfredf/.racket/bin/raco" "expand" source)
;;   :error-patterns
;;   ((error line-start (message (one-or-more (or "\n" not-newline))) "\n  location...:\n" (or (one-or-more space) "\t") (file-name)":" line ":" column line-end)
;;    (info "'\"" (file-name) ":" line "." column ":" " TODO:" (message) "\""))
;;   :modes racket-mode
;;   :error-filter
;;   (lambda (errors)
;;     (dolist (err (flycheck-sanitize-errors errors))
;;       (-when-let (msg (flycheck-error-message err))
;;         (setf (flycheck-error-message err)
;;               (s-replace "\\n" "\n" msg))))
;;     (flycheck-increment-error-columns errors))
;;   :predicate
;;   (lambda ()
;;     (equal (file-name-extension (buffer-file-name)) "pie")))


;; (use-package python-mode
;;   :mode "\\.py"
;;   :interpreter ("python" . python-mode))


;; (require 'rx)
;; (s-matches-p
;;  (rx "'\"" "/Users/capfredf/code/lecture-types-2020/draft-hello.pie" ":" (one-or-more digit) "." (one-or-more digit) ":" " TODO:"  (one-or-more (or "\n" not-newline)) "\"")
;;  "'\"/Users/capfredf/code/lecture-types-2020/draft-hello.pie:8.6: TODO:\n A : U\n n : Nat\n v : (Vec A n)\n---------------\n A\n\n\"")

;; (add-to-list 'flycheck-checkers 'pie)
;; (add-to-list 'flycheck-checkers 'pie-todo)

;; (use-package org-ref
;;   :ensure t
;;   :custom
;;   (org-ref-completion-library 'org-ref-ivy-cite)
;;   (reftex-default-bibliography '("~/captainwiki/bibliography/references.bib"))
;;   (org-ref-bibliography-notes "~/captainwiki/bibliography/notes.org")
;;   (org-ref-pdf-directory "~/captainwiki/bibliography/bibtex-pdfs/"))


(provide 'mod-edit)
