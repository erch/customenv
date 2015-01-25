
(message "loading ido-conf ...")
(require 'ech-env)
(ech-install-and-load 'ido-ubiquitous)
(require 'ido)
(setq ido-enable-flex-matching t)
(ido-mode 1)

(ido-ubiquitous-mode t)
(message "ido-conf loaded.")
(provide 'ido-conf)
