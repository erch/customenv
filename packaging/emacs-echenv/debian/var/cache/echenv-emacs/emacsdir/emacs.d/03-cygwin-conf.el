(eval-and-compile 

  (when (or (string= system-type "ms-dos") (string= system-type "windows-nt"))
    (add-to-list 'load-path (expand-file-name "misc/"  site-lisp-dir))
    (setq binary-process-input t)
    (setq w32-quote-process-args ?\")
    (setq shell-file-name "sh") ;; or sh if you rename your bash executable to sh.
    (setenv "SHELL" shell-file-name)
    ;(setq explicit-shell-file-name "C:\\MyHome\\cygwin_site\\usr_local\\sbin\\cygwin.bat")
    (setq explicit-sh-args '("--noediting" "--login" "-i"))  
    (setq explicit-bash-args '( "--noediting" "--login" "-i"))
    (setq-default ispell-program-name "aspell")
    (autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
    (require 'cygwin-mount)
    (cygwin-mount-activate)))