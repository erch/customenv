(message "loading completion-conf ...")
(require 'ech-env)
(require 'ech-mode)

(ech-install-and-load 'company)

(setq company-idle-delay 0.2)
(setq company-tooltip-limit 10)
(setq company-minimum-prefix-length 2)
;; invert the navigation direction if the the completion popup-isearch-match
;; is displayed on top (happens near the bottom of windows)
(setq company-tooltip-flip-when-above t)

(define-key ech-mode-map ech-key-completion 'company-complete-common)
;; start company 
(global-company-mode 1)

(message "completion-conf loaded")
(provide 'completion-conf)
