(message "loading yasnippet-conf ...")
(unless (require 'yasnippet nil t)
  (progn
    (package-install 'yasnippet)
    (require 'yasnippet)
))

(setq yas-snippet-dirs (list (expand-file-name "snippets" (file-name-directory (locate-library "yasnippet")))))

(require 'dropdown-list)
(setq yas-prompt-functions '(yas-dropdown-prompt
			     yas-ido-prompt
			     yas-completing-prompt))

(add-hook 'yas-minor-mode-hook (lambda()
                                 (define-key yas-minor-mode-map [(tab)] nil)
                                 (define-key yas-minor-mode-map (kbd "TAB") nil)
				 ;(global-unset-key  [(tab)])
				 ;(global-unset-key  (kbd "TAB"))
				 (define-key yas-minor-mode-map (kbd "S-SPC") 'yas-expand)))

(defun activate-yasnippet-with-dirs(dirs)
  (make-local-variable  'yas-snippet-dirs)
  (mapc (lambda(x) 
	  (message x)
	  (add-to-list 'yas-snippet-dirs x)) dirs)
  (yas-reload-all)
  (yas-minor-mode 1))
 
;(activate-yasnippet-with-dirs '("toto" "titi"))
(message "yasnippet-conf loaded")
(provide 'yasnippet-conf)







