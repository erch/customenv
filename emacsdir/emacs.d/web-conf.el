(unless (require 'web-mode nil t)
  (progn
    (package-install 'web-mode)
    (require 'web-mode)
))
