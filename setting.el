(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "lualatex -shell-escape")
 '(TeX-command-extra-options "-shell-escape")
 '(TeX-electric-escape nil)
 '(TeX-electric-math '("$" . "$"))
 '(TeX-engine 'luatex)
 '(comint-scroll-show-maximum-output nil)
 '(compilation-scroll-output 'first-error)
 '(custom-enabled-themes '(sanityinc-tomorrow-day))
 '(custom-safe-themes
   '("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default))
 '(desktop-auto-save-timeout 0)
 '(dired-hide-details-hide-information-lines t)
 '(olivetti-body-width 120)
 '(org-agenda-custom-commands '(("h" "HotList" tags-todo "+Focused" nil)))
 '(org-agenda-dim-blocked-tasks 'invisible)
 '(org-agenda-files '("~/brain/main.org"))
 '(org-catch-invisible-edits 'smart)
 '(org-enforce-todo-dependencies t)
 '(org-id-link-to-org-use-id t)
 '(org-log-into-drawer t)
 '(org-loop-over-headlines-in-active-region t)
 '(org-roam-directory "/Users/capfredf/brain/")
 '(org-roam-graph-viewer "~/bin/firefox")
 '(org-startup-folded nil)
 '(org-tags-column -110)
 '(org-todo-keyword-faces '(("WIP" . "orange") ("TODO" . "gray")))
 '(org-use-fast-todo-selection 'expert)
 '(package-selected-packages
   '(diredfl exec-path-from-shell yaml-mode perspective centaur-tabs smartparens rotate olivetti python-mode yasnippet which-key wgrep visual-fill-column use-package-ensure-system-package typescript-mode solarized-theme rust-mode racket-mode projectile popup pdf-tools parsebib paredit ox-reveal org-super-agenda org-roam org-journal org-bullets multiple-cursors moody markdown-mode magit key-chord iy-go-to-char hydra htmlize highlight-parentheses haskell-mode goto-chg flycheck eyebrowse expand-region diff-hl deft counsel biblio benchmark-init beacon auctex ag ace-window))
 '(safe-local-variable-values '((olivetti-body-width . 150))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fixed-pitch ((t (:family "Iosevka" :slant normal :weight normal :height 1.0 :width normal))))
 '(font-lock-variable-name-face ((t nil)))
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-code ((t (:background "#EEEEEE" :foreground "#535353"))))
 '(org-document-title ((t (:family "Source Han Sans SC" :height 1.5 :underline nil))))
 '(org-done ((t (:foreground "dim gray" :strike-through t))))
 '(org-headline-done ((t (:foreground "dim gray" :strike-through t))))
 '(org-level-4 ((t (:inherit outline-4 :foreground "#0e0e0e"))))
 '(org-meta-line ((t (:inherit font-lock-comment-face :slant normal))))
 '(variable-pitch ((t (:family "Source Han Sans" :height 160 :weight normal)))))
