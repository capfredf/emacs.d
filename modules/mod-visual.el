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
  ;; darken the background color a little bit when applying tomorrow-day
  (when (equal theme-id 'sanityinc-tomorrow-day)
    (set-face-attribute 'default nil :background "#fafafa"))

  ;; config for moody
  (let ((line (face-attribute 'mode-line :underline)))
    (set-face-attribute 'mode-line          nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :underline  line)
    (set-face-attribute 'mode-line          nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :box        nil)))

(advice-add 'load-theme :after #'load-theme-after)

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (load-theme 'sanityinc-tomorrow-day t))

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


(global-set-key (kbd "<f3>") nil)
(global-set-key (kbd "<f3> i") 'text-scale-increase)
(global-set-key (kbd "<f3> r") (lambda () (interactive) (text-scale-adjust 0)))
(global-set-key (kbd "<f3> o") 'text-scale-decrease)

(provide 'mod-visual)
