(require 'package)

(setq gc-cons-threshold 100000000)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(eval-and-compile
  (require 'use-package))
(require 'bind-key)


(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

(require 'mod-base)
(require 'color-theme-sanityinc-tomorrow)
;; (color-theme-sanityinc-tomorrow-day)
;; ;(load-theme 'sanityinc-tomorrow-day t)

(require 'mod-visual)
(require 'mod-workspace)
(require 'mod-edit)
(require 'mod-coding)
(require 'mod-writing)
