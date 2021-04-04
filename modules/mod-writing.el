;; (use-package org-super-agenda
;;   :ensure t
;;   :config
;;   (let ((org-agenda-span 'day)
;;         (org-super-agenda-groups
;;          '((:name "Today"  ; Optionally specify section name
;;                   :time-grid t  ; Items that appear on the time grid
;;                   :todo "DONE")  ; Items that have this TODO keyword
;;            (:priority<= "B"
;;                       ;; Show this section after "Today" and "Important", because
;;                       ;; their order is unspecified, defaulting to 0. Sections
;;                       ;; are displayed lowest-number-first.
;;                       :order 1))))
;;   (org-agenda nil "c")))
(provide 'mod-writing)
