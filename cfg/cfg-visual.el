(use-package solarized-theme
  :ensure t
  :config (load-theme 'solarized-dark))

(tool-bar-mode -1)
(toggle-scroll-bar -1)
(setq redisplay-dont-pause t)
(setq-default cursor-type 'bar)

;; (setq frame-title-format '("" "%b @ Emacs " emacs-version))
(setq frame-title-format (list "%b - " (getenv "USER") "@" (getenv "HOSTNAME")))
(use-package highlight-parentheses
  :ensure t
  :config (highlight-parentheses-mode t))

;; (use-package auto-dim-other-buffers
;;   :ensure t
;;   :config (auto-dim-other-buffers-mode t))

(use-package smart-mode-line
  :ensure t
  :config
  (use-package smart-mode-line-powerline-theme
	:ensure t
	:config
	(setq sml/theme 'powerline)
	(sml/setup)))


(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "Source Han Sans" :size 13)))

(setq org-src-fontify-natively t)

(provide 'cfg-visual)
