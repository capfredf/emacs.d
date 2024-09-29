(defun splash-head ()
  "Insert the head part of the splash screen into the current buffer."
  (let* ((image-file (expand-file-name "~/.emacs.d/ThereIsNoLinearTime1.png"))
         (img (create-image image-file))
         (image-width (and img (car (image-size img))))
         (window-width (window-width)))
    (when img
      (when (> window-width image-width)
        ;; Center the image in the window.
        (insert (propertize " " 'display
                            `(space :align-to (+ center (-0.5 . ,img)))))

        ;; Change the color of the XPM version of the splash image
        ;; so that it is visile with a dark frame background.

        ;; Insert the image with a help-echo and a link.
        (make-button (prog1 (point) (insert-image img)) (point)
                     'face 'default
                     'help-echo "mouse-2, RET: Browse https://www.racket-lang.org"
                     'action (lambda (_button) (browse-url "https://www.racket-lang.org"))
                     'follow-link t)
        (insert "\n\n")))))

(defun welcome-buffer ()
  (interactive)
  (let (($buf (get-buffer-create "*Some Quotes*")))
    (with-current-buffer $buf
      (erase-buffer)
      (funcall initial-major-mode)
      (setq buffer-offer-save t)
      (splash-head)
      (insert "Thirteen years ago I knew the carpets would need vacuuming around now and having a baby seemd to be the easist and cheapest way to get the job done\n\n")
      (insert "                                                                                                                 -- Ted Chiang, Stories of Your Life")
      (setq buffer-read-only t)
      (set-buffer-modified-p nil))
    (switch-to-buffer $buf)))

(defun read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(define-key global-map [?\s-m] nil)


;; faster than the default "scp"
(setq tramp-default-method "ssh")

;; (require 'server)
;; (unless (server-running-p) (server-start))
(when (eq system-type 'darwin)
  (setq mac-mouse-wheel-mode t)
  (setq mac-mouse-wheel-smooth-scroll t))


(defun mean (lst)
  (/ (apply '+ lst) (length lst)))


(defun rename-current-file-and-buffer ()
  ;; from Batsov
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(defun ap/garbage-collect ()
  "Run `garbage-collect' and print stats about memory usage."
  (interactive)
  (message (cl-loop for (type size used free) in (garbage-collect)
                    for used = (* used size)
                    for free = (* (or free 0) size)
                    for total = (file-size-human-readable (+ used free))
                    for used = (file-size-human-readable used)
                    for free = (file-size-human-readable free)
                    concat (format "%s: %s + %s = %s\n" type used free total))))


(provide 'mod-base)
