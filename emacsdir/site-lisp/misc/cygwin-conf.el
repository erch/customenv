(require 'ech-env)
;;(require 'shell-conf)
(require 'ech-mode)

(when ech-use-cygwin
  (let ((bin-dir (expand-file-name "bin" cygwin-root-directory)))
    (add-to-list 'exec-path bin-dir)
    (setq bash-path (expand-file-name "bash.exe" bin-dir)))
  ;;   LOGNAME and USER are expected in many Emacs packages. Check these environment variables.
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

  ;;  (ech-install-and-load 'cygwin-mount)
  ;;  (cygwin-mount-activate)
  ;;
  ;;  ;; Follow Cygwin symlinks.
  ;;  ;; Handles old-style (text file) symlinks and new-style (.lnk file) symlinks.
  ;;  ;; (Non-Cygwin-symlink .lnk files, such as desktop shortcuts, are still loaded as such.)
  ;;  (defun follow-cygwin-symlink ()
  ;;    "Follow Cygwin symlinks.
  ;;Handles old-style (text file) and new-style (.lnk file) symlinks.
  ;;\(Non-Cygwin-symlink .lnk files, such as desktop shortcuts, are still
  ;;loaded as such.)"
  ;;    (save-excursion
  ;;      (goto-char 0)
  ;;      (if (looking-at
  ;;	   "L\x000\x000\x000\x001\x014\x002\x000\x000\x000\x000\x000\x0C0\x000\x000\x000\x000\x000\x000\x046\x00C")
  ;;	  (progn
  ;;	    (re-search-forward
  ;;	     "\x000\\([-A-Za-z0-9_\\.\\\\\\$%@(){}~!#^'`][-A-Za-z0-9_\\.\\\\\\$%@(){}~!#^'`]+\\)")
  ;;	    (find-alternate-file (match-string 1)))
  ;;	(when (looking-at "!<symlink>")
  ;;	  (re-search-forward "!<symlink>\\(.*\\)\0")
  ;;	  (find-alternate-file (match-string 1))))))
  ;;  (add-hook 'find-file-hooks 'follow-cygwin-symlink)
  ;;
  ;;  ;; Use Unix-style line endings.
  ;;  (setq-default buffer-file-coding-system 'undecided-unix)
  ;;
  ;;  ;; Use /dev/null, not NUL.
  ;;  (setq null-device  "/dev/null")
  ;;  ;; Without this env var setting, Cygwin causes `ediff-buffers', at least, to raise an error.
  ;;  ;; Making this setting here might have no effect, as the env var is checked only by the first Cygwin process
  ;;  ;; invoked during your Windows session.  For best results, set this env var globally, in Windows itself.
  ;;  ;; An alternative might be to use `cygpath' to change from MS Windows file names to POSIX.
  ;;  (setenv "CYGWIN" "nodosfilewarning")
  ;;
  ;;  ;; Add Cygwin Info pages
  ;;  (add-to-list 'Info-default-directory-list (expand-file-name "usr/info" cygwin-root-directory) 'APPEND)
  ;;
  ;;  ;; Use `bash' as the default shell in Emacs.

  (setq explicit-shell-file-name bash-path)
  (setq shell-file-name "bash")
  (setq explicit-bash.exe-args '("--noediting" "--login" "-i"))
  (setenv "SHELL" shell-file-name)
  (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)

  (setq binary-process-input t)
  (setq w32-quote-process-args ?\")
  (setenv "SHELL" bash-path)
  ;;(setq explicit-shell-file-name "C:\\MyHome\\cygwin_site\\usr_local\\sbin\\cygwin.bat")

  
  (setq ediff-shell               shell-file-name)    ; Ediff shell
  (setq multi-term-program  "bash")
  ;;(setq comint-completion-addsuffix '("/" . ""))
  ;(setq comint-completion-addsuffix t)
  ;(setq comint-prompt-regexp "^[ \n\t]*[$] ?")
  ;(setq comint-eol-on-send t)
  ;;  ;; Remove C-m (^M) characters that appear in output
  ;;  (add-hook 'comint-output-filter-functions
  ;;	    'comint-strip-ctrl-m)
  ;;
  ;;
;;;;;###autoload
  ;;  (defun bash ()
  ;;    "Start `bash' shell."
  ;;    (interactive)
  ;;    (let ((binary-process-input t)
  ;;	  (binary-process-output nil))
  ;;      (shell)))
  ;;
  ;;  (setq process-coding-system-alist
  ;;	(cons '("bash" . (raw-text-dos . raw-text-unix)) process-coding-system-alist))
  ;;
  ;;
  ;;  ;; From: http://www.dotfiles.com/files/6/235_.emacs
  ;;  ;;###autoload
  ;;  (defun set-shell-bash()
  ;;    "Enable on-the-fly switching between the bash shell and DOS."
  ;;    (interactive)
  ;;    ;; (setq binary-process-input t)
  ;;    (setq shell-file-name "bash")
  ;;    (setq shell-command-switch "-c")      ; SHOULD IT BE (setq shell-command-switch "-ic")?
  ;;    (setq explicit-shell-file-name "bash")
  ;;    (setenv "SHELL" explicit-shell-file-name)
  ;;    ;;(setq explicit-sh-args '("-login" "-i")) ; Undefined?
  ;;    (setq w32-quote-process-args ?\") ;; "
  ;;    ;;(setq mswindows-quote-process-args t)) ; Undefined?
  ;;    )
  ;;
  ;;  ;;###autoload
  ;;  (defun set-shell-cmdproxy()
  ;;    "Set shell to `cmdproxy'."
  ;;    (interactive)
  ;;    (setq shell-file-name "cmdproxy")
  ;;    (setq explicit-shell-file-name "cmdproxy")
  ;;    (setenv "SHELL" explicit-shell-file-name)
  ;;    ;;(setq explicit-sh-args nil)           ; Undefined?
  ;;    (setq w32-quote-process-args nil))
  (defun my-shell-setup ()
    "For Cygwin bash under Emacs 20"
    (setenv "PID" nil)
    (setq comint-scroll-show-maximum-output 'this)
    (make-variable-buffer-local 'comint-completion-addsuffix))



(defun term-exec-1 (name buffer command switches)
  ;; We need to do an extra (fork-less) exec to run stty.
  ;; (This would not be needed if we had suitable Emacs primitives.)
  ;; The 'if ...; then shift; fi' hack is because Bourne shell
  ;; loses one arg when called with -c, and newer shells (bash,  ksh) don't.
  ;; Thus we add an extra dummy argument "..", and then remove it.
  (let ((process-environment
	 (nconc
	  (list
	   (format "TERM=%s" term-term-name)
	   (format "TERMINFO=%s" data-directory)
	   (format term-termcap-format "TERMCAP="
		   term-term-name term-height term-width)
	   ;; We are going to get rid of the binding for EMACS,
	   ;; probably in Emacs 23, because it breaks
	   ;; `./configure' of some packages that expect it to
	   ;; say where to find EMACS.
	   (format "EMACS=%s (term:%s)" emacs-version term-protocol-version)
	   (format "INSIDE_EMACS=%s,term:%s" emacs-version term-protocol-version)
	   (format "LINES=%d" term-height)
	   (format "COLUMNS=%d" term-width))
	  process-environment))
	(process-connection-type t)
	;; We should suppress conversion of end-of-line format.
	(inhibit-eol-conversion t)
	;; The process's output contains not just chars but also binary
	;; escape codes, so we need to see the raw output.  We will have to
	;; do the decoding by hand on the parts that are made of chars.
	(coding-system-for-read 'binary))
     (apply 'start-process name buffer
	   "bash" "-c"
	   (format "stty -nl echo rows %d columns %d sane 2>/dev/null;\
if [ $1 = .. ]; then shift; fi; exec \"$@\""
		   term-height term-width)
	   ".."
	   "bash" switches)))
  
  )
(provide 'cygwin-conf)
