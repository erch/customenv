(message "loading crontab-conf ...")

(unless (locate-library "crontab-mode")
  (progn
    (package-install 'crontab-mode))
)
(provide 'crontab-conf)
