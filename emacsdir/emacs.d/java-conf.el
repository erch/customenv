(unless (featurep 'java-conf)
  (unless (require 'eclim nil t)
    (progn
      (package-install 'emacs-eclim)
      (load-library "eclim")))
  (message "loading emacs eclim ...")
  (global-eclim-mode)
  (require 'eclimd)

  (require 'eclim)
  (global-eclim-mode)

  (setq eclim-auto-save t)
  (setq eclim-executable "~/opt/eclipse/eclim")
  (setq eclimd-executable "~/opt/eclipse/eclimd")
  (setq eclim-eclipse-dirs '("~/opt/eclipse"))
  (setq eclimd-wait-for-process nil)

  ;; regular auto-complete initialization
  (require 'autocomplete-conf)
  (ac-config-default)
  (setq help-at-pt-display-when-idle t)
  (setq help-at-pt-timer-delay 0.1)
  (setq ac-delay 0.5)
  (help-at-pt-set-timer)

  ;; add the emacs-eclim source
  (require 'ac-emacs-eclim-source)
  (ac-emacs-eclim-config)
  (setq eclimd-default-workspace "~/eclimworkspace")
  (message "emacs eclim loaded")
  (provide 'java-conf))
