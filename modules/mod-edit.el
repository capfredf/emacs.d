;; -*- lexical-binding: t -*-
(put 'upcase-region 'disabled nil)


;; (defconst my-cc-style
;;   '(c-offsets-alist . ((innamespace . 0))))

;; (c-add-style "my-cc-mode" my-cc-style t)

(defun my-c++-mode-hook ()
  (c-set-offset 'innamespace 0))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

(setq cc-search-directories
      '("." "../../../lib/*"
        "../../include/clang/*"
        "../../include/llvm/*"))

(defun refile-targets ()
  (interactive)
  (message "hello")
  (list
   (expand-file-name "/home/capfredf/my-brain/Research/Occurrence Typing X SimpleSub/Occurrence Typing X SimpleSub.org")))

(global-set-key (kbd "s-f") 'ff-find-other-file)

(add-hook 'c++-mode-hook 'eglot-ensure)

(defun compile-dwim ()
  (interactive)
  (if (file-exists-p (concat default-directory "Makefile"))
      (call-interactively 'compile)
    (call-interactively 'project-compile)))

(global-set-key (kbd "C-c c") 'compile-dwim)


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

(defun next-student ()
  (interactive)
  (buffer-name)
  (let* ((dir (directory-file-name default-directory))
         (parent-dir (concat default-directory ".."))
         (rel-name (file-relative-name dir (directory-file-name parent-dir)))
         (all-fns (directory-files parent-dir))
         (idx (cl-position rel-name
                           all-fns
                           :test 'equal)))
    (find-file (concat parent-dir "/" (nth (+ 1 idx) all-fns)))))

(global-set-key (kbd "C-c C-S-n") 'next-student)


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

;; (add-hook 'before-save-hook 'delete-trailing-whitespace)

;; (use-package swiper
;;   :ensure t
;;   :bind
;;   (("C-s" . swiper-isearch)))




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

(defvar vterm-sys-frame nil)
(require 'cl-lib)
(defun vterm-sys ()
  (interactive)
  ;; (select-frame-set-input-focus vterm-sys-frame)
  (tab-bar-select-tab-by-name "sys")
  (vterm-dwim "~" t))

(defun vterm-dwim (&optional dir reuse?)
  (interactive)
  ;; if dir is not set, we check if we are under a project
  (cl-multiple-value-bind (dir^ buff-base)
      (cond
       (dir (cl-values (if (and (stringp dir) (file-directory-p dir))
                           dir
                         "~")
                       "vterm"))
       ((project-current)
        (let* ((prj-name (project-root (project-current t)))
               (base-name (format "vterm %s" prj-name)))
          (cl-values prj-name base-name)))
       (t (cl-values default-directory "vterm") ))

    (let ((default-directory dir^))
      (if (and reuse? (buffer-live-p (get-buffer buff-base)))
          (switch-to-buffer buff-base)
        (vterm buff-base)))))


(global-set-key (kbd "C-M-]") 'jump-to-file-and-line)
;; (global-set-key (kbd "<f4>") 'vterm-dwim)

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

;; (add-hook 'prog-mode-hook (lambda () (hl-line-mode 1)))



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

(defun create-new-notes ()
  (interactive)
  (let* ((title (read-string "Title: "))
         (date (format-time-string "%Y-%m-%d"))
         (name (downcase (string-replace " " "-" title)))
         (dir default-directory))
    (find-file (file-name-concat dir (concat date (concat "--" (concat name ".org")))))
    (insert (concat "#+title: " title))
    (newline)
    (insert (concat "#+date: " date))
    (newline)))





;; (use-package org-journal
;;   :ensure t
;;   :init
;;   (require 'org) ;; not the idomatic way to load the org package
;;   :custom
;;   (org-journal-dir "~/brain/journal/")
;;   (org-journal-file-format "%Y%m%d.jnl")
;;   :bind ("C-c C-k" . org-journal-new-entry))

;; Tex


;; (use-package deft
;;   :bind ("<f8>" . deft)
;;   :custom
;;   (deft-directory "~/brain/")
;;   (deft-auto-save-interval 0)
;;   (deft-extensions '("org" "md" "txt" "tex")))


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

(setq-default indent-tabs-mode nil)

(defun insert-today (arg)
  (interactive "P")
  (insert (format-time-string "%D")))

(defun new-note-entry (title)
  (interactive "sGive me a title:")
  (let* ((ctitle (s-replace " " "_" (downcase title)))
         (fn (format "%s--%s.org" (format-time-string "%Y%m-%dT%H:%M:%S.%3N") ctitle)))
    (find-file fn)
    (insert "#+title: " title)))

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



;; (setq shell-file-name "bash")

(setq comint-prompt-read-only t)

(defun plt-tr-contracts-toggle ()
  (interactive)
  (setenv "PLT_TR_CONTRACTS" (if (getenv "PLT_TR_CONTRACTS") nil
                               "1"))
  (message "PLT_TR_CONTRACTS is now %s" (getenv "PLT_TR_CONTRACTS")))


(defun buffer-name-with-point-info ()
  (interactive)
  (let ((s (format "%s:%d" (buffer-name) (line-number-at-pos))))
    (kill-new s)
    (message "%s COPIED" s)))

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
