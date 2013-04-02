 (message "loading autocomplete-conf ...")
(unless (require 'auto-complete nil t)
  (progn 
    (package-install 'auto-complete)
    (load-library "auto-complete")))

;; (unless (require 'company  nil t)
;;   (progn 
;;     (package-install 'company)
;;     (load-library "company"))

(require 'yasnippet-conf)
(require 'auto-complete-config)
(define-key ac-mode-map (kbd "M-SPC") 'auto-complete)
(setq ac-trigger-key  "M-SPC")

; ac-auto-start => nb char before automatic completion
(setq ac-ignore-case nil)
(add-to-list 'ac-dictionary-directories (expand-file-name "dict" (file-name-directory (locate-library "auto-complete"))))
(ac-config-default)

(message "autocomplete-conf loaded")
(provide 'completion-conf)
