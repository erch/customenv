(unless (featurep 'helm-conf)
  (unless (require 'helm-config nil t)
    (progn
      (package-install 'helm)
      (load-library "helm-config")))
  (message "loading helm ...")
  (require 'helm-config)
  (helm-mode 1)
  (provide 'helm-conf))
