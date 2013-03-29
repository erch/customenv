(unless (require 'yasnippet nil t)
  (progn
    (package-install 'yasnippet)
    (load-library "yasnippet")))
(message "loading yasnippet ...")
(setq yas-snippet-dirs (expand-file-name "snippets" (file-name-directory (locate-library "yasnippet"))))
(message "yasnippet loaded")
(provide 'yasnippet-conf)
