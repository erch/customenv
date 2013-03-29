(message "loading highlight-conf ...")
(unless (require 'highlight nil t)
  (progn 
    (package-install 'highlight))
  (load-library "highlight"))

(message "highlight-conf loaded.")
(provide 'highlight-conf)
