(require 'package)

(setq gc-cons-threshold 100000000)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-install 'use-package)


(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

(dolist
    (mod '(mod-base
           mod-workspace
           mod-visual
           mod-coding
           mod-edit
           mod-writing))
  (require mod))
