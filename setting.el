(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-auto-save t)
 '(TeX-command-extra-options "-shell-escape")
 '(TeX-electric-escape nil)
 '(TeX-electric-math '("$" . "$"))
 '(TeX-engine 'luatex)
 '(TeX-master nil)
 '(TeX-source-correlate-mode t)
 '(ag-highlight-search t)
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(beacon-color "#f2777a")
 '(browse-url-browser-function 'browse-url-default-browser)
 '(column-number-mode t)
 '(comint-scroll-show-maximum-output nil)
 '(compilation-scroll-output 'first-error)
 '(completion-styles '(substring partial-completion))
 '(custom-safe-themes
   '("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default))
 '(desktop-auto-save-timeout 0)
 '(dired-hide-details-hide-information-lines t)
 '(flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
 '(frame-background-mode nil)
 '(grep-highlight-matches 'always)
 '(help-at-pt-display-when-idle 'never nil (help-at-pt))
 '(highlight-parentheses-colors '("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900"))
 '(magit-branch-adjust-remote-upstream-alist '(("upstream/master" . "fix-.*")))
 '(menu-bar-mode nil)
 '(olivetti-body-width 120)
 '(org-agenda-custom-commands '(("h" "HotList" tags-todo "+Focused" nil)))
 '(org-agenda-dim-blocked-tasks 'invisible)
 '(org-agenda-files
   '("/home/capfredf/brain/deep-hours.org" "/home/capfredf/brain/main.org"))
 '(org-capture-templates
   '(("e" "everything" entry
      (file+headline "~/brain/main.org" "📥 Super Inbox")
      "* %?\12Entered on %U\12  %i")))
 '(org-catch-invisible-edits 'smart)
 '(org-enforce-todo-dependencies t)
 '(org-format-latex-options
   '(:foreground default :background default :scale 0.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-hide-emphasis-markers nil)
 '(org-id-link-to-org-use-id t)
 '(org-log-into-drawer t)
 '(org-loop-over-headlines-in-active-region t)
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-doi ol-eww ol-gnus ol-info ol-irc ol-mhe ol-rmail org-tempo ol-w3m))
 '(org-preview-latex-default-process 'dvisvgm nil nil "Customized with use-package org")
 '(org-roam-directory "~/brain/")
 '(org-roam-graph-viewer "~/bin/firefox")
 '(org-startup-folded nil)
 '(org-tags-column 0)
 '(org-todo-keyword-faces '(("WIP" . "orange") ("TODO" . "gray")))
 '(org-use-fast-todo-selection 'expert)
 '(package-selected-packages
   '(paredit vertico olc wgrep-ag diredfl exec-path-from-shell yaml-mode perspective centaur-tabs rotate olivetti python-mode yasnippet which-key wgrep visual-fill-column use-package-ensure-system-package typescript-mode solarized-theme rust-mode projectile popup pdf-tools parsebib ox-reveal org-super-agenda org-roam org-journal org-bullets multiple-cursors moody markdown-mode magit key-chord iy-go-to-char hydra htmlize highlight-parentheses haskell-mode goto-chg flycheck eyebrowse expand-region diff-hl deft biblio benchmark-init auctex ag ace-window))
 '(reftex-plug-into-AUCTeX t)
 '(safe-local-variable-values '((TeX-engine . xelatex) (olivetti-body-width . 150)))
 '(shift-select-mode nil)
 '(tab-bar-mode t)
 '(warning-suppress-types '((comp)))
 '(windmove-default-keybindings nil)
 '(window-divider-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Sarasa Fixed SC" :slant normal :weight normal :height 120 :width normal))))
 '(fixed-pitch ((t (:family "Iosevka" :slant normal :weight normal :height 1.0 :width normal))))
 '(font-lock-variable-name-face ((t nil)))
 '(highlight ((t nil)))
 '(match ((t (:background "orange" :foreground "#586e75" :weight bold))))
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit nil :foreground "#93a1a1"))))
 '(org-document-title ((t (:family "Source Han Sans SC" :height 1.5 :underline nil))))
 '(org-done ((t (:foreground "dim gray" :strike-through t))))
 '(org-headline-done ((t (:foreground "dim gray" :strike-through t))))
 '(org-level-1 ((t (:height 1))))
 '(org-level-2 ((t (:height 1))))
 '(org-level-3 ((t (:height 1))))
 '(org-level-4 ((t (:inherit outline-4 :foreground "#0e0e0e"))))
 '(org-level-5 ((t (:height 1))))
 '(org-level-6 ((t (:height 1))))
 '(org-level-7 ((t (:height 1))))
 '(org-level-8 ((t (:height 1))))
 '(org-meta-line ((t (:inherit font-lock-comment-face :slant normal))))
 '(region ((((class color) (min-colors 89)) (:extend t :foreground "#fdf6e3" :background "#586e75"))))
 '(tooltip ((t nil)))
 '(variable-pitch ((t (:family "Source Han Sans" :height 160 :weight normal)))))
