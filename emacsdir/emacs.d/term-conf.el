(unless (featurep 'term-conf)
  (unless (require 'multi-term nil t)
    (progn
      (package-install 'multi-term)
      (load-library "mulit-term")))
  (message "loading term ...")
  (if (or (string= system-type "ms-dos") (string= system-type "windows-nt"))
      (progn 
	(add-to-list 'exec-path "C:\\cygwin\\bin")
	(setq multi-term-program "bash --login -i"))
    (setq multi-term-program "/bin/bash"))
  (require 'multi-term)
  (multi-term-keystroke-setup) 
  (global-set-key (kbd "<f2>") 'multi-term)
  (global-set-key (kbd "S-<f2>") 'multi-term-next)

  (add-hook 'term-mode-hook
	    '(lambda ()
	       (define-key term-raw-map (kbd "C-c C-j") 'term-line-mode)
	       (setq multi-term-scroll-show-maximum-output t)
	       (setq multi-term-scroll-to-bottom-on-output "all")
	       (setq autopair-dont-activate t)
	       (yas-minor-mode -1)))
  (message "term loaded")
  (provide 'term-conf))



