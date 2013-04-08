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
				 (setq-local yas-fallback-behavior `call-other-command)
				 (define-key yas-minor-mode-map (kbd "S-SPC") 'yas-expand)))

(defun members (elems list)
  "test if all elements of list elemes are in list list, returns true in this case. Returns false if at least one element of elems is not in list"
  (cond 
   ((eq nil elems) t)
   ((member (car elems) list) (members (cdr elems) list))
   (t nil)
))

; (members '("a" "b") '("c"))
; (members '("a" "b") '())
; (members '("a" "b") nil)
; (members '("a" "b") '("a" "b") )
;  (members '("a" "b") '("a" "d" "b" "c") )

(defun activate-yasnippet-with-dirs(dirs)
  (let ((not-reload-snipets (members dirs yas-snippet-dirs)))
    (mapc (lambda(x) 
	    (add-to-list 'yas-snippet-dirs x)) dirs)
    (unless not-reload-snipets (yas-reload-all)))
  (yas-minor-mode 1))
 
;(activate-yasnippet-with-dirs '("toto" "titi"))
(message "yasnippet-conf loaded")
(provide 'yasnippet-conf)







