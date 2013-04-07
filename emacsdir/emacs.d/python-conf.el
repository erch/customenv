(message "loading python-conf ...")


(unless (require 'python nil t)
  (progn 
    (package-install 'python))
  (require 'python)
)

(require 'completion-conf)
(require 'highlight-conf)
(require 'yasnippet-conf)

(unless (require 'pyvirtualenv nil t)
  (progn 
    (package-install 'pyvirtualenv)
    (require 'pyvirtualenv)
))

(unless (string= window-system "w32")
  (progn
    (unless (require 'pyde nil t)
      (progn
	(message "installing of pyde ...")
	(package-install 'pyde)
	(require 'pyde)))
    (pyde-enable)
    (pyde-clean-modeline)
    (setq python-check-command "pylint")
    (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
      (setq flymake-check-was-interrupted t))
    (ad-activate 'flymake-post-syntax-check)))

(defun python-mode-cust ()
  (activate-yasnippet-with-dirs (list (expand-file-name "snippets" (file-name-directory emacs-d-dir))))
  (setq-local python-guess-indent nil)
  (setq-local python-indent 4))

(add-hook 'python-mode-hook 'python-mode-cust)
(message "python-conf loaded.")
(provide 'python-conf)


