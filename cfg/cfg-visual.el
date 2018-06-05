;; (use-package solarized-theme
;;   :ensure t
;;   :init
;;   (setq solarized-high-contrast-mode-line t)
;;   :config
;;   (custom-set-faces
;;     '(mode-line ((t
;;     (:underline nil :overline nil :box
;;                 (:line-width 1 :color "#0e2a34")
;;                 ))))
;;     )
;;   (load-theme 'solarized-dark t))
;; (use-package doom-themes
;;   :ensure t
;;   :init
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t)
;;   :config
;;   (load-theme 'doom-one t))
(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (load-theme 'sanityinc-tomorrow-night t))

(tool-bar-mode -1)
(add-to-list 'default-frame-alist
             '(vertical-scroll-bars . nil))
(setq-default redisplay-dont-pause t)
(setq-default cursor-type 'bar)
(set-face-attribute 'default nil :height 140 :foundry "nil" :family "Iosevka")
;; (setq frame-title-format '("" "%b @ Emacs " emacs-version))
(setq-default frame-title-format (list "%b - " (getenv "USER") "@" (getenv "HOSTNAME")))


;; (use-package auto-dim-other-buffers
;;   :ensure t
;;   :config (auto-dim-other-buffers-mode t))

;; (use-package smart-mode-line
;;   :ensure t
;;   :config
;;   (use-package smart-mode-line-powerline-theme
;; 	:ensure t
;; 	:config
;; 	(setq sml/theme 'respectful)
;; 	(sml/setup)))

(use-package telephone-line
  :ensure t
  :config
  (setq telephone-line-lhs
      '((accent . (telephone-line-vc-segment
                   telephone-line-process-segment))
        (nil    . (telephone-line-buffer-segment))))
  (setq solarized-high-contrast-mode-line t)
  (setq telephone-line-primary-left-separator 'telephone-line-cubed-left
      telephone-line-secondary-left-separator 'telephone-line-cubed-hollow-left
      telephone-line-primary-right-separator 'telephone-line-cubed-right
      telephone-line-secondary-right-separator 'telephone-line-cubed-hollow-right)
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

(provide 'cfg-visual)
