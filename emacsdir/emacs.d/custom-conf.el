(message "loadind custom-conf ...")

(unless (require 'nav nil t)
  (progn
    (package-install 'nav)
    (require 'nav)
    ))

(nav-disable-overeager-window-splitting)
(message "custom-conf loaded.")

(provide 'custom-conf)
