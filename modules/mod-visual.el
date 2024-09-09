(defun switch-theme (theme)
  ;; This interactive call is taken from `load-theme'
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
                             (mapcar 'symbol-name
                                     (custom-available-themes))))))
  (mapcar #'disable-theme custom-enabled-themes)
  (load-theme theme t))

(defun load-theme-after (theme-id &rest arg)
  ;; config for moody
  (let ((line (face-attribute 'mode-line :underline)))
    (set-face-attribute 'mode-line          nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :underline  line)
    (set-face-attribute 'mode-line          nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :box        nil)))

(advice-add 'load-theme :after #'load-theme-after)

;; (use-package color-theme-sanityinc-tomorrow
;;   :load-path "site-lisp/color-theme-sanityinc-tomorrow"
;;   :config
;;   (switch-theme 'sanityinc-tomorrow-eighties))




;; (global-hl-line-mode nil)

;; double tap in the minibuffer move point to the beginning of the minibuffer
;; enable when #29 is closed
;; (use-package moody
;;   :ensure t
;;   :config
;;   (setq x-underline-at-descent-line t)
;;   (moody-replace-mode-line-buffer-identification)
;;   (moody-replace-vc-mode))


(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))


(defun change-font-size (n)
  (custom-theme-set-faces
   'user
   `(default ((t ( :family "Sarasa Fixed SC" :slant normal :weight normal :height ,n :width normal))))))

;; (change-font-size 120)



(defun ff-get-current-tab-name ()
  (let* ((tabs (funcall tab-bar-tabs-function))
         (tab-index (tab-bar--current-tab-index tabs))
         (tab-to-rename (nth tab-index tabs)))
    (alist-get 'name tab-to-rename)))

(setq-default frame-title-format '("%b" (:eval (if tab-bar-mode
                                                   (format "[%s]" (ff-get-current-tab-name)) ""))
                                   " - "(getenv "USER") "@" (getenv "HOSTNAME")))



;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;   (set-fontset-font (frame-parameter nil 'font)
;;                     charset
;;                     (font-spec :family "Source Han Sans")))


;; (defadvice text-scale-increase (around all-buffers (arg) activate)
;;   ad-do-it)

;; (defun text-scale-increase-for-all ()
;;   "Increase font size for all buffers."
;;   (interactive)
;;   (dolist (buffer (buffer-list))
;;     (with-current-buffer buffer
;;       (text-scale-increase 1))))

;; (defun text-scale-decrease-for-all ()
;;   "Decrease font size for all buffers."
;;   (interactive)
;;   (dolist (buffer (buffer-list))
;;     (with-current-buffer buffer
;;       (text-scale-decrease 1))))

;; (defun text-scale-reset-for-all ()
;;   "Reset to the default font size for all buffers."
;;   (interactive)
;;   (dolist (buffer (buffer-list))
;;     (with-current-buffer buffer
;;       (text-scale-adjust 0))))

;; (defvar text-scaling-map
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map (kbd "i") 'text-scale-increase-for-all)
;;     (define-key map (kbd "r") 'text-scale-reset-for-all)
;;     (define-key map (kbd "o") 'text-scale-decrease-for-all)
;;     map))

;; (defun scale-text ()
;;   "Start the text scaling mode."
;;   (interactive)
;;   (set-transient-map text-scaling-map t))


(provide 'mod-visual)
;; mod-visual.el ends here
