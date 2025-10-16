(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             t)
(package-initialize)
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))


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
(defconst new-brain-dir (expand-file-name "~/sync/new-brain"))

(put 'downcase-region 'disabled nil)

(setq custom-file (concat user-emacs-directory "setting.el"))
(when (file-exists-p custom-file)
  (load custom-file))
;; (set-fontset-font "fontset-default" 'symbol "Noto Color Symbols 2" nil 'append)
;; (set-fontset-font "fontset-default" 'symbol "Noto Color Symbols 2")
(setq make-backup-files nil)
(define-coding-system-alias 'UTF-8 'utf-8)
(define-coding-system-alias 'utf8 'utf-8)
(set-language-environment 'utf-8)
;; (setopt use-package-always-ensure t)

(defalias 'yes-or-no-p 'y-or-n-p)
;; (setq-default abbrev-mode t)
(autoload 'ibuffer "ibuffer" "List buffers." t)
(global-set-key (kbd "C-x b") 'ibuffer)
(global-set-key (kbd "<f5>") #'compile)
(toggle-frame-maximized)
(global-unset-key (kbd "M-z")) ;; unbind (suspend-frame) to C-z
(global-unset-key (kbd "C-x z")) ;; unbind repeat to C-x switch the two
(setopt tab-always-indent t)

(require 'treesit)
(setq treesit-extra-load-path
      '("/home/capfredf/code/tree-sitter-module/dist"))

;; (use-package use-package-ensure-system-package
;;   :ensure t)
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(pgtk))
  :config
  (exec-path-from-shell-initialize))

(use-package dired
  :hook (dired-mode . dired-hide-details-mode))

(use-package bind-key
  :ensure t
  :demand t)

(defvar open-closing-pairs
  '((?\[ . ?\])
    (?\{ . ?\})
    (?\( . ?\))
    (?\" . ?\")
    (?\' . ?\')))

(global-set-key (kbd "M-[") #'insert-pair)
(global-set-key (kbd "M-{") #'insert-pair)
(global-set-key (kbd "M-<backspace>") #'delete-pair)
(use-package meow
  :ensure t
  :init
  (defun surround-delimiters (delimiter)
    (interactive "cdelimiter: ")
    (setq the-other-delimiter (alist-get delimiter open-closing-pairs))
    (cond
     ((not the-other-delimiter)  (message "%c is not electric pairs" delimiter))
     (t
      (meow-grab)
      (meow-append)
      (insert delimiter)
      (insert the-other-delimiter)
      (ignore)
      (backward-char)
      (meow-swap-grab))))

  (defun meow-paredit-setup ()
    ;; (setq meow-paren-keymap (make-keymap))
    ;; (meow-define-state paren "paredit mode" :lighter " [P]"
    ;;                    ;; :face '(:background "#cea2fd")
    ;;                    :keymap meow-paren-keymap)
    ;; (setq meow-cursor-type-paren 'hollow)
    (meow-normal-define-key
     ;; 'paren
     '("s l" . paredit-forward)
     '("s h" . paredit-backward)
     '("s r" . paredit-raise-sexp)
     '("s s" . paredit-splice-sexp-killing-backward)
     '("s j" . paredit-backward-down)
     '("s J" . paredit-backward-up)
     '("s k" . paredit-forward-down)
     '("s K" . paredit-forward-up)
     '("s ." . paredit-forward-slurp-sexp)
     '("s >" . paredit-forward-barf-sexp)
     '("s ," . paredit-backward-slurp-sexp)
     '("s <" . paredit-backward-barf-sexp)
     '("s S" . paredit-splice-sexp)
     '("s (" . paredit-wrap-round)
     '("s o" . paredit-close-round-and-newline)
     ;; '("l" . sp-forward-sexp)
     ;; '("h" . sp-backward-sexp)
     ;; '("j" . sp-down-sexp)
     ;; '("k" . sp-up-sexp)
     ;; '("w s" . sp-wrap-square)
     ;; '("w r" . sp-wrap-round)
     ;; '("w c" . sp-wrap-curly)
     ;; '("W" . sp-unwrap-sexp)
     ;; '("n" . sp-forward-slurp-sexp)
     ;; '("b" . sp-forward-barf-sexp)
     ;; '("v" . sp-backward-barf-sexp)
     ;; '("c" . sp-backward-slurp-sexp)
     ;; '("s" . sp-splice-sexp-killing-forward)
     ;; '("S" . sp-splice-sexp-killing-backward)
     ;; '("e" . sp-end-of-sexp)
     ;; '("a" . sp-beginning-of-sexp)
     ;; '("t" . sp-transpose-hybrid-sexp)
     ;; '("u" . meow-undo)
     ))
  (add-hook 'paredit-mode-hook #'meow-paredit-setup)
  (defun meow-setup ()
    (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
    ;; (meow-paredit-setup ())
    (meow-motion-define-key
     '("j" . meow-next)
     '("k" . meow-prev)
     '("<escape>" . ignore))
    (meow-leader-define-key
     ;; SPC j/k will run the original command in MOTION state.
     ;; '("j" . "H-j")
     ;; '("k" . "H-k")
     ;; Use SPC (0-9) for digit arguments.
     '("1" . meow-digit-argument)
     '("2" . meow-digit-argument)
     '("3" . meow-digit-argument)
     '("4" . meow-digit-argument)
     '("5" . meow-digit-argument)
     '("6" . meow-digit-argument)
     '("7" . meow-digit-argument)
     '("8" . meow-digit-argument)
     '("9" . meow-digit-argument)
     '("0" . meow-digit-argument)
     '("/" . meow-keypad-describe-key)
     '("?" . meow-cheatsheet))
    (meow-normal-define-key
     '("C-x C-f" . me/ignore-vanilla-keybindings)
     '("C-x C-b" . me/ignore-vanilla-keybindings)
     '("C-x b" . me/ignore-vanilla-keybindings)
     '("M-x" . me/ignore-vanilla-keybindings)
     '("RET" . meow-next)
     '("0" . meow-expand-0)
     '("9" . meow-expand-9)
     '("8" . meow-expand-8)
     '("7" . meow-expand-7)
     '("6" . meow-expand-6)
     '("5" . meow-expand-5)
     '("4" . meow-expand-4)
     '("3" . meow-expand-3)
     '("2" . meow-expand-2)
     '("1" . meow-expand-1)
     '("-" . negative-argument)
     '(";" . meow-reverse)
     '("," . meow-inner-of-thing)
     '("." . meow-bounds-of-thing)
     '("[" . meow-beginning-of-thing)
     '("]" . meow-end-of-thing)
     '("a" . meow-append)
     '("!" . meow-universal-argument)
     '("o" . meow-open-below)
     '("b" . meow-back-word)
     '("B" . meow-back-symbol)
     '("c" . meow-change)
     '("d" . meow-kill)
     '("e" . meow-next-word)
     '("E" . meow-next-symbol)
     '("f" . meow-find)
     '("g" . meow-cancel-selection)
     '("G" . meow-grab)
     '("h" . meow-left)
     '("H" . meow-left-expand)
     '("i" . meow-insert)
     '("O" . meow-open-above)
     '("j" . meow-next)
     '("J" . meow-next-expand)
     '("k" . meow-prev)
     '("K" . meow-prev-expand)
     '("l" . meow-right)
     '("L" . meow-right-expand)
     '("m" . meow-join)
     '("n" . meow-search)
     '("p" . meow-yank)
     '("q" . meow-quit)
     '("Q" . meow-goto-line)
     '("r" . meow-replace)
     '("R" . meow-swap-grab)
     '("x" . meow-delete)
     '("X" . meow-backward-delete)
     '("t" . meow-till)
     '("u" . meow-undo)
     '("U" . meow-undo-in-selection)
     '("v" . meow-visit)
     '("w" . meow-mark-word)
     '("W" . meow-mark-symbol)
     '("V" . meow-line)
     '("X" . meow-goto-line)
     '("y" . meow-save)
     '("Y" . meow-sync-grab)
     '("z" . meow-pop-selection)
     '("'" . repeat)
     ;; '("$" . meow-block)
     '("$" . meow-block)
     '("#" . meow-to-block)
     '("<escape>" . ignore)))

  (defun me/ignore-vanilla-keybindings ()
    (interactive)
    (message "Follow the meow way"))

  (defun my/kill-buffer ()
    (interactive)
    (kill-buffer (buffer-name)))
  ;; following keys because using Meow, C-x C-<key> requires fewer key strokes, which
  ;; is important for a regular comamnd like kill-buff
  (global-set-key (kbd "C-x C-k") 'my/kill-buffer)
  (global-set-key (kbd "C-x C-o") 'other-window)
  ;; (global-set-key (kbd "C-c C-p") 'surround-delimiters)
  (global-set-key (kbd "C-x k") #'kmacro-keymap)
  ;; C-x C-p oringally is bound to mark-page. The command becomes moot in presence of Meow
  ;; we need to unbind the key first, as the global keymap take the most precedence.
  (global-unset-key (kbd "C-x C-p"))
  (define-key ctl-x-map "C-p" project-prefix-map)

  :config
  ;; (defun me/meow-setup-indicator ()
  ;;   (unless (cl-find '(:eval (meow-indicator)) mode-line-format :test 'equal)
  ;;     (setq-default mode-line-format (append '((:eval (propertize (meow-indicator) 'face '(:background "yellow")))) mode-line-format))))
  (meow-indicator)
  (meow-setup-indicator)
  (meow-setup)
  ;; (setopt meow-keypad-leader-dispatch ctl-x-map)
  ;; (setopt meow-keypad-leader-dispatch "C-x")
  (meow-global-mode t))

(defun consult-brain--files ()
  (interactive "p")
  (directory-files-recursively "~/my-brain/" "\.org$"))

(defvar consult-brain--sources
  `(:name "This Brain directory/project"
          :narrow ?.
          :category buffer
          :face consult-file
          :history file-name-history
          :items ,#'consult-brain--files)
  "Current project directory for `consult-brain--pick'.")

(defun create-link ()
  (interactive)
  (let ((picked (car (consult--multi (list consult-brain--sources) ;; must be a list
                                     :prompt "All Brain Files:"
                                     :sort nil)))
        (desc (read-string "Description: ")))
    (insert (format "[[file:%s][%s]]" picked desc))))



(use-package vertico
  :ensure t
  :init
  (defun up-directory (arg)
    "Move up a directory (delete backwards to /)."
    (interactive "p")
    (if (string-match-p "/." (minibuffer-contents))
        (save-excursion
          (let ((end (point)))
            (goto-char (1- end))
            (when (search-backward "/" (minibuffer-prompt-end) t)
              (delete-region (1+ (point)) end))))
      (delete-minibuffer-contents)))
  (vertico-mode)
  :bind (:map vertico-map
              ("C-l" . up-directory)))

(use-package savehist
  :ensure t
  :init
  (savehist-mode))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :ensure t
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  :custom
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil)
  (completion-styles '(orderless)))

(use-package consult
  :ensure t
  :bind
  (("C-x C-b" . consult-buffer)
   ("M-y" . consult-yank-pop)))

(use-package project
  :ensure t
  :bind
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


(use-package solarized-theme
  :ensure t
  :config
  (switch-theme 'solarized-light))


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
:ensure t
;;   :ensure t
;;   :mode "\\.scribl")

(use-package ag
  :ensure t
  :config
  (autoload 'wgrep-ag-setup "wgrep-ag")
  (add-hook 'ag-mode-hook 'wgrep-ag-setup))


(use-package flymake
  :ensure t
  :bind (:map flymake-mode-map
							("M-n" . 'flymake-goto-next-error)
							("M-p" . 'flymake-goto-prev-error)))

(use-package ws-butler
  :ensure t
  :hook (prog-mode . ws-butler-mode))

(use-package marginalia
  :ensure t
  :init
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
  (add-hook 'eldoc-documentation-fucntions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))


(use-package beancount-mode
  :ensure t
  :vc (:url "git@github.com:beancount/beancount-mode.git"
            :branch "main")
  :mode "\\.beancount")

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package paredit
  :ensure t
  :init
  (add-hook 'racket-mode-hook 'enable-paredit-mode)
  ;; (add-hook 'racket-repl-mode-hook 'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  :config
  (unbind-key "C-M-f" paredit-mode-map)
  (unbind-key "C-M-s" paredit-mode-map)
  (unbind-key "C-<left>" paredit-mode-map)
  (unbind-key "C-<right>" paredit-mode-map)
  (unbind-key "C-<up>" paredit-mode-map)
  (unbind-key "C-<down>" paredit-mode-map)
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

  ;; (defface meow-paren-indicator
  ;; '((((class color) (background dark))
  ;;    ())
  ;;   (((class color) (background light))
  ;;    ()))
  ;; "Normal state indicator."
  ;; :group 'meow)

  ;; (push '(paren . meow-paren-indicator) meow-indicator-face-alist)
)


(use-package olivetti
  :ensure t
  :hook (org-mode . olivetti-mode))


;; (org-ql-search (org-agenda-files) '(and (todo "TODO") (not (scheduled :to today))))
;; (use-package org-ql
;;   :ensure t
;;   :config
;;   ;; I don't need to bury the buffer. I want to exit the view
;;   ;; (require 'org-ql-view)
;;   ;; (bind-key "q" 'org-agenda-exit org-ql-view-map)
;;   ;; (bind-key "G" 'org-ql-view-refresh org-ql-view-map)
;;   ;; there are no bindings in org-ql-view-map for those keys, we need to unbind
;;   ;; those keys from its parent keymap
;;   ;; (unbind-key "h" org-agenda-mode-map)
;;   ;; (unbind-key "H" org-agenda-mode-map)
;;   ;; (unbind-key "l" org-agenda-mode-map)
;;   ;; (unbind-key "L" org-agenda-mode-map)
;;   :init
;;   (add-hook 'org-agenda-finalize-hook 'meow-motion-mode)
;;   (defun my/all-available-tasks ()
;;     (interactive)
;;     (org-ql-search (org-agenda-files) '(and (todo) (not (todo "DOING")) (not (scheduled :to today)) (not (blocked)))
;;       :sort '(todo date)
;;       :title "Today's View"
;;       :super-groups '((:name "Upcoming" :and (:scheduled future :todo "TODO"))
;;                       (:name "Hiatus" :and (:todo "TODO" :tag "hiatus"))
;;                       (:name "Waiting" :and (:todo "WAITING"))
;;                       (:name "Papers" :and (:todo "TODO" :tag "paper"))
;;                       (:name "Someday" :todo "Someday" )
;;                       (:name "Deadlined" :deadline future))))

;;   (defun my/show-scheduled ()
;;     (interactive)
;;     (org-ql-search (org-agenda-files) '(or (and (not (blocked)) (scheduled :to today) (todo "TODO" "WAITING"))
;;                                            (and (deadline) (todo "TODO" "WAITING"))
;;                                            (habit)
;;                                            ;; (and (ts-active :on today) (todo "TODO" "WAITING"))
;;                                            (todo "DOING"))
;;       :sort '(todo date)
;;       :title "Today's View"
;;       :super-groups '((:name "In-Progress" :todo "DOING" )
;;                       (:name "Habit" :habit t)
;;                       (:name "Waiting" :and (:scheduled today :todo "WAITING"))
;;                       (:name "Fitness" :and (:scheduled today :category "workout"))
;;                       (:name "Daily" :and (:scheduled today :category "daily"))
;;                       (:name "Avaiable" :and (:scheduled t :not (:and (:category "daily" :category "workout"))
;;                                                          :todo "TODO"))
;;                       (:name "Deadlined" :deadline future))))

;;   :bind
;;   (("C-c q" . my/show-scheduled)
;;    ("C-c a" . my/all-available-tasks)
;;    ;; can't use the method below, because the variable is not in scope when org-ql is loaded
;;    ;; :map org-ql-view-map
;;    ;; ("q" . kill-buffer)
;;    ))

;; ;; (fullscreen)

;; (use-package org-agenda
;;   :defer t
;;   ;; :config
;;   ;; (bind-key "j" 'org-agenda-next-line org-agenda-mode-map)
;;   :bind
;;   (:map org-agenda-mode-map
;;         ;; ("q" . org-agenda-Quit)
;;         ;; ("x" . org-agenda-quit)
;;         ("n" . org-agenda-goto-date)
;;         ("j" . org-agenda-next-line)
;;         ("k" . org-agenda-previous-line)))

(use-package org
  :ensure t
  :mode ("\\.org" . org-mode)
  :init 
  (add-hook 'org-mode-hook (lambda ()
                             ;; (org-bullets-mode 1)
                             ;; (variable-pitch-mode 1)
                             (setq fill-column 100)))
  (setopt org-agenda-dim-blocked-tasks t)
  (setopt org-capture-templates
          `(("T" "Fleeting notes or task" entry
             (file+function "~/sync/new-brain/dashboard.org" ,(lambda ()
                                                                (beginning-of-buffer)
                                                                (org-next-visible-heading 1)))
             "")))
  (setopt org-todo-keywords '((sequence "TODO(t)" "DOING(n)" "WAITING(w)" "Someday(s)" "|" "CANCELLED(c)" "DONE(d)")))
  (setopt org-latex-create-formula-image-program 'dvisvgm)
  (setopt org-fontify-done-headline t)
  (setopt org-src-fontify-natively t)
  (setopt org-image-actual-width 500)
  (setopt org-outline-path-complete-in-steps nil) ;; show all headlines in a file when refiling a substree
  (setopt org-export-with-toc nil)
  :custom-face
  ;; (org-quote ((t (:height 2.0))))
  (org-done ((t (:foreground "dim gray" :strike-through t))))
  (org-block ((t (:inherit fixed-pitch))))
  (org-headline-done ((t (:foreground "dim gray" :strike-through t))))
  (org-document-title ((t (:height 1.5 :underline nil))))
  :bind (
         ;;("C-c a" . org-agenda)
         ("<f9>" . org-capture)
         ;;("C-c g" . counsel-org-goto-all)
         :map org-mode-map
         ("C-c l" . org-store-link)
         ("C-c C-j" . my/new-day)
         ("C-c C-M-o" . org-mark-ring-goto)
         ("s-n" . org-next-visible-heading)
         ("s-p" . org-previous-visible-heading)
         ("s-u" . outline-up-heading)
         ("s-l" . org-forward-heading-same-level)
         ("s-h" . org-backward-heading-same-level))
  :config
  ;; (defun my/org-count-subtree-words ()
  ;;     (interactive)
  ;;     (save-excursion
  ;;       (org-back-to-heading t)
  ;;       (org)))
  ;; (defface org-inline-tags-face
  ;;   '((t (:foreground "orange" :weight bold)))
  ;;   "Face for custom inline tags in plain list items.")

  ;; (font-lock-add-keywords 'org-mode
  ;;                         '(("#\\(\\w+\\(-\\w+\\)*\\)" 0 'org-inline-tags-face prepend)))
  (require 'ox-publish)
  ;; (setopt org-agenda-custom-commands
  ;;         '(("z" "Daily Agenda View"
  ;;            ((org-ql-block '(or (and (scheduled :to today) (todo "TODO" "WAITING"))
  ;;                                (and (planning) (todo "TODO" "WAITING"))
  ;;                                (and (ts-active :on today) (todo "TODO" "WAITING"))
  ;;                                (todo "DOING"))
  ;;                           ((org-super-agenda-groups '((:name "In-Progress" :todo "DOING" )
  ;;                                                       (:name "Waiting" :and (:scheduled today :todo "WAITING"))
  ;;                                                       (:name "Fitness" :and (:scheduled today :category "workout"))
  ;;                                                       (:name "Daily" :and (:scheduled today :category "daily"))
  ;;                                                       (:name "Available" :and (:scheduled today :not (:and (:category "daily" :category "workout"))
  ;;                                                                                           :todo "TODO"))
  ;;                                                       (:name "Future" :scheduled future)))))

  ;;             (agenda)))))
  (setf (alist-get 'xdvsvgm org-preview-latex-process-alist)
        '(:programs ("xelatex" "dvisvgm") :description "xdv > svg" :message
                    "you need to install the programs: latex and dvisvgm."
                    :image-input-type "xdv" :image-output-type "svg" :image-size-adjust
                    (1.7 . 1.5) :latex-compiler
                    ("xelatex -no-pdf -interaction nonstopmode -output-directory %o %f")
                    :image-converter
                    ("dvisvgm %f --no-fonts --exact-bbox --scale=%S --output=%O")))
  ;; (add-to-list 'org-preview-latex-process-alist 'dvisvgm)
  (setopt org-latex-listings 'minted
          org-latex-packages-alist '(("" "minted")
                                     ("" "mathtools")
                                     ("" "amssymb")
                                     ("" "bbm")
                                     ("" "mathpartir"))
          org-hide-emphasis-markers t
          org-latex-create-formula-image-program 'xdvsvgm
          org-ctags-open-link-functions nil ;; disable the ctags to correctly open internal links
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
           :auto-sitemap t               ; Generate sitemap.org automagically...
           :sitemap-filename "index.org" ; ... call it sitemap.org (it's the default)...
           :sitemap-title "Inside:"      ; ... with title 'Sitemap'.
           :sitemap-sort-files anti-chronologically
           :with-author nil)
          ("static"
           :base-directory "~/brain/static/"
           :base-extension any
           :recursive t
           :publishing-directory "~/captainwiki/static"
           :publishing-function org-publish-attachment))))

;; (defun my/org-entry-range ()
;;    (let ((elt (org-element-at-point)))
;;        (cons (org-element-property :begin elt)
;;               (org-element-property :end elt))))

;; (defun my/make-invisible (range)
;;    (let ((ov (make-overlay (car range) (cdr range))))
;;       (overlay-put ov 'invisible t)
;;       (overlay-put ov 'org-hide-done t)
;;       (overlay-put ov 'evaporate t)))

;; (defun my/org-hide-done-tasks ()
;;    (mapc #'my/make-invisible (org-map-entries #'my/org-entry-range "TODO=\"DONE\"" 'file)))

;; (defun my/org-toggle-done-tasks-visibility ()
;;   "Toggle visibility of DONE tasks in the current buffer."
;;   (interactive)
;;   (if (seq-find (lambda (ov) (overlay-get ov 'org-hide-done))
;;                 (overlays-in (point-min) (point-max)))
;;       ;; If DONE entries are hidden, show them
;;       (remove-overlays (point-min) (point-max) 'org-hide-done t)
;;     ;; Otherwise, hide DONE entries
;;     (my/org-hide-done-tasks)))

;; (use-package org-superstar
;;   :ensure t
;;   :after org
;;   :hook (org-mode . org-superstar-mode))


(use-package org-modern
  :ensure t
  :hook ((org-mode . org-modern-mode)))

(use-package org-super-agenda
  :ensure t
  :hook ((org-agenda-mode . org-super-agenda-mode)))



(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

(use-package auctex
  :ensure t
  :mode (("\\.tex" . LaTeX-mode))
  :config
  (require 'reftex)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)

  (setopt TeX-auto-save t)
  (setopt TeX-parse-self t)
  (setopt TeX-save-query nil))

(define-key minibuffer-local-map [f3]
  (lambda () (interactive)
     (insert (buffer-name (window-buffer (minibuffer-selected-window))))))

(defconst date-pos (length "Today -- "))
(defun my/new-day ()
  (interactive)
  (let ((headline "Timeline")
        (file (expand-file-name "dashboard.org" new-brain-dir)))
    (save-excursion
      (find-file file)
      ;; go the the first heading
      (goto-char (point-min))
      (unless (org-at-heading-p)
        (org-next-visible-heading 1)
        (org-edit-headline (substring (nth 4 (org-heading-components)) date-pos))
        (let* ((pos (org-find-exact-headline-in-buffer headline)))
          (org-refile nil nil (list headline file nil pos)))
        (org-insert-heading)
        (insert (format "Today -- %s" (format-time-string "%m/%d/%Y" (current-time))))
        (newline)))))

(use-package racket-mode
  ;; pick the :ensure or :load-path X :vc t
  ;; as ensure always ensures the package to be downloaded from elpa or melpa
  ;; :ensure t
  ;; :vc t ;; this rids me of manually load the autoloads file
  ;; :load-path "site-lisp/racket-mode"
  :mode "\\.rkt"
  ;; not very useful for developing or fix packages
  ;; :vc (:url "git@github.com:greghendershott/racket-mode.git"
  ;;      :branch "issue-759")
  :init
  ;; (load-library "racket-mode-autoloads")
  (defun my/racket-hash-lang-module-lang-hook (arg)
    (setq-local racket-xp-add-binding-faces t))
  (add-hook 'racket-mode-hook      #'racket-xp-mode)
  (add-hook 'racket-hash-lang-mode-hook #'racket-xp-mode)
  (add-hook 'racket-hash-lang-module-language-hook #'my/racket-hash-lang-module-lang-hook)
  (add-to-list 'auto-mode-alist '("\\.pie$" . racket-mode))
  (add-to-list 'auto-mode-alist '("\\.rhm$" . racket-hash-lang-mode))
  (add-to-list 'auto-mode-alist '("\\.scrbl$" . racket-mode))
  :config
  (setopt racket-repl-buffer-name-function #'racket-repl-buffer-name-project)
  ;; (setq racket-program (executable-find "racket"))
  (put 'Π 'racket-indent-function 1)
  (put 'type-case 'racket-indent-function 2)
  (put 'new-slide-module 'racket-indent-function 1)
  (put 'required/typed 'racket-indent-function 1)
  (put 'term-let 'racket-indent-function 1))

                                        ; (use-package typescript-mode
;; :ensure t
;;   :ensure t
;;   :mode "\\.ts")

(use-package winner
  :ensure t
  :config
  (winner-mode t))

(use-package windmove
  :ensure t
  :config
  (windmove-mode t)
  (windmove-swap-states-default-keybindings '(shift control)))

(add-hook 'eshell-mode-hook (lambda () (setenv "TERM" "xterm-256color")))
(use-package eat
  :ensure t
  :after eshell
  :config
  (add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode))

(defun with-face (str &rest face-plist)
  (propertize str
              ;; 'read-only t
              'face face-plist))

(defun my/system-name ()
  (interactive)
  (if (getenv "CONTAINER_ID")
      (concat "⚙️ " (getenv "CONTAINER_ID"))
    (system-name)))

(defun my/eshell-prompt ()
  (concat
   ;; (with-face ""  :foreground "#2aa198")
   (with-face (user-login-name)  :foreground "#dc143c")
   (with-face "@"  :foreground "#2aa198")
   (with-face (my/system-name)  :foreground "#268bd2")
   (with-face "──["  :foreground "#2aa198")
   (with-face (format-time-string "%H:%M" (current-time))  :foreground "#b58900")
   (with-face "]──["  :foreground "#2aa198")
   (with-face (concat (eshell/pwd))  :foreground "#93a1a1")
   (with-face "]\n"  :foreground "#2aa198")
   (with-face "└─>"  :foreground "#2aa198")
   ;; (with-face (if venv-current-name (concat " (" venv-current-name ")")  "")  :foreground "#00dc00")
   (with-face (if (= (user-uid) 0) " #" " $")  :foreground "#2aa198")
   (with-face " ")))
;; (setq eshell-prompt-function 'shk-eshell-prompt)
;; enabling this variable gives us read-only prompts
(setopt eshell-highlight-prompt t)

(setopt eshell-prompt-function
        #'my/eshell-prompt)

;; (with-eval-after-load "esh-opt"
;;   (autoload 'epe-theme-lambda "eshell-prompt-extras")
;;   (setq eshell-highlight-prompt nil
;;         eshell-prompt-function 'epe-theme-lambda))
;; (hello world ice-cream)
;; ()
(use-package corfu
  :ensure t
  ;; :custom
  ;; (corfu-separator ?_) ;; Set to orderless separator, if not using space
  :bind (:map corfu-map ("SPC" . corfu-insert-separator)) ;; Configure SPC for separator insertion
  :init
  (global-corfu-mode))

(use-package cape
  :ensure t
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press M-<tab> ? to for help.
  :bind ("M-<tab>" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;; (add-hook 'completion-at-point-functions #'cape-history)
  ;; ...
)

(defconst org-journal-entry-template-name "daily-journal-template.org")
;; (define-key calendar-mode-map (kbd "j d") 'org-journal-display-entry)
;; (accessible-keymaps calendar-mode-map)
;; (with-output-to-temp-buffer "*Keymap Bindings*"
;;   (map-keymap
;;    (lambda (key binding)
;;      (princ (format "%s => %s\n" (key-description (vector key)) binding)))
;;    calendar-mode-map))
;; the keybindings prefixed with j do not work with meow, and I don't understand why.
(use-package org-journal
  :ensure t
  :init
  (setopt org-journal-file-type 'daily
          org-journal-file-header "#+title: %m/%d/%Y, No Title\n#+created: %Y-%m-%d\n"
          org-journal-date-prefix ""
          org-journal-date-format " "
          org-journal-time-format ""
          org-journal-dir (expand-file-name "journals" new-brain-dir)))

(defun new-entry-template ()
  (org-insert-heading-respect-content)
  (kill-whole-line)
  (insert-file-contents (expand-file-name org-journal-entry-template-name org-journal-dir)))

(use-package agda2-mode
  :mode "\\.agda\\'"
  :load-path (lambda () (let ((coding-system-for-read 'utf-8))
                          (file-name-directory (shell-command-to-string "agda-mode locate"))))
  :hook ((agda2-mode . electric-pair-local-mode))
  :config
  (unbind-key "C-c C-SPC" agda2-goal-map)
  (unbind-key "C-c C-SPC" agda2-mode-map)
  (bind-key "C-c C-v" 'agda2-give agda2-mode-map))

(use-package haskell-mode
  :ensure t
  :mode "\\.hs"
  :hook ((haskell-mode . interactive-haskell-mode)
         (haskell-mode . electric-pair-local-mode)))

;; (use-package activities
;;   :ensure t
;;   :init
;;   (activities-mode)
;;   (activities-tabs-mode)
;;   ;; Prevent `edebug' default bindings from interfering.
;;   (setq edebug-inhibit-emacs-lisp-mode-bindings t)

;;   :bind
;;   (("C-x C-a C-n" . activities-new)
;;    ("C-x C-a C-d" . activities-define)
;;    ("C-x C-a C-a" . activities-resume)
;;    ("C-x C-a C-s" . activities-suspend)
;;    ("C-x C-a C-k" . activities-kill)
;;    ("C-x C-a RET" . activities-switch)
;;    ("C-x C-b" . activities-switch-buffer)
;;    ("C-x C-a g" . activities-revert)
;;    ("C-x C-a l" . activities-list)))

(defun my/insert-debug-indent (start end)
  "Insert 'start_debug {}:' before region with matching indentation, then indent region right."
  (interactive "r")
  (save-excursion
    ;; Move to start and get current indentation
    (goto-char start)
    (beginning-of-line)
    (let* ((indent (buffer-substring (line-beginning-position)
                                     (progn (back-to-indentation) (point))))
           (debug-line (concat indent "start_debug {}:\n")))
      (goto-char start)
      (beginning-of-line)
      (insert debug-line)
      (let ((new-start (line-beginning-position))
            (new-end (+ end (length debug-line))))
        (indent-rigidly new-start new-end tab-width))))
  (search-backward "start_debug {")
  (forward-char (length "start_debug {")))

(use-package proof-general
  :ensure t)

(use-package jinx
  :ensure t
  :hook (emacs-startup . global-jinx-mode)
  :bind (("M-$" . jinx-correct)
         ("C-M-$" . jinx-languages)))

(defun start-tabspaces-mode ()
  (interactive)
  (tabspaces-mode)
  ;; I don't know where to put this:
  (let ((maybe-idx (tab-bar--tab-index-by-name "*tabspaces--placeholder*")))
    (when maybe-idx
      (tab-bar-close-tab (1+ maybe-idx)))))

(use-package tabspaces
  :ensure t
  :hook (after-init . start-tabspaces-mode)
  :config
  (with-eval-after-load 'consult
    ;; hide full buffer list (still available with "b" prefix)
    (consult-customize consult--source-buffer :hidden t :default nil)
    ;; set consult-workspace buffer list
    (defvar consult--source-workspace
      (list :name     "Workspace Buffers"
            :narrow   ?w
            :history  'buffer-name-history
            :category 'buffer
            :state    #'consult--buffer-state
            :default  t
            :items    (lambda () (consult--buffer-query
                                  :predicate #'tabspaces--local-buffer-p
                                  :sort 'visibility
                                  :as #'buffer-name)))

      "Set workspace buffer list for consult-buffer.")
    (add-to-list 'consult-buffer-sources 'consult--source-workspace))

  :commands (tabspaces-switch-or-create-workspace
             tabspaces-open-or-create-project-and-workspace)
  :init
  (setopt
   tabspaces-session-project-session-store 'project
   tabspaces-use-filtered-buffers-as-default t
   tabspaces-default-tab "Default"
   tabspaces-remove-to-default t
   tabspaces-include-buffers '("*scratch*" )
   ;; (tabspaces-initialize-project-with-todo t)
   ;; (tabspaces-todo-file-name "project-todo.org")
   ;; sessions
   tabspaces-session t
   ;; (tabspaces-session-auto-restore t)
   tab-bar-new-tab-choice "*scratch*"))


(defun my/increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0-9")
  (or (looking-at "[0-9]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

;; (global-set-key (kbd "C-c +") #'my/increment-number-at-point)
;; (defun my/get-all-tab-buffers (exception)
;;   (let* ((all-tabs (funcall tab-bar-tabs-function))
;;          (tab-buffers
;;           (cl-reduce
;;            (lambda (acc tab)
;;              (if (eq tab exception)
;;                  acc
;;                (seq-difference acc (activities-tabs--tab-parameter 'activities-buffer-list tab))))
;;            all-tabs)))
;;     tab-buffers))
;; (defun my/activities-tabs--kill-buffer ()
;;   "Kill buffers that are only in the current tab's buffer list.
;; Only does so when `activities-kill-buffers' is non-nil."
;;   (interactive)
;;   (let* ((current-tab (tab-bar--current-tab-find))
;;          (current-tab-bufs (activities-tabs--tab-parameter 'activities-buffer-list current-tab)))
;;     (cond
;;      ((null current-tab-bufs) (message "You can't kill the only buffer"))
;;      (t
;;       (let* ((current-tab-bufs (remove (current-buffer) current-tab-bufs)))
;;         (setf (alist-get 'activities-buffer-list current-tab) current-tab-bufs)
;;         ;; (message (apply #'concat (mapcar #'buffer-name (alist-get 'activities-buffer-list current-tab))))
;;         ;; (message (member (current-buffer) (my/get-all-tab-buffers)))
;;         ;; (message "hello")
;;         (if (member (current-buffer) (my/get-all-tab-buffers current-tab))
;;             (kill-buffer (current-buffer))
;;           ;; (message (buffer-name (car current-tab-bufs)))
;;           (switch-to-buffer (car (cl-remove-if-not #'buffer-live-p
;;                                                    current-tab-bufs)))))))))
  ;; (mapcar #'buffer-live-p current-tab-bufs))

  ;; (mapcar #'length (mapcar (lambda (tab)
  ;;                            (activities-tabs--tab-parameter 'activities-buffer-list tab))
  ;;                          (funcall tab-bar-tabs-function)))

;; (defun my/parse-headline (x)
;;   (plist-get (cadr x) :raw-value))

;; (defun my/get-headlines ()
;;   (org-element-map (org-element-parse-buffer) 'headline #'my/parse-headline))


;; (my/get-headlines)
;; (defun my/link-to-headline ()
;;   "Insert an internal link to a headline."
;;   (interactive)
;;   (let* ((headlines (my/get-headlines))
;; 	       (choice (completing-read "Headings: " headlines nil t))
;; 	       (desc (read-string "Description: " choice)))
;;     (org-insert-link buffer-file-name (concat "*" choice) desc)))

;; (use-package mistty
;;   :ensure t
;;   :bind (("C-c s" . mistty)

;;          ;; bind here the shortcuts you'd like the
;;          ;; shell to handle instead of Emacs.
;;          :map project-prefix-map
;;          ("m" . mistty-in-project)
;;          :map mistty-prompt-map

;;          ;; fish: directory history
;;          ("M-<up>" . mistty-send-key)
;;          ("M-<down>" . mistty-send-key)
;;          ("M-<left>" . mistty-send-key)
;;          ("M-<right>" . mistty-send-key)))

(use-package tempel
  :ensure t
  ;; Require trigger prefix before template name when completing.
  ;; :custom
  ;; (tempel-trigger-prefix "<")

  :bind (("M-+" . tempel-complete) ;; Alternative tempel-expand
         ("M-*" . tempel-insert))

  :init

  ;; Setup completion at point
  (defun tempel-setup-capf ()
    ;; Add the Tempel Capf to `completion-at-point-functions'.
    ;; `tempel-expand' only triggers on exact matches. Alternatively use
    ;; `tempel-complete' if you want to see all matches, but then you
    ;; should also configure `tempel-trigger-prefix', such that Tempel
    ;; does not trigger too often when you don't expect it. NOTE: We add
    ;; `tempel-expand' *before* the main programming mode Capf, such
    ;; that it will be tried first.
    (setq-local completion-at-point-functions
                (cons #'tempel-expand
                      completion-at-point-functions)))

  (add-hook 'conf-mode-hook 'tempel-setup-capf)
  (add-hook 'prog-mode-hook 'tempel-setup-capf)
  (add-hook 'text-mode-hook 'tempel-setup-capf)

  ;; Optionally make the Tempel templates available to Abbrev,
  ;; either locally or globally. `expand-abbrev' is bound to C-x '.
  ;; (add-hook 'prog-mode-hook #'tempel-abbrev-mode)
  ;; (global-tempel-abbrev-mode)
)
