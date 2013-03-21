(custom-set-variables
 '(python-guess-indent nil)
 '(python-indent 4))
(message "loading python-conf ...")
(unless (require 'python nil t)
  (package-install 'python))

(require 'autocomplete-conf)
(require 'highlight-conf)
(require 'yasnippet-conf)

(unless (require 'pyvirtualenv nil t)
  (package-install 'pyvirtualenv))

;(require  'flymake-checkers)
(if (not (string= window-system "w32"))
  (unless (require 'pyde nil t)
    (progn
      (message "installing of pyde ...")
      (package-install 'pyde)
      (message "pyde installed."))
    ))
(pyde-enable)
(setq python-check-command "pylint")
;; (setq py-load-pymacs-p nil)
;; (autoload 'python-mode "python-mode" "Python Mode." t)
;; (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; (add-to-list 'interpreter-mode-alist '("python" . python-mode))
;; 
;; ;; Initialize Pymacs                                                                                          
;; (setq pymacs-python-command  "/usr/bin/python2.7") 
;; 
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;; (autoload 'pymacs-autoload "pymacs")
;; 
;; ;; Initialize Rope         
;; (pymacs-load "ropemacs" "rope-")                                                                                    
;; (setq ropemacs-enable-autoimport t)

