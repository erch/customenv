(require 'ibuffer) 
(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("dired" (mode . dired-mode))
               ("java" (mode . java-mode))
               ("org" (mode . org-mode))
               ("sql" (mode . sql-mode))
               ("xml" (mode . nxml-mode))
	       ("python"  (mode . python-mode))
	      ("perl" (mode . perl-mode))
	      ))))    

(setq ibuffer-show-empty-filter-groups nil)

(add-hook 'ibuffer-mode-hook 
 (lambda () 
  (ibuffer-switch-to-saved-filter-groups "default")
  (ibuffer-filter-by-name "^[^*]")
  (ibuffer-filter-by-filename "."))) ;; to show only dired and files buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq mouse-buffer-menu-mode-mult 0)
(provide 'buffer-conf)
