(unless (require 'auto-complete nil t)
  (package-install 'auto-complete))

(message "loading autocomplete-conf ...")
(require 'yasnippet-conf)
(require 'auto-complete-config)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(add-to-list 'ac-dictionary-directories (expand-file-name "dict" (file-name-directory (locate-library "auto-complete"))))
(ac-config-default)

(message "autocomplete-conf loaded")
(provide 'autocomplete-conf)
