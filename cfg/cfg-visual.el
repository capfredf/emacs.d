;; (use-package material-theme
;;   :ensure t
;;   :config (load-theme 'material-light t))

;; (use-package solarized-theme
;;   :ensure t
;;   :config (load-theme 'solarized-dark t))

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config (color-theme-sanityinc-tomorrow-bright))

;; (use-package base16-theme
;;   :ensure t
;;   :config (load-theme 'base16-solarized-dark))

(tool-bar-mode -1)
(toggle-scroll-bar -1)
(setq redisplay-dont-pause t)
(setq-default cursor-type 'bar)

(use-package highlight-parentheses
  :ensure t
  :config (highlight-parentheses-mode t))

(use-package auto-dim-other-buffers
  :ensure t
  :config (auto-dim-other-buffers-mode t))

;; (set-frame-font "Input Mono Condensed-13" nil t)
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "Source Han Sans" :size 13)))

(provide 'cfg-visual)
