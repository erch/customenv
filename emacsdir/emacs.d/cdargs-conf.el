(eval-and-compile  
  (add-to-list 'load-path (expand-file-name "misc" site-lisp-dir))
  (when (locate-library "cdargs.el")
    (require 'cdargs)
    (global-set-key (kbd "C-c C-v") 'cdargs)
))    
(provide 'cdargs-conf)
