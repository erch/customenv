(message "loading completion-conf ...")
(require 'ech-env)

(ech-install-and-load 'company)

(setq company-idle-delay 0.5)
(setq company-tooltip-limit 10)
(setq company-minimum-prefix-length 2)
;; invert the navigation direction if the the completion popup-isearch-match
;; is displayed on top (happens near the bottom of windows)
(setq company-tooltip-flip-when-above t)

(global-company-mode 1)

(message "completion-conf loaded")
(provide 'completion-conf)
