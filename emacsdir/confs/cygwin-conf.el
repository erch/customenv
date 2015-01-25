(require 'ech-env)
(require 'shell-conf)
(when (and (or (string= system-type "ms-dos") (string= system-type "windows-nt")) (executable-find "bash"))
  (setq exec-path (append '("C:/cygwin/bin") exec-path))
  (setq binary-process-input t)
  (setq w32-quote-process-args ?\")
  (setq shell-file-name "bash") ;; or sh if you rename your bash executable to sh.
  (setenv "SHELL" shell-file-name)
  ;;(setq explicit-shell-file-name "C:\\MyHome\\cygwin_site\\usr_local\\sbin\\cygwin.bat")
  (setq explicit-sh-args '("--noediting" "--login" "-i"))  
  (setq explicit-bash-args '( "--noediting" "--login" "-i"))
  (require 'cygwin-mount)
  (cygwin-mount-activate)

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

(provide 'cygwin-conf)
