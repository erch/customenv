(unless (featurep 'ido-conf)
  (unless (require 'ido-ubiquitous nil t)
    (progn      
      (package-install 'ido-ubiquitous)
      (load-library "ido-ubiquitous")))
  (message "loading ido ...")

  (require 'ido)
  (setq ido-enable-flex-matching t)
  (ido-mode 1)
  (require 'ido-ubiquitous)
  (ido-ubiquitous-mode t)
  (message "ido loaded.")
  (provide 'ido-conf))

