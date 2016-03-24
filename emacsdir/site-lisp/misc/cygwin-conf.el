(require 'ech-env)
;;(require 'shell-conf)
(require 'ech-mode)

(when ech-use-cygwin
  (let* ((bin-dir (expand-file-name "bin" cygwin-root-directory))
	 (bash-path (expand-file-name "bash.exe" bin-dir)))
    (add-to-list 'exec-path bin-dir bin-dir)
    (setq bash-path (expand-file-name "bash.exe" bin-dir))
    
    ;;   LOGNAME and USER are expected in many Emacs packages. Check these environment variables.
    (when (null (getenv "USER"))
      (cond
       ((getenv "USERNAME")
	(setenv "USER" (getenv "USERNAME")))
       ((getenv "LOGNAME")
	(setenv "USER" (getenv "LOGNAME")))))
    (when (and (getenv "USER") (null (getenv "LOGNAME")))
	(setenv "LOGNAME" (getenv "USER")))

    (unless (string= system-type "cygwin")
	   (ech-install-and-load 'cygwin-mount)
	   (cygwin-mount-activate))
    
    ;; Follow Cygwin symlinks.
    ;; Handles old-style (text file) symlinks and new-style (.lnk file) symlinks.
    ;; (Non-Cygwin-symlink .lnk files, such as desktop shortcuts, are still loaded as such.)
    (defun follow-cygwin-symlink ()
      "Follow Cygwin symlinks.
  Handles old-style (text file) and new-style (.lnk file) symlinks.
  \(Non-Cygwin-symlink .lnk files, such as desktop shortcuts, are still
  loaded as such.)"
      (save-excursion
	(goto-char 0)
	(if (looking-at
	     "L\x000\x000\x000\x001\x014\x002\x000\x000\x000\x000\x000\x0C0\x000\x000\x000\x000\x000\x000\x046\x00C")
	    (progn
	      (re-search-forward
	       "\x000\\([-A-Za-z0-9_\\.\\\\\\$%@(){}~!#^'`][-A-Za-z0-9_\\.\\\\\\$%@(){}~!#^'`]+\\)")
	      (find-alternate-file (match-string 1)))
	  (when (looking-at "!<symlink>")
	    (re-search-forward "!<symlink>\\(.*\\)\0")
	    (find-alternate-file (match-string 1))))))
    
    (add-hook 'find-file-hooks 'follow-cygwin-symlink)
    
    ;; Use Unix-style line endings.
    (setq-default buffer-file-coding-system 'undecided-unix)
    
    ;; Use /dev/null, not NUL.
    (setq null-device  "/dev/null")
    ;; Without this env var setting, Cygwin causes `ediff-buffers', at least, to raise an error.
    ;; Making this setting here might have no effect, as the env var is checked only by the first Cygwin process
    ;; invoked during your Windows session.  For best results, set this env var globally, in Windows itself.
    ;; An alternative might be to use `cygpath' to change from MS Windows file names to POSIX.
    (setenv "CYGWIN" "nodosfilewarning")
    
    ;; Add Cygwin Info pages
    (add-to-list 'Info-default-directory-list (expand-file-name "usr/info" cygwin-root-directory) 'APPEND)
    
    ;; Use `bash' as the default shell in Emacs.
  
    (setq shell-command-switch "-c")
    (setq explicit-shell-file-name bash-path)
    (setq shell-file-name "bash")
    
    (setq explicit-bash-file-name explicit-shell-file-name)
    (setq explicit-shell-args '("--noediting" "--login" "-i"))
    (setq explicit-bash.exe-args explicit-shell-args)
    (setenv "SHELL"  explicit-shell-file-name)
    
    (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
    (setq binary-process-input t)
    (setq w32-quote-process-args ?\")
   
    (setq ediff-shell               explicit-shell-file-name)    ; Ediff shell
    (setq multi-term-program explicit-bash-file-name)
    (setq comint-completion-addsuffix t)
    (setq comint-prompt-regexp "^[ \n\t]*[$] ?")
    (setq comint-eol-on-send t)
    ;; Remove C-m (^M) characters that appear in output
    (add-hook 'comint-output-filter-functions
	      'comint-strip-ctrl-m)
    (setq process-coding-system-alist
	  (cons '("bash" . (raw-text-dos . raw-text-unix)) process-coding-system-alist))

;;;;;###autoload
    (defun bash ()
      "Start `bash' shell."
      (interactive)
      (let ((binary-process-input t)
	    (binary-process-output nil))
	(shell)))
   
    (defun my-shell-setup ()
      "For Cygwin bash under Emacs 20"
      (setenv "PID" nil)
      (setq comint-scroll-show-maximum-output 'this)
      (make-variable-buffer-local 'comint-completion-addsuffix))
    
    (add-hook 'term-mode-hook 'my-shell-setup)
    ))
(provide 'cygwin-conf)
