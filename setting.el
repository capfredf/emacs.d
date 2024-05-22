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
 '(TeX-parse-self t)
 '(TeX-source-correlate-mode t)
 '(ag-highlight-search t)
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(beacon-color "#f2777a")
 '(browse-url-browser-function 'browse-url-default-browser)
 '(c-basic-offset 2)
 '(column-number-mode t)
 '(comint-scroll-show-maximum-output nil)
 '(compilation-scroll-output 'first-error)
 '(connection-local-criteria-alist
   '(((:application eshell)
      eshell-connection-default-profile)
     ((:application tramp :protocol "kubernetes")
      tramp-kubernetes-connection-local-default-profile)
     ((:application tramp :protocol "flatpak")
      tramp-container-connection-local-default-flatpak-profile tramp-flatpak-connection-local-default-profile)
     ((:application tramp)
      tramp-connection-local-default-system-profile tramp-connection-local-default-shell-profile)))
 '(connection-local-profile-alist
   '((eshell-connection-default-profile
      (eshell-path-env-list))
     (tramp-flatpak-connection-local-default-profile
      (tramp-remote-path "/app/bin" tramp-default-remote-path "/bin" "/usr/bin" "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin" "/opt/bin" "/opt/sbin" "/opt/local/bin"))
     (tramp-kubernetes-connection-local-default-profile
      (tramp-config-check . tramp-kubernetes--current-context-data)
      (tramp-extra-expand-args 97
                               (tramp-kubernetes--container
                                (car tramp-current-connection))
                               104
                               (tramp-kubernetes--pod
                                (car tramp-current-connection))
                               120
                               (tramp-kubernetes--context-namespace
                                (car tramp-current-connection))))
     (tramp-container-connection-local-default-flatpak-profile
      (tramp-remote-path "/app/bin" tramp-default-remote-path "/bin" "/usr/bin" "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin" "/opt/bin" "/opt/sbin" "/opt/local/bin"))
     (tramp-connection-local-darwin-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,uid,user,gid,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state=abcde" "-o" "ppid,pgid,sess,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etime,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . tramp-ps-time)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-busybox-ps-profile
      (tramp-process-attributes-ps-args "-o" "pid,user,group,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "stat=abcde" "-o" "ppid,pgid,tty,time,nice,etime,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (user . string)
       (group . string)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (ttname . string)
       (time . tramp-ps-time)
       (nice . number)
       (etime . tramp-ps-time)
       (args)))
     (tramp-connection-local-bsd-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,euid,user,egid,egroup,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state,ppid,pgid,sid,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etimes,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (group . string)
       (comm . 52)
       (state . string)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . number)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-default-shell-profile
      (shell-file-name . "/bin/sh")
      (shell-command-switch . "-c"))
     (tramp-connection-local-default-system-profile
      (path-separator . ":")
      (null-device . "/dev/null"))))
 '(cursor-type 'bar)
 '(custom-safe-themes
   '("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default))
 '(delete-selection-mode t)
 '(desktop-auto-save-timeout 0)
 '(desktop-restore-eager 10)
 '(desktop-save-mode t)
 '(dired-hide-details-hide-information-lines t)
 '(enable-recursive-minibuffers t)
 '(eshell-visual-commands
   '("vi" "vim" "screen" "tmux" "top" "htop" "less" "more" "lynx" "links" "ncftp" "mutt" "pine" "tin" "trn" "elm" "racket"))
 '(fill-column 80)
 '(flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
 '(frame-background-mode nil)
 '(grep-highlight-matches 'always)
 '(helm-move-to-line-cycle-in-source nil)
 '(helm-split-window-inside-p t)
 '(help-at-pt-display-when-idle 'never nil (help-at-pt))
 '(highlight-parentheses-colors '("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900"))
 '(ispell-program-name "hunspell")
 '(js-indent-level 2)
 '(lua-indent-level 2)
 '(magit-branch-adjust-remote-upstream-alist '(("upstream/master" . "fix-.*")))
 '(markdown-enable-math t)
 '(menu-bar-mode nil)
 '(olivetti-body-width 120)
 '(org-agenda-dim-blocked-tasks 'invisible)
 '(org-babel-load-languages '((emacs-lisp . t)))
 '(org-capture-templates
   '(("T" "Today's tasks" entry
      (file+headline "~/my-brain/snd-brain.org" "Today")
      "")))
 '(org-catch-invisible-edits 'smart)
 '(org-enforce-todo-dependencies t)
 '(org-fold-catch-invisible-edits 'smart)
 '(org-fontify-todo-headline nil)
 '(org-format-latex-options
   '(:foreground default :background default :scale 0.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-goto-interface 'outline-path-completion)
 '(org-hide-emphasis-markers nil)
 '(org-id-link-to-org-use-id t)
 '(org-log-into-drawer t)
 '(org-loop-over-headlines-in-active-region t)
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-doi ol-eww ol-gnus org-id ol-info ol-irc ol-mhe ol-rmail org-tempo ol-w3m))
 '(org-refile-targets
   '((nil :maxlevel . 10)
     (org-agenda-files :maxlevel . 3)
     ("/home/capfredf/my-brain/Research/Occurrence Typing X SimpleSub/Occurrence Typing X SimpleSub.org" :maxlevel . 3)))
 '(org-refile-use-outline-path 'title)
 '(org-roam-directory "~/brain/")
 '(org-roam-graph-viewer "~/bin/firefox")
 '(org-startup-folded nil)
 '(org-tags-column 0)
 '(org-todo-keyword-faces
   '(("WIP" . "(:foreground \"orange\" :weight bold :underline t)")
     ("TODO" :foreground "gray" :weight bold :underline t)))
 '(org-todo-keywords
   '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|" "CANCELLED(c)" "DONE(d)")))
 '(org-use-fast-todo-selection 'expert)
 '(package-selected-packages
   '(clojure-mode elixir-mode fish-mode lua-mode org-ql embark-consult marginalia consult embark orderless eat helm-core wfnames helm helm-org-rifle denote markdown-mode typescript-mode auctex racket-mode olivetti org-superstar org-nsuperstar ws-butler org-super-agenda paredit ob-racket racket-unicode-input-method vertico olc wgrep-ag diredfl exec-path-from-shell yaml-mode perspective centaur-tabs rotate python-mode yasnippet which-key wgrep visual-fill-column use-package-ensure-system-package solarized-theme rust-mode projectile popup pdf-tools parsebib ox-reveal org-roam org-journal multiple-cursors moody magit key-chord iy-go-to-char hydra htmlize highlight-parentheses haskell-mode goto-chg flycheck eyebrowse expand-region diff-hl deft biblio benchmark-init ag ace-window))
 '(project-switch-commands
   '((project-find-file "Find file" nil)
     (project-find-regexp "Find regexp" nil)
     (project-find-dir "Find directory" nil)
     (project-vc-dir "VC-Dir" nil)
     (project-eshell "Eshell" nil)
     (magit-project-status "Magit" 109)))
 '(reftex-plug-into-AUCTeX t)
 '(repeat-mode t)
 '(safe-local-variable-values
   '((eval racket-unicode-input-method-enable)
     (TeX-engine . xelatex)
     (olivetti-body-width . 150)))
 '(shift-select-mode nil)
 '(tab-bar-mode t)
 '(tab-width 2)
 '(temporary-file-directory "~/tmp/")
 '(tool-bar-mode nil)
 '(vterm-shell "fish")
 '(warning-suppress-types '((comp)))
 '(windmove-default-keybindings nil)
 '(window-divider-mode nil)
 '(xref-search-program 'ripgrep)
 '(yas-snippet-dirs '("/home/capfredf/.emacs.d/snippets")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#fdf6e3" :foreground "#657b83" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 120 :width normal :foundry "ADBO" :family "Iosevka"))))
 '(fixed-pitch ((t (:family "Iosevka" :slant normal :weight normal :height 1.0 :width normal))))
 '(font-lock-variable-name-face ((t nil)))
 '(helm-ff-file-extension ((t (:extend t :foreground "dark red"))))
 '(highlight ((t nil)))
 '(match ((t (:background "orange" :foreground "#586e75" :weight bold))))
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit fixed-pitch :foreground "#93a1a1"))))
 '(org-document-title ((t (:family "Source Han Sans SC" :height 1.5 :underline nil))))
 '(org-done ((t (:foreground "dim gray" :strike-through t))))
 '(org-drawer ((t (:foreground "#2aa198" :height 0.8))))
 '(org-headline-done ((t (:foreground "dim gray" :strike-through t))))
 '(org-headline-todo ((t (:foreground "Red4"))))
 '(org-level-1 ((t (:inherit nil :extend nil :foreground "#657b83" :height 1.0))))
 '(org-level-2 ((t (:inherit org-level-1 :extend nil :foreground "#657b83" :height 1.0))))
 '(org-level-3 ((t (:inherit org-level-2 :extend nil :foreground "#657b83" :height 1.0))))
 '(org-level-4 ((t (:inherit org-level-3 :extend nil :foreground "#657b83" :height 1.0))))
 '(org-level-5 ((t (:inherit org-level-4 :extend nil :foreground "#657b83"))))
 '(org-level-6 ((t (:inherit org-level-5 :extend nil :foreground "#657b83"))))
 '(org-level-7 ((t (:inherit org-level-1 :extend nil :foreground "#657b83"))))
 '(org-level-8 ((t (:inherit org-level-1 :extend nil :foreground "#657b83" :height 1.0))))
 '(org-meta-line ((t (:inherit font-lock-comment-face :slant normal))))
 '(org-property-value ((t (:inherit default :height 0.8))))
 '(org-special-keyword ((t (:foreground "#93a1a1" :weight bold :height 0.8))))
 '(org-tag ((t (:foreground "light gray" :weight bold))))
 '(region ((((class color) (min-colors 89)) (:extend t :foreground "#fdf6e3" :background "#586e75"))))
 '(tab-bar-tab ((t (:background "#fdf6e3" :foreground "#586e75" :underline (:color foreground-color :style line :position t)))))
 '(tooltip ((t nil)))
 '(variable-pitch ((t (:weight normal :height 1.0 :family "Noto Sans SC")))))
