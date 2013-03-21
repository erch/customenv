(eval-and-compile 
  ;(add-to-list 'load-path (expand-file-name "yasnippet"  site-lisp-dir))
  (when (not (require 'yasnippet nil t))
    (package-install 'yasnippet-bundle))
   (yas/initialize)) 
  ;(yas/load-directory (expand-file-name "yasnippet/snippets"  site-lisp-dir)))
