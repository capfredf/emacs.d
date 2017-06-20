(load-theme 'solarized-dark t)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(setq redisplay-dont-pause t)
(setq-default cursor-type 'bar)

(use-package highlight-parentheses
  :ensure t
  :config (highlight-parentheses-mode t))

(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "Source Han Sans HW SC" :size 13)))

(provide 'cfg-visual)
