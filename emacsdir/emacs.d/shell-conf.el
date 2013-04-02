(message "loading shell-conf ...")
(unless (require 'multi-term nil t)
  (progn
    (package-install 'multi-term)))

(require 'multi-term)
(multi-term-keystroke-setup) 
(global-set-key (kbd "<f2>") 'multi-term)
(global-set-key (kbd "S-<f2>") 'multi-term-next)

(add-hook 'term-mode-hook
	  '(lambda ()
	     (setq-local overflow-newline-into-fringe t)
	     (define-key term-raw-map (kbd "C-c C-j") 'term-line-mode)
	     (setq-local  multi-term-scroll-show-maximum-output t)
	     (setq-local  multi-term-scroll-to-bottom-on-output "all")
	     (setq-local  autopair-dont-activate t)
	     (yas-minor-mode -1)))

(unless (string= window-system "w32")
  (add-hook 'term-mode-hook 
	    '(lambda ()
	        (setq-local comint-use-prompt-regexp t)
		(setq-local shell-prompt-pattern "^[^$]+$ ")
		(setq-local term-prompt-regexp "^[^$]+$ ")
		(setq-local comint-prompt-regexp shell-prompt-pattern))))
			       
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initial setup
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; This assumes that Cygwin is installed in C:\cygwin (the
;; default) and that C:\cygwin\bin is not already in your
;; Windows Path (it generally should not be).
(when (or (string= system-type "ms-dos") (string= system-type "windows-nt"))
  (setq exec-path (cons "C:/cygwin/bin" exec-path))
  (setenv "PATH" (concat "C:\\cygwin\\bin;" (getenv "PATH")))

  ;;   LOGNAME and USER are expected in many Emacs packages
  ;;   Check these environment variables.
  (if (and (null (getenv "USER"))
	   ;; Windows includes variable USERNAME, which is copied to
	   ;; LOGNAME and USER respectively.
	   (getenv "USERNAME"))
      (setenv "USER" (getenv "USERNAME")))

  (if (and (getenv "LOGNAME")
	   ;;  Bash shell defines only LOGNAME
	   (null (getenv "USER")))
      (setenv "USER" (getenv "LOGNAME")))

  (if (and (getenv "USER")
	   (null (getenv "LOGNAME")))
      (setenv "LOGNAME" (getenv "USER")))

  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; (A) M-x shell: This change M-x shell permanently
  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq multi-term-program "/bin/bash")
  (setq shell-file-name "bash")
  (setenv "SHELL" shell-file-name)
  (setq explicit-shell-file-name shell-file-name)
  (setq explicit-sh-args '("-login" "-i"))
  (setq explicit-bash-args  explicit-sh-args)
  (setq w32-quote-process-args     ?\")
  (setq comint-completion-addsuffix '("/" . ""))
  (setq comint-prompt-regexp "^[ \n\t]*[$] ?")
  ;; Remove C-m (^M) characters that appear in output
  (add-hook 'comint-output-filter-functions
	    'comint-strip-ctrl-m))

(message "shell-conf loaded")    
(provide 'shell-conf)
