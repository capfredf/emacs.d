(require 'package)

(setq old-val gc-cons-threshold)
(setq gc-cons-threshold 100000000)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("org" . "https://orgmode.org/elpa/"))
(package-initialize)
;; (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
;; (require 'racket-mode)
(eval-and-compile
  (require 'use-package))
(require 'bind-key)

(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

(require 'mod-base)
(require 'mod-visual)
(require 'mod-workspace)
(require 'mod-edit)
(require 'mod-coding)
(require 'mod-writing)

(setq gc-cons-threshold old-val)
