(load-theme 'solarized-dark t)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(setq redisplay-dont-pause t)
(setq-default cursor-type 'bar)

(use-package highlight-parentheses
  :ensure t
  :config (highlight-parentheses-mode t))

(provide 'cfg-visual)
