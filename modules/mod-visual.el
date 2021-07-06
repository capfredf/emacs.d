(defun switch-theme (theme)
  ;; This interactive call is taken from `load-theme'
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
                             (mapcar 'symbol-name
                                     (custom-available-themes))))))
  (mapcar #'disable-theme custom-enabled-themes)
  (load-theme theme t))

(defun load-theme-after (theme-id &rest arg)
  ;; config for moody
  (let ((line (face-attribute 'mode-line :underline)))
    (set-face-attribute 'mode-line          nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :underline  line)
    (set-face-attribute 'mode-line          nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :box        nil)))

(advice-add 'load-theme :after #'load-theme-after)

;; (use-package color-theme-sanityinc-tomorrow
;;   :load-path "site-lisp/color-theme-sanityinc-tomorrow"
;;   :config
;;   (switch-theme 'sanityinc-tomorrow-eighties))

(use-package solarized-theme
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


(global-hl-line-mode t)

;; double tap in the minibuffer move point to the beginning of the minibuffer
;; enable when #29 is closed
;; (use-package moody
;;   :ensure t
;;   :config
;;   (setq x-underline-at-descent-line t)
;;   (moody-replace-mode-line-buffer-identification)
;;   (moody-replace-vc-mode))


(setq-default fill-column 80)
(tool-bar-mode -1)
(add-to-list 'default-frame-alist
             '(vertical-scroll-bars . nil))
(setq-default cursor-type 'bar)
(set-face-attribute 'default nil :height 160 :foundry "nil" :family "Sarasa Fixed SC")

(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "Source Han Sans" :height 160 :weight normal))))
 '(fixed-pitch ((t ( :family "Sarasa Fixed SC" :slant normal :weight normal :height 1.0 :width normal)))))


(defun ff-get-current-tab-name ()
  (let* ((tabs (funcall tab-bar-tabs-function))
         (tab-index (tab-bar--current-tab-index tabs))
         (tab-to-rename (nth tab-index tabs)))
    (alist-get 'name tab-to-rename)))

(setq-default frame-title-format '("%b" (:eval (if tab-bar-mode
                                                   (format "[%s]" (ff-get-current-tab-name)) ""))
                                   " - "(getenv "USER") "@" (getenv "HOSTNAME")))


(use-package highlight-parentheses
  :ensure t
  :init
  (add-hook 'racket-mode-hook (lambda () (highlight-parentheses-mode t)))
  (add-hook 'emacs-lisp-mode-hook (lambda () (highlight-parentheses-mode t))))

;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;   (set-fontset-font (frame-parameter nil 'font)
;;                     charset
;;                     (font-spec :family "Source Han Sans")))


;; (defadvice text-scale-increase (around all-buffers (arg) activate)
;;   ad-do-it)

(defun text-scale-increase-for-all ()
  "Increase font size for all buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      (text-scale-increase 1))))

(defun text-scale-decrease-for-all ()
  "Decrease font size for all buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      (text-scale-decrease 1))))

(defun text-scale-reset-for-all ()
  "Reset to the default font size for all buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      (text-scale-adjust 0))))

(defvar text-scaling-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "i") 'text-scale-increase-for-all)
    (define-key map (kbd "r") 'text-scale-reset-for-all)
    (define-key map (kbd "o") 'text-scale-decrease-for-all)
    map))

(defun scale-text ()
  "Start the text scaling mode."
  (interactive)
  (set-transient-map text-scaling-map t))

(require 'which-key)
(add-to-list 'which-key-show-transient-maps text-scaling-map)

(global-set-key (kbd "<f3>") 'scale-text)

(provide 'mod-visual)
;; mod-visual.el ends here
