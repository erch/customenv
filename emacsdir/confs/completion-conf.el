(message "loading autocomplete-conf ...")
(require 'ech-env)
(ech-install-and-load 'auto-complete)
(require 'auto-complete-config)
(define-key ac-mode-map (kbd "M-SPC") 'auto-complete)
(setq ac-trigger-key  "M-SPC")

; ac-auto-start => nb char before automatic completion
(ac-config-default)
(setq ac-ignore-case nil)
(add-to-list 'ac-dictionary-directories (expand-file-name "dict" (file-name-directory (locate-library "auto-complete"))))

;; `ac-auto-show-menu': Short timeout because the menu is great.
(setq ac-auto-show-menu 0.4)

;; `ac-quick-help-delay': I'd like to show the menu right with the
;; completions, but this value should be greater than
;; `ac-auto-show-menu' to show help for the first entry as well.
(setq ac-quick-help-delay 0.5)

(setq tab-always-indent t) ;tab only indent
(message "autocomplete-conf loaded")
(provide 'completion-conf)
