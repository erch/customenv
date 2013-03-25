(unless (featurep 'python-conf)
  
  (message "loading python-conf ...")

  (custom-set-variables
   '(python-guess-indent nil)
   '(python-indent 4))
  (unless (require 'python nil t)
    (progn 
      (package-install 'python))
      (load-library "python"))

  (require 'autocomplete-conf)
  ;(require 'highlight-conf)
  (require 'yasnippet-conf)

  (unless (require 'pyvirtualenv nil t)
    (progn 
      (package-install 'pyvirtualenv)
      (load-library "pyvirtualenv")))

  (unless (string= window-system "w32")
      (unless (require 'pyde nil t)
	(progn
	  (message "installing of pyde ...")
	  (package-install 'pyde)
	  (load-library "pyde")
	  (message "pyde installed.")))
    
    (pyde-enable)
    (setq python-check-command "pylint"))
  (provide 'python-conf))


