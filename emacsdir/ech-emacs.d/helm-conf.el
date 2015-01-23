(message "loading helm-config ...")
(unless (require 'helm-config nil t)
  (progn
    (package-install 'helm)
    (require 'helm-config)))

(global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
;(global-set-key (kbd "C-x c C-x C-l") 'helm-locate)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
(message "helm-config loaded.")
(provide 'helm-conf)
