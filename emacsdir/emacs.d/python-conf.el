(message "loading python-conf ...")


(unless (require 'python nil t)
  (progn 
    (package-install 'python))
  ;(load-library "python")
)

(require 'python)
(require 'completion-conf)
(require 'highlight-conf)
(require 'yasnippet-conf)

(unless (require 'pyvirtualenv nil t)
  (progn 
    (package-install 'pyvirtualenv)
    ;(load-library "pyvirtualenv")
))

(require 'pyvirtualenv)

(unless (string= window-system "w32")
  (progn
    (unless (require 'pyde nil t)
      (progn
	(message "installing of pyde ...")
	(package-install 'pyde)
	;(load-library "pyde")
	(message "pyde installed.")))
    (require 'pyde)
    (pyde-enable)
    (pyde-clean-modeline)
    (setq python-check-command "pylint")
    (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
      (setq flymake-check-was-interrupted t))
    (ad-activate 'flymake-post-syntax-check)))

(defun python-mode-cust ()
  (let 
      ((all-snip-dir (file-name-as-directory (expand-file-name "snippets" (file-name-directory emacs-d-dir)))))
    (activate-yasnippet-with-dirs (list (file-name-as-directory (expand-file-name "python" all-snip-dir)))))
  (setq-local python-guess-indent nil)
  (setq-local python-indent 4))

(add-hook 'python-mode-hook 'python-mode-cust)
(message "python-conf loaded.")
(provide 'python-conf)


