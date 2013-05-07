(message "loading outline-conf ...")

(setq outline-minor-mode-prefix "\C-c=")
(require 'outline)

(unless (require 'outline-magic nil t)
  (progn 
    (package-install 'outline-magic)
    (require 'outline-magic))
)
(setq outline-cycle-emulate-tab nil)

(defun mybasic-outline-level()
  "basic function that guesses the level by the use of indentation"
  (save-excursion
    (let* (
 	   (buffer-invisibility-spec)
 	   (first-not-blank-pos (progn (beginning-of-line) (skip-chars-forward " \t"))))
      (+ 1 (/ first-not-blank-pos myoutline-indent-offset)))))

;; (setq outline-mode-hook ())
(add-hook 'outline-minor-mode-hook
	  (lambda () 
	    (progn
	      (message "hook")
	      (define-key outline-minor-mode-map [C-tab] 'outline-cycle)
	      (define-key outline-minor-mode-map [M-down] 'outline-move-subtree-down)
	      (define-key outline-minor-mode-map [M-up] 'outline-move-subtree-up)
	      ;(outline-minor-mode t)
	      (setq-local outline-blank-line t)
	      (hide-sublevels 1)
	      ;(hide-body)
)))

(defun activate-outline-buffer-local(headers-regex header-end-regex indent-offset &optional levelf)
  "activate outline for the current buffer"
  (outline-minor-mode 1)
  (setq-local outline-regexp headers-regex)
  (if (null levelf) 
    (setq-local outline-level 'mybasic-outline-level)
    (setq-local outline-level levelf))
  (setq-local outline-heading-end-regexp header-end-regex)
  (setq-local myoutline-indent-offset indent-offset)
  ;(outline-mode 1)
)

(message "outline-conf loaded.")
(provide 'outline-conf)
