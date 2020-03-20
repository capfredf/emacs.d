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

(use-package color-theme-sanityinc-tomorrow
  :load-path "site-lisp/color-theme-sanityinc-tomorrow"
  :config
  (load-theme 'sanityinc-tomorrow-day t))

(use-package beacon
  :ensure t
  :config
  (beacon-mode t))
(use-package moody
  :ensure t
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))


(setq-default fill-column 80)
(tool-bar-mode -1)
(add-to-list 'default-frame-alist
             '(vertical-scroll-bars . nil))
(setq-default redisplay-dont-pause t)
(setq-default cursor-type 'bar)
(set-face-attribute 'default nil :height 140 :foundry "nil" :family "Iosevka")

(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "Source Han Sans" :height 160 :weight normal))))
 '(fixed-pitch ((t ( :family "Iosevka" :slant normal :weight normal :height 1.0 :width normal)))))

(setq-default frame-title-format (list "%b - " (getenv "USER") "@" (getenv "HOSTNAME")))

(use-package highlight-parentheses
  :ensure t
  :init
  (add-hook 'racket-mode-hook (lambda () (highlight-parentheses-mode t)))
  (add-hook 'emacs-lisp-mode-hook (lambda () (highlight-parentheses-mode t))))

(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "Source Han Sans")))


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
;;; mod-visual.el ends here
