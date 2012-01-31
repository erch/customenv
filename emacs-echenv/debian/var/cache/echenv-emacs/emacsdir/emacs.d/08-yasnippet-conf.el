(eval-and-compile 
  (add-to-list 'load-path (expand-file-name "yasnippet"  site-lisp-dir))
  (require 'yasnippet) ;; not yasnippet-bundle
  (yas/initialize)
  (yas/load-directory (expand-file-name "yasnippet/snippets"  site-lisp-dir)))
