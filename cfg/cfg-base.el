(setq ring-bell-function 'ignore)

(use-package which-key
  :ensure t
  :demand t)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(global-set-key (kbd "M-y") 'counsel-yank-pop)

(use-package counsel
  :ensure t
  :demand t
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  :config
  (ivy-mode)
  (counsel-mode))

(setq tramp-default-method "ssh")

(provide 'cfg-base)
