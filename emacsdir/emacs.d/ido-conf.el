(message "loading ido-conf ...")
(unless (require 'ido-ubiquitous nil t)
  (progn      
    (package-install 'ido-ubiquitous)
    (require 'ido-ubiquitous)))


(require 'ido)
(setq ido-enable-flex-matching t)
(ido-mode 1)
(require 'ido-ubiquitous)
(ido-ubiquitous-mode t)
(message "ido-conf loaded.")
(provide 'ido-conf)
