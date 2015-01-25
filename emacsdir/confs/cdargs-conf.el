(eval-and-compile  
  (require 'ech-env)
  (when (locate-library "cdargs.el")
    (require 'cdargs)
    (global-set-key (kbd "C-c C-v") 'cdargs)
))    
(provide 'cdargs-conf)
