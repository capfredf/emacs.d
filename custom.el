
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#373b41" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#8abeb7" "#c5c8c6"))
 '(auto-dim-other-buffers-mode nil)
 '(beacon-color "#cc6666")
 '(compilation-message-face (quote default))
 '(counsel-yank-pop-separator "
------------------------
")
 '(custom-safe-themes
   (quote
    ("1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(fci-rule-color "#373b41")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(hydra-is-helpful t)
 '(hydra-lv nil)
 '(ivy-count-format "(%d/%d) ")
 '(ivy-mode t)
 '(ivy-use-virtual-buffers t)
 '(japanese-TeX-error-messages nil)
 '(jdee-db-active-breakpoint-face-colors (cons "#0d0f11" "#7FC1CA"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#0d0f11" "#A8CE93"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#0d0f11" "#899BA6"))
 '(magit-diff-use-overlays nil)
 '(org-fontify-done-headline t)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-whole-heading-line t)
 '(org-src-fontify-natively t t)
 '(package-selected-packages
   (quote
    (apropospriate-theme smex auctex which-key doom-themes telephone-line ace-window hydra yasnippet paredit smart-mode-line-powerline-theme smart-mode-line base16-theme solarized-theme color-theme-sanityinc-tomorrow auto-dim-other-buffers multi-term leuven-theme counsel ivy material-theme projectile undo-tree racket-mode expand-region rust-mode rust diff-hl diff-hl-mode magit helm-projectile use-package multiple-cursors markdown-mode iy-go-to-char highlight-parentheses helm dracula-theme)))
 '(sgml-basic-offset 4)
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width condensed :foundry "nil" :family "Iosevka"))))
 '(agda2-highlight-datatype-face ((t (:foreground "#83AFE5"))))
 '(agda2-highlight-function-face ((t (:foreground "#83AFE5"))))
 '(agda2-highlight-keyword-face ((t (:foreground "#9A93E1"))))
 '(agda2-highlight-module-face ((t (:foreground "#F2C38F"))))
 '(agda2-highlight-number-face ((t (:foreground "#F2C38F"))))
 '(agda2-highlight-postulate-face ((t (:foreground "#83AFE5"))))
 '(agda2-highlight-primitive-face ((t (:foreground "#83AFE5"))))
 '(agda2-highlight-primitive-type-face ((t (:foreground "#83AFE5"))))
 '(agda2-highlight-record-face ((t (:foreground "#83AFE5"))))
 '(agda2-highlight-string-face ((t (:foreground "#7FC1CA"))))
 '(auto-dim-other-buffers-face ((t (:background "dim gray"))))
 '(sml/filename ((t (:inherit mode-line-buffer-id :background "#002b36" :foreground "#b58900" :weight bold))))
 '(sml/folder ((t (:inherit sml/global :background "#002b36" :foreground "#586e75" :weight normal))))
 '(sml/minor-modes ((t (:foreground "steel blue"))))
 '(sml/read-only ((t (:inherit (font-lock-type-face sml/not-modified) :foreground "#268bd2")))))
