(require 'package)

;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives
;;              '("org" . "https://orgmode.org/elpa/"))
;; (add-to-list 'package-archives
;;              '("devel" . "https://elpa.gnu.org/devel/"))

;; (add-to-list 'package-archives
;;              '("gnu-devel" . "https://orgmode.org/elpa/"))
;; (package-initialize)
;; (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
;; (require 'racket-mode)

(setq package-enable-at-startup nil)
(add-to-list 'load-path (expand-file-name "lib/borg" user-emacs-directory))
(require 'borg)
(borg-initialize)

(eval-and-compile
  (require 'use-package))
(require 'bind-key)

(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

(require 'mod-base)
(require 'mod-visual)
(require 'mod-edit)


(put 'downcase-region 'disabled nil)
