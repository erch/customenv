(require 'ech-env)
(ech-install-and-load 'yasnippet)

(setq yas-snippet-dirs (list (expand-file-name "snippets" (file-name-directory (locate-library "yasnippet")))))

;;(require 'dropdown-list)
(setq yas-prompt-functions '(yas-ido-prompt
			     yas-completing-prompt))

(defun my-yasfallback (&optional from-trigger-key-p)
  "Fallback after expansion has failed"
  (let*  ((beyond-yasnippet (yas--keybinding-beyond-yasnippet)))
           (message "Falling back to %s"  beyond-yasnippet)
	   (when (fboundp 'beyond-yasnippet) (call-interactively beyond-yasnippet))))


(setq yas-minor-mode-hook ())
(setq yas-trigger-key   (kbd "S-SPC") )
(add-hook 'yas-minor-mode-hook (lambda()
                                 (define-key yas-minor-mode-map [(tab)] nil)
                                 (define-key yas-minor-mode-map (kbd "TAB") nil)
				 ;(global-unset-key  [(tab)])
				 ;(global-unset-key  (kbd "TAB"))
				 (setq-local yas-fallback-behavior `my-yasfallback)
				 (define-key yas-minor-mode-map (kbd "S-SPC") 'yas-expand)))



; (members '("a" "b") '("c"))
; (members '("a" "b") '())
; (members '("a" "b") nil)
; (members '("a" "b") '("a" "b") )
;  (members '("a" "b") '("a" "d" "b" "c") )

(defun activate-yasnippet-buffer-local-with-dirs(dirs)
  (let ((not-reload-snipets (members dirs yas-snippet-dirs)))
    (mapc (lambda(x)
	    (add-to-list 'yas-snippet-dirs x)) dirs)
    (unless not-reload-snipets (yas-reload-all)))
  (yas-minor-mode 1))

(message "yasnippet-conf loaded")
(provide 'yasnippet-conf)
