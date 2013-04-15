(message "loading shell-conf ...")
(require 'term)

;(unless (require 'multi-term nil t)
;  (progn
;    (package-install 'multi-term)
;    (require 'multi-term)))

;(multi-term-keystroke-setup) 
;(global-set-key (kbd "<f2>") 'ansi-term)
;(global-set-key (kbd "S-<f2>") 'multi-term-next)

;(setq explicit-shell-file-name "/bin/bash")

(defun visit-ansi-term ()
  "If the current buffer is:
1) a running ansi-term named *ansi-term*, rename it.
2) a stopped ansi-term, kill it and create a new one.
3) a non ansi-term, go to an already running ansi-term
or start a new one while killing a defunt one"
  (interactive)
  (let ((is-term (string= "term-mode" major-mode))
        (is-running (term-check-proc (buffer-name)))
        (term-cmd (if (boundp 'explicit-shell-file-name) explicit-shell-file-name nil))
        (anon-term (get-buffer "*ansi-term*")))
    (if is-term
        (if is-running
            (if (string= "*ansi-term*" (buffer-name))
                (call-interactively 'rename-buffer)
              (if anon-term
                  (switch-to-buffer "*ansi-term*")
                (ansi-term term-cmd)))
          (kill-buffer (buffer-name))
          (ansi-term term-cmd))
      (if anon-term
          (if (term-check-proc "*ansi-term*")
              (switch-to-buffer "*ansi-term*")
            (kill-buffer "*ansi-term*")
            (ansi-term term-cmd))
        (ansi-term term-cmd)))))

; (get-buffer "*ansi-term*")
(global-set-key (kbd "<f2>") 'visit-ansi-term)

;(setq term-mode-hook ())
(add-hook 'term-mode-hook
	  '(lambda ()	     
	     (setq-local overflow-newline-into-fringe t)
	     ;(define-key term-raw-map (kbd "C-c C-j") 'term-line-mode)
	     (setq-local  autopair-dont-activate t)
	     (yas-minor-mode -1)
	     (ansi-color-for-comint-mode-on) 
	     (toggle-truncate-lines 1)
	     (setq-local comint-scroll-to-bottom-on-input t)  ; always insert at the bottom
	     (setq-local comint-scroll-to-bottom-on-output nil) ; always add output at the bottom
	     (setq-local comint-scroll-show-maximum-output t) ; scroll to show max possible output
	     (setq-local  comint-completion-autolist t)     ; show completion list when ambiguous
	     (setq-local comint-input-ignoredups t)           ; no duplicates in command history
	     (setq-local comint-completion-addsuffix t)       ; insert space/slash after file completion
	     (setq-local comint-buffer-maximum-size 50000)    ; max length of the buffer in lines
	     (setq-local comint-prompt-read-only nil)         ; if this is t, it breaks shell-command
	     (setq-local comint-get-old-input (lambda () "")) ; what to run when i press enter on a
	     (setq-local comint-input-ring-size 5000)         ; max shell history size
	     (setq-local  mouse-yank-at-point t)
	     (setq-local transient-mark-mode nil)
	     (auto-fill-mode -1)
	     (setq-local tab-width 8 )
))

;; truncate buffers continuously
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

; interpret and use ansi color codes in shell output windows
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(defun set-scroll-conservatively ()
  "Add to shell-mode-hook to prevent jump-scrolling on newlines in shell buffers."
  (set (make-local-variable 'scroll-conservatively) 10))
(add-hook 'shell-mode-hook 'set-scroll-conservatively)

(unless (string= window-system "w32")
  (setenv "PAGER" "cat")
  (setq-local explicit-shell-file-name "/bin/bash")
  (add-hook 'term-mode-hook 
	    '(lambda ()
	        (setq-local comint-use-prompt-regexp t)
		(setq-local shell-prompt-pattern "^[^$#\n]*[$#] ")
		(setq-local term-prompt-regexp "^[^$#>\n]*[$#>] *")
		(setq-local comint-prompt-regexp "^[^$#>\n]*[$#>] *"))))
			       
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
