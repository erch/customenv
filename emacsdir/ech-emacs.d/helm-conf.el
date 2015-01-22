(message "loading helm-config ...")
(unless (require 'helm-config nil t)
  (progn
    (package-install 'helm)
    (require 'helm-config)))

(global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
;(global-set-key (kbd "C-x c C-x C-l") 'helm-locate)
(message "helm-config loaded.")
(provide 'helm-conf)
