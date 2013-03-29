(message "loading emacs eclim ...")
(unless (require 'eclim nil t)
  (progn
    (package-install 'emacs-eclim)
    (load-library "eclim")))

(require 'eclimd)
(require 'eclim)
(global-eclim-mode)
(require 'autocomplete-conf)
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)
(defun  eclim-mode-cust()
       "customisation for java buffers"
       (setq-local eclim-auto-save t)
       (setq-local eclim-executable "~/opt/eclipse/eclim")
       (setq-local eclimd-executable "~/opt/eclipse/eclimd")
       (setq-local eclim-eclipse-dirs '("~/opt/eclipse"))
       (setq-local eclimd-wait-for-process nil)

       ;;  auto-complete
       (auto-complete-mode 1)
       (setq-local ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
       (setq-local help-at-pt-display-when-idle t)
       (setq-local help-at-pt-timer-delay 0.1)
       (setq-local ac-delay 0.1)
       (help-at-pt-set-timer)
       (setq eclimd-default-workspace "~/eclimworkspace"))

(add-hook 'eclim-mode-hook 'eclim-mode-cust)
(message "emacs eclim loaded")
(provide 'java-conf)
