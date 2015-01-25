(require 'ech-env)
(require 'yasnippet-conf)
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 
	  (lambda ()
	    (activate-yasnippet-buffer-local-with-dirs (list (expand-file-name "snippets" (file-name-directory emacs-dir))))))
(provide 'lisp-conf)
