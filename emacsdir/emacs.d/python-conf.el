(custom-set-variables
 '(python-guess-indent nil)
 '(python-indent 4))

(require 'python)
(require 'auto-complete)
(require 'yasnippet)
(setq py-load-pymacs-p nil)
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; Initialize Pymacs                                                                                          
(setq pymacs-python-command  "/usr/bin/python2.7") 

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-autoload "pymacs")

;; Initialize Rope         
(pymacs-load "ropemacs" "rope-")                                                                                    
(setq ropemacs-enable-autoimport t)

