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
 '(calendar-week-start-day 1)
 '(column-number-mode t)
 '(comint-scroll-show-maximum-output nil)
 '(compilation-scroll-output 'first-error)
 '(connection-local-criteria-alist
   '(((:application eshell) eshell-connection-default-profile)
     ((:application tramp :protocol "kubernetes")
      tramp-kubernetes-connection-local-default-profile)
     ((:application tramp :protocol "flatpak")
      tramp-container-connection-local-default-flatpak-profile
      tramp-flatpak-connection-local-default-profile)
     ((:application tramp) tramp-connection-local-default-system-profile
      tramp-connection-local-default-shell-profile)))
 '(connection-local-profile-alist
   '((eshell-connection-default-profile (eshell-path-env-list))
     (tramp-flatpak-connection-local-default-profile
      (tramp-remote-path "/app/bin" tramp-default-remote-path "/bin" "/usr/bin"
                         "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin"
                         "/local/bin" "/local/freeware/bin" "/local/gnu/bin"
                         "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin"
                         "/opt/bin" "/opt/sbin" "/opt/local/bin"))
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
      (tramp-remote-path "/app/bin" tramp-default-remote-path "/bin" "/usr/bin"
                         "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin"
                         "/local/bin" "/local/freeware/bin" "/local/gnu/bin"
                         "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin"
                         "/opt/bin" "/opt/sbin" "/opt/local/bin"))
     (tramp-connection-local-darwin-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o"
                                        "pid,uid,user,gid,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                        "-o" "state=abcde" "-o"
                                        "ppid,pgid,sess,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etime,pcpu,pmem,args")
      (tramp-process-attributes-ps-format (pid . number) (euid . number)
                                          (user . string) (egid . number)
                                          (comm . 52) (state . 5)
                                          (ppid . number) (pgrp . number)
                                          (sess . number) (ttname . string)
                                          (tpgid . number) (minflt . number)
                                          (majflt . number)
                                          (time . tramp-ps-time) (pri . number)
                                          (nice . number) (vsize . number)
                                          (rss . number) (etime . tramp-ps-time)
                                          (pcpu . number) (pmem . number) (args)))
     (tramp-connection-local-busybox-ps-profile
      (tramp-process-attributes-ps-args "-o"
                                        "pid,user,group,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                        "-o" "stat=abcde" "-o"
                                        "ppid,pgid,tty,time,nice,etime,args")
      (tramp-process-attributes-ps-format (pid . number) (user . string)
                                          (group . string) (comm . 52)
                                          (state . 5) (ppid . number)
                                          (pgrp . number) (ttname . string)
                                          (time . tramp-ps-time) (nice . number)
                                          (etime . tramp-ps-time) (args)))
     (tramp-connection-local-bsd-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o"
                                        "pid,euid,user,egid,egroup,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                        "-o"
                                        "state,ppid,pgid,sid,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etimes,pcpu,pmem,args")
      (tramp-process-attributes-ps-format (pid . number) (euid . number)
                                          (user . string) (egid . number)
                                          (group . string) (comm . 52)
                                          (state . string) (ppid . number)
                                          (pgrp . number) (sess . number)
                                          (ttname . string) (tpgid . number)
                                          (minflt . number) (majflt . number)
                                          (time . tramp-ps-time) (pri . number)
                                          (nice . number) (vsize . number)
                                          (rss . number) (etime . number)
                                          (pcpu . number) (pmem . number) (args)))
     (tramp-connection-local-default-shell-profile (shell-file-name . "/bin/sh")
                                                   (shell-command-switch . "-c"))
     (tramp-connection-local-default-system-profile (path-separator . ":")
                                                    (null-device . "/dev/null"))))
 '(cursor-type 'bar)
 '(custom-safe-themes
   '("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default))
 '(delete-selection-mode t)
 '(desktop-auto-save-timeout 0)
 '(desktop-restore-eager 10)
 '(desktop-save-mode nil)
 '(dired-hide-details-hide-information-lines t)
 '(electric-pair-pairs '((34 . 34) (8216 . 8217) (8220 . 8221) (10181 . 10182)))
 '(enable-recursive-minibuffers t)
 '(eshell-visual-commands
   '("vi" "vim" "screen" "tmux" "top" "htop" "less" "more" "lynx" "links" "ncftp"
     "mutt" "pine" "tin" "trn" "elm" "cabal repl" "ghci"))
 '(exec-path-from-shell-shell-name "/usr/bin/fish")
 '(fill-column 80)
 '(flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
 '(frame-background-mode nil)
 '(grep-highlight-matches 'always)
 '(helm-move-to-line-cycle-in-source nil)
 '(helm-split-window-inside-p t)
 '(help-at-pt-display-when-idle 'never nil (help-at-pt))
 '(highlight-parentheses-colors '("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900"))
 '(inhibit-startup-screen t)
 '(initial-buffer-choice 'welcome-buffer)
 '(initial-major-mode 'fundamental-mode)
 '(ispell-program-name "hunspell")
 '(js-indent-level 2)
 '(lua-indent-level 2)
 '(magit-branch-adjust-remote-upstream-alist '(("upstream/master" . "fix-.*")))
 '(markdown-enable-math t)
 '(menu-bar-mode nil)
 '(meow-char-thing-table
   '((40 . round) (91 . square) (123 . curly) (60 . angle) (34 . string)
     (112 . paragraph) (108 . line) (98 . buffer)))
 '(meow-esc-mode t)
 '(meow-global-mode t)
 '(meow-keypad-leader-dispatch nil)
 '(meow-use-clipboard t)
 '(olivetti-body-width 120)
 '(org-agenda-dim-blocked-tasks 'invisible)
 '(org-agenda-files '("~/sync/new-brain/dashboard.org"))
 '(org-agenda-tags-column -20)
 '(org-babel-load-languages '((emacs-lisp . t)))
 '(org-catch-invisible-edits 'smart)
 '(org-ctags-open-link-functions nil t)
 '(org-enforce-todo-dependencies t)
 '(org-export-initial-scope 'subtree)
 '(org-fold-catch-invisible-edits 'smart)
 '(org-fontify-todo-headline nil)
 '(org-format-latex-options
   '(:foreground default :background default :scale 0.5 :html-foreground "Black"
                 :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-goto-interface 'outline-path-completion)
 '(org-hide-emphasis-markers nil)
 '(org-id-link-to-org-use-id t)
 '(org-indent-indentation-per-level 1)
 '(org-journal-carryover-items "")
 '(org-journal-dir "~/new-brain/journals")
 '(org-journal-file-format "%Y-W%V-%m%d.org")
 '(org-journal-file-type 'weekly)
 '(org-latex-compiler "lualatex")
 '(org-link-use-indirect-buffer-for-internals t)
 '(org-log-into-drawer t)
 '(org-loop-over-headlines-in-active-region t)
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-doi ol-eww ol-gnus org-habit org-id ol-info
             ol-irc ol-mhe ol-rmail org-tempo ol-w3m))
 '(org-preview-latex-default-process 'dvisvgm nil nil "Customized with use-package org")
 '(org-preview-latex-process-alist
   '((dvipng :programs ("latex" "dvipng") :description "dvi > png" :message
             "you need to install the programs: latex and dvipng."
             :image-input-type "dvi" :image-output-type "png" :image-size-adjust
             (1.0 . 1.0) :latex-compiler
             ("latex -interaction nonstopmode -output-directory %o %f")
             :image-converter ("dvipng -D %D -T tight -o %O %f")
             :transparent-image-converter
             ("dvipng -D %D -T tight -bg Transparent -o %O %f"))
     (dvisvgm :programs ("xelatex" "dvisvgm") :description "xdv > svg" :message
              "you need to install the programs: latex and dvisvgm."
              :image-input-type "xdv" :image-output-type "svg"
              :image-size-adjust (1.7 . 1.5) :latex-compiler
              ("xelatex -no-pdf -interaction nonstopmode -output-directory %o %f")
              :image-converter
              ("dvisvgm %f --no-fonts --exact-bbox --scale=%S --output=%O"))
     (imagemagick :programs ("latex" "convert") :description "pdf > png"
                  :message
                  "you need to install the programs: latex and imagemagick."
                  :image-input-type "pdf" :image-output-type "png"
                  :image-size-adjust (1.0 . 1.0) :latex-compiler
                  ("pdflatex -interaction nonstopmode -output-directory %o %f")
                  :image-converter
                  ("convert -density %D -trim -antialias %f -quality 100 %O"))))
 '(org-ql-views
   '(("Tasks that needs to processed" :buffers-files
      ("/home/capfredf/new-brain/dashboard.org") :query
      (and (todo "TODO") (not (scheduled :to today))) :sort nil :narrow nil
      :super-groups nil :title "Tasks that needs to processed")
     ("Today's View" :buffers-files ("/home/capfredf/new-brain/dashboard.org")
      :query
      (or (and (scheduled :to today) (todo "TODO" "WAITING"))
          (and (ts-active :on today) (todo "TODO" "WAITING")) (todo "DOING"))
      :sort (todo date) :narrow nil :super-groups
      ((:name "In-Progress" :todo "DOING")
       (:name "Waiting" :and (:scheduled today :todo "WAITING"))
       (:name "Fitness" :and (:scheduled today :category "workout"))
       (:name "Daily" :and (:scheduled today :category "daily"))
       (:name "Scheduled" :and
              (:scheduled today :not
                          (:and (:category "daily" :category "workout")) :todo
                          "TODO"))
       (:name "Future" :scheduled future))
      :title "Today's View")
     ("Overview: Agenda-like" :buffers-files org-agenda-files :query
      (and (not (done))
           (or (habit) (deadline auto) (scheduled :to today)
               (ts-active :on today)))
      :sort (todo priority date) :super-groups org-super-agenda-groups :title
      "Agenda-like")
     ("Overview: NEXT tasks" :buffers-files org-agenda-files :query
      (todo "NEXT") :sort (date priority) :super-groups org-super-agenda-groups
      :title "Overview: NEXT tasks")
     ("Calendar: Today" :buffers-files org-agenda-files :query
      (ts-active :on today) :title "Today" :super-groups org-super-agenda-groups
      :sort (priority))
     ("Calendar: This week"
      . #[0
          "\301 \302\303\304\305\304\306\304\307\310\301 \311\1!\10>\204\34\0\312\313\314\3D\"\210\211\315H\204\232\0\211\315\316\317\320\311\6\6!\10>\2048\0\312\313\314\6\10D\"\210\5\321H\204\223\0\5\321\311\6\10!\10>\210\6\7\322H\6\10\323H\6\11\324H\6\12\325H\6\13\326H\6\14\327H\5\203\215\0\4\203\215\0\3\203\215\0\2\203\215\0\1\203\215\0\211\203\215\0\330\331\6\7\6\7\6\7\6\7\6\7\6\7&\6!\266\206\202\221\0\330 \266\206I\210\5\321H\"!I\210\211\315H\262\1[\6\12#&\7\302\303\332\305\333\306\333\307\310\327\301 \311\1!\10>\204\300\0\312\313\314\3D\"\210\211\315H\204>\1\211\315\316\317\320\311\6\6!\10>\204\334\0\312\313\314\6\10D\"\210\5\321H\2047\1\5\321\311\6\10!\10>\210\6\7\322H\6\10\323H\6\11\324H\6\12\325H\6\13\326H\6\14\327H\5\2031\1\4\2031\1\3\2031\1\2\2031\1\1\2031\1\211\2031\1\330\331\6\7\6\7\6\7\6\7\6\7\6\7&\6!\266\206\2025\1\330 \266\206I\210\5\321H\"!I\210\211\315H\262\1Z\6\13#&\7\334\335 \336\337\5\340\6\6\257\5\341\342\343\344\345\346&\10\207"
          [cl-struct-ts-tags ts-now ts-apply :hour 0 :minute :second ts-adjust
                             day type-of signal wrong-type-argument ts 7
                             string-to-number format-time-string "%w" 17 3 2 1 4
                             5 6 float-time encode-time 23 59 org-ql-search
                             org-agenda-files ts-active :from :to :title
                             "This week" :super-groups org-super-agenda-groups
                             :sort (priority)]
          34 "Show items with an active timestamp during this calendar week."
          nil])
     ("Calendar: Next week"
      . #[0
          "\301\302\303\304 #\305\306\307\310\307\311\307\301\302\304 \312\1!\10>\204 \0\313\314\315\3D\"\210\211\303H\204\236\0\211\303\316\317\320\312\6\6!\10>\204<\0\313\314\315\6\10D\"\210\5\321H\204\227\0\5\321\312\6\10!\10>\210\6\7\322H\6\10\323H\6\11\324H\6\12\325H\6\13\326H\6\14\327H\5\203\221\0\4\203\221\0\3\203\221\0\2\203\221\0\1\203\221\0\211\203\221\0\330\331\6\7\6\7\6\7\6\7\6\7\6\7&\6!\266\206\202\225\0\330 \266\206I\210\5\321H\"!I\210\211\303H\262\1[\6\12#&\7\305\306\332\310\333\311\333\301\302\327\304 \312\1!\10>\204\304\0\313\314\315\3D\"\210\211\303H\204B\1\211\303\316\317\320\312\6\6!\10>\204\340\0\313\314\315\6\10D\"\210\5\321H\204;\1\5\321\312\6\10!\10>\210\6\7\322H\6\10\323H\6\11\324H\6\12\325H\6\13\326H\6\14\327H\5\2035\1\4\2035\1\3\2035\1\2\2035\1\1\2035\1\211\2035\1\330\331\6\7\6\7\6\7\6\7\6\7\6\7&\6!\266\206\2029\1\330 \266\206I\210\5\321H\"!I\210\211\303H\262\1Z\6\13#&\7\334\335 \336\337\5\340\6\6\257\5\341\342\343\344\345\346&\10\207"
          [cl-struct-ts-tags ts-adjust day 7 ts-now ts-apply :hour 0 :minute
                             :second type-of signal wrong-type-argument ts
                             string-to-number format-time-string "%w" 17 3 2 1 4
                             5 6 float-time encode-time 23 59 org-ql-search
                             org-agenda-files ts-active :from :to :title
                             "Next week" :super-groups org-super-agenda-groups
                             :sort (priority)]
          34
          "Show items with an active timestamp during the next calendar week."
          nil])
     ("Review: Recently timestamped" . org-ql-view-recent-items)
     (#("Review: Dangling tasks" 0 22 (help-echo "Tasks whose ancestor is done"))
      :buffers-files org-agenda-files :query (and (todo) (ancestors (done)))
      :title
      #("Review: Dangling tasks" 0 22 (help-echo "Tasks whose ancestor is done"))
      :sort (todo priority date) :super-groups ((:auto-parent t)))
     (#("Review: Stale tasks" 0 19
        (help-echo "Tasks without a timestamp in the past 2 weeks"))
      :buffers-files org-agenda-files :query (and (todo) (not (ts :from -14)))
      :title
      #("Review: Stale tasks" 0 19
        (help-echo "Tasks without a timestamp in the past 2 weeks"))
      :sort (todo priority date) :super-groups ((:auto-parent t)))
     (#("Review: Stuck projects" 0 22
        (help-echo "Tasks with sub-tasks but no NEXT sub-tasks"))
      :buffers-files org-agenda-files :query
      (and (todo) (descendants (todo)) (not (descendants (todo "NEXT")))) :title
      #("Review: Stuck projects" 0 22
        (help-echo "Tasks with sub-tasks but no NEXT sub-tasks"))
      :sort (date priority) :super-groups org-super-agenda-groups)))
 '(org-refile-targets
   '((nil :maxlevel . 10) (org-agenda-files :maxlevel . 3)
     ("/home/capfredf/my-brain/Research/Occurrence Typing X SimpleSub/Occurrence Typing X SimpleSub.org"
      :maxlevel . 3)))
 '(org-refile-use-outline-path 'title)
 '(org-roam-directory "~/brain/")
 '(org-roam-graph-viewer "~/bin/firefox")
 '(org-startup-folded nil)
 '(org-superstar-special-todo-items t)
 '(org-tags-column 0)
 '(org-todo-keyword-faces
   '(("DOING" . "(:foreground \"orange\" :weight bold :underline t)")
     ("TODO" :foreground "dark green" :weight bold :underline t)
     ("CANCELLED" . "gray")))
 '(org-use-fast-todo-selection 'expert)
 '(package-selected-packages
   '(activities ag auctex cape corfu diff-hl eat embark-consult
                exec-path-from-shell fish-mode haskell-mode
                highlight-parentheses jinx magit marginalia markdown-mode meow
                mistty olivetti orderless org-journal org-modern org-ql
                org-superstar paredit proof-general racket-mode solarized-theme
                tabspaces vertico wgrep-ag ws-butler yaml-mode yasnippet))
 '(project-switch-commands
   '((project-find-file "Find file" nil) (project-find-regexp "Find regexp" nil)
     (project-find-dir "Find directory" nil) (project-vc-dir "VC-Dir" nil)
     (project-eshell "Eshell" nil) (magit-project-status "Magit" 109)))
 '(reftex-plug-into-AUCTeX t)
 '(repeat-mode t)
 '(safe-local-variable-values
   '((TeX-master . t) (eval racket-unicode-input-method-enable)
     (TeX-engine . xelatex) (olivetti-body-width . 150)))
 '(shift-select-mode nil)
 '(tab-bar-mode t)
 '(tab-width 2)
 '(temporary-file-directory "~/tmp/")
 '(tool-bar-mode nil)
 '(visible-bell nil)
 '(vterm-shell "fish")
 '(warning-suppress-types '((comp)))
 '(windmove-default-keybindings nil)
 '(windmove-delete-default-keybindings nil)
 '(window-divider-mode nil)
 '(xref-search-program 'ripgrep)
 '(yas-snippet-dirs '("/home/capfredf/.emacs.d/snippets")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#fdf6e3" :foreground "#657b83" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 110 :width normal :foundry "????" :family "Sarasa Mono SC"))))
 '(fixed-pitch ((t (:slant normal :weight normal :height 1.0 :width normal :family "Sarasa Mono SC"))))
 '(font-lock-variable-name-face ((t nil)))
 '(helm-ff-file-extension ((t (:extend t :foreground "dark red"))))
 '(highlight ((t nil)))
 '(match ((t (:background "orange" :foreground "#586e75" :weight bold))))
 '(meow-beacon-indicator ((t (:background "#DC7F9B" :foreground "white smoke"))))
 '(meow-insert-indicator ((t (:background "#6cb221" :foreground "white smoke" :weight bold))))
 '(meow-motion-indicator ((t (:background "#324A5F" :foreground "white smoke"))))
 '(meow-normal-indicator ((t (:background "deep sky blue" :foreground "white smoke" :weight bold))))
 '(meow-paren-indicator ((t (:background "dark goldenrod" :foreground "white smoke" :weight bold))))
 '(mode-line ((t (:background "#eee8d5" :foreground "#657b83" :box nil :overline "#cccec4" :underline (:color "#cccec4" :style line :position t)))))
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit fixed-pitch :foreground "#93a1a1"))))
 '(org-document-title ((t (:family "Source Han Sans SC" :height 1.5 :underline nil))))
 '(org-done ((t (:foreground "dim gray" :strike-through t))))
 '(org-drawer ((t (:foreground "#2aa198" :height 0.8))))
 '(org-headline-done ((t (:foreground "dim gray" :strike-through t))))
 '(org-headline-todo ((t (:foreground "Red4"))))
 '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
 '(org-level-1 ((t (:inherit nil :extend nil :foreground "#657b83" :height 1.3))))
 '(org-level-2 ((t (:inherit org-level-1 :extend nil :foreground "#657b83" :height 0.95))))
 '(org-level-3 ((t (:inherit org-level-2 :extend nil :foreground "#657b83" :height 0.95))))
 '(org-level-4 ((t (:inherit org-level-3 :extend nil :foreground "#657b83" :height 0.95))))
 '(org-level-5 ((t (:inherit org-level-4 :extend nil :foreground "#657b83"))))
 '(org-level-6 ((t (:inherit org-level-5 :extend nil :foreground "#657b83"))))
 '(org-level-7 ((t (:inherit org-level-6 :extend nil :foreground "#657b83"))))
 '(org-level-8 ((t (:inherit org-level-7 :extend nil :foreground "#657b83" :height 1.0))))
 '(org-meta-line ((t (:inherit font-lock-comment-face :slant normal))))
 '(org-property-value ((t (:inherit default :height 0.8))))
 '(org-special-keyword ((t (:foreground "#93a1a1" :weight bold :height 0.8))))
 '(org-tag ((t (:foreground "light gray" :weight bold))))
 '(region ((((class color) (min-colors 89)) (:extend t :foreground "#fdf6e3" :background "#586e75"))))
 '(tab-bar-tab ((t (:background "#fdf6e3" :foreground "#586e75" :underline (:color foreground-color :style line :position t)))))
 '(tooltip ((t nil)))
 '(variable-pitch ((t (:weight normal :height 1.0 :family "Noto Sans SC")))))
