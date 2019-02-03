(defun switch-theme (theme)
  ;; This interactive call is taken from `load-theme'
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
                             (mapcar 'symbol-name
                                     (custom-available-themes))))))
  (mapcar #'disable-theme custom-enabled-themes)
  (load-theme theme t))

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (load-theme 'sanityinc-tomorrow-day t))


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


(use-package telephone-line
  :ensure t
  :config
  (setq telephone-line-lhs
      '((accent . (telephone-line-vc-segment
                   telephone-line-process-segment))
        (nil    . (telephone-line-buffer-segment))))
  (setq telephone-line-primary-left-separator 'telephone-line-flat
        telephone-line-secondary-left-separator 'telephone-line-flat
        telephone-line-primary-right-separator 'telephone-line-flat
        telephone-line-height 20
        telephone-line-secondary-right-separator 'telephone-line-flat)
  (telephone-line-mode 1))

(use-package highlight-parentheses
  :ensure t
  :init
  (add-hook 'racket-mode-hook (lambda () (highlight-parentheses-mode t)))
  (add-hook 'emacs-lisp-mode-hook (lambda () (highlight-parentheses-mode t))))

(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "Source Han Sans")))

(defhydra hydra-zoom (:color red)
  "zoom"
  ("i" text-scale-increase "in")
  ("r" (text-scale-adjust 0) "reset")
  ("o" text-scale-decrease "out"))

(global-set-key (kbd "<f3>") 'hydra-zoom/body)

(provide 'mod-visual)
