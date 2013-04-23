(message "loading shell-conf ...")

;(load-file (expand-file-name "misc/term.el" site-lisp-dir))
(require 'term)

(defun visit-ansi-term ()
  "If the current buffer is:
1) a running ansi-term named *ansi-term*, rename it.
2) a stopped ansi-term, kill it and create a new one.
3) a non ansi-term, go to an already running ansi-term
or start a new one while killing a defunt one"
  (interactive)
  (let ((is-term (string= "term-mode" major-mode))
        (is-running (term-check-proc (buffer-name)))
        (term-cmd (if (boundp 'explicit-shell-file-name) explicit-shell-file-name "/bin/bash"))
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

(defun mode-line-record-prev-mode()
  (make-local-variable 'char-mode-beforep)
  (setq char-mode-beforep (term-in-char-mode))
  (term-line-mode)
)

(defun restore-line-or-char-mode()
  (when (boundp 'char-mode-beforep)
    (message "ok")
    (if char-mode-beforep (term-char-mode))))

(defun mygetpoint ()
  (interactive)
  (message "at %d" (point)))

(defun myterm-clear-process-input()
  "clear all char send to the sub process for a non yet executed line"
  (interactive)
  (save-excursion
    (let* ((end (progn (end-of-line) (point)))
	   (beg (progn (beginning-of-line) (term-skip-prompt) (point)))
	   (nbdel (- end beg))
	   (input (if (> nbdel 0) (buffer-substring-no-properties beg end) "")))
      (when (> nbdel 0)	        
	(message "beg : %d, end : %d , input %s - going to delete %d char" beg end input nbdel)
	;(term-send-raw-string (make-string nbdel ?\C-? )))
	(term-send-invisible (make-string nbdel ?\C-? )))
      input)))

(defadvice term-line-mode (before clean-process-input-before-line-mode activate)
  (message "before switching to line mode")
  (myterm-clear-process-input))

;; -------------- from mutli-term.el

; The key list that will need to be unbind.
(setq term-unbind-key-list
  '("C-z" "C-x" "C-c" "C-h" "C-y" "<ESC>"))
 
;; The key alist that will need to be bind.
;; If you do not like default setup, modify it, with (KEY . COMMAND) format.
(setq term-bind-key-alist
  '(
    ("C-<rigth>" . myterm-send-backward-word)
    ("C-c C-c" . term-interrupt-subjob)
    ("C-p" . term-previous-prompt)
    ("C-n" . term-next-prompt)
    ("M-s" . isearch-forward)
    ("M-r" . isearch-backward)
    ("C-m" . term-send-raw)
  
    ("M-f" . myterm-send-forward-word)
    ("C-<left>" . myterm-send-backward-word)
    ("M-b" . myterm-send-backward-word)
    ("M-o" . term-send-backspace)
    ("M-p" . term-send-up)
    ("M-n" . term-send-down)
    ("M-M" . myterm-send-forward-kill-word)
    ("M-N" . myterm-send-backward-kill-word)
    ("C-r" . term-send-reverse-search-history)
   ; ("M-," . term-send-input)
    ("M-." . comint-dynamic-complete)))

(defun myterm-send-backward-kill-word ()
  "Backward kill word in term mode."
  (interactive)
  (term-send-raw-string "\C-w"))

(defun myterm-send-forward-kill-word ()
  "Kill word in term mode."
  (interactive)
  (term-send-raw-string "\ed"))

(defun myterm-send-backward-word ()
  "Move backward word in term mode."
  (interactive)
  (term-send-raw-string "\eb"))

(defun myterm-send-forward-word ()
  "Move forward word in term mode."
  (interactive)
  (term-send-raw-string "\ef"))

(defun myterm-keystroke-setup ()
  "Keystroke setup of `term-char-mode'.

By default, the key bindings of `term-char-mode' conflict with user's keystroke.
So this function unbinds some keys with `term-raw-map',
and binds some keystroke with `term-raw-map'."
  (let (bind-key bind-command)
    ;; Unbind base key that conflict with user's keys-tokes.
    (dolist (unbind-key term-unbind-key-list)
      (cond
       ((stringp unbind-key) (setq unbind-key (read-kbd-macro unbind-key)))
       ((vectorp unbind-key) nil)
       (t (signal 'wrong-type-argument (list 'array unbind-key))))
      (define-key term-raw-map unbind-key nil))
    ;; Add some i use keys.
    ;; If you don't like my keystroke,
    ;; just modified `term-bind-key-alist'
    (dolist (element term-bind-key-alist)
      (setq bind-key (car element))
      (setq bind-command (cdr element))
      (cond
       ((stringp bind-key) (setq bind-key (read-kbd-macro bind-key)))
       ((vectorp bind-key) nil)
       (t (signal 'wrong-type-argument (list 'array bind-key))))
      (define-key term-raw-map bind-key bind-command))))

;------------------------------------

(defun term-myget-new-input ()
  "Return new input Take chars from beginning of line to the point, and discard any initial text matching term-prompt-regexp."
  (save-excursion
    (let* ((beg (progn (beginning-of-line) (term-skip-prompt) (point)))
	   (end (progn (end-of-line) (point)))	   
	   (text (buffer-substring-no-properties beg end)))
	   (message (concat "input is : " text))
	   text)))

;(progn (setq term-mode-hook ())(setq yas-after-exit-snippet-hook ())(setq yas-before-expand-snippet-hook ()))
(add-hook 'term-mode-hook
	  '(lambda ()	  
	     (myterm-keystroke-setup)
	     (setq-local overflow-newline-into-fringe t)
	     (define-key term-raw-map (kbd "C-c C-j") 'term-line-mode)
	     (setq-local  autopair-dont-activate t)
	     (activate-yasnippet-buffer-local-with-dirs (list (expand-file-name "snippets" (file-name-directory emacs-d-dir))))
	     (ansi-color-for-comint-mode-on) 
	     (toggle-truncate-lines -1)
	     (setq-local comint-scroll-to-bottom-on-input t)  ; always insert at the bottom
	     (setq-local comint-scroll-to-bottom-on-output nil) ; always add output at the bottom
	     (setq-local comint-scroll-show-maximum-output t) ; scroll to show max possible output
	     (setq-local  comint-completion-autolist t)     ; show completion list when ambiguous
	     (setq-local comint-input-ignoredups t)           ; no duplicates in command history
	     (setq-local comint-completion-addsuffix t)       ; insert space/slash after file completion
	     (setq-local comint-buffer-maximum-size 50000)    ; max length of the buffer in lines
	     (setq-local comint-prompt-read-only nil)         ; if this is t, it breaks shell-command
	     (setq-local comint-get-old-input 'term-myget-new-input) ; what to run when i press enter on a	  
	     (setq-local comint-input-ring-size 5000)         ; max shell history size
	     (setq-local  mouse-yank-at-point t)
	     (setq-local transient-mark-mode nil)	     
	     (add-hook 'yas-after-exit-snippet-hook 'restore-line-or-char-mode nil t)
	     (add-hook 'yas-before-expand-snippet-hook 'mode-line-record-prev-mode nil t)
	     (auto-fill-mode -1)
	     (setq-local tab-width 8 )
))

;; truncate buffers continuously
;(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

; interpret and use ansi color codes in shell output windows
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(defun set-scroll-conservatively ()
  "Add to shell-mode-hook to prevent jump-scrolling on newlines in shell buffers."
  (set (make-local-variable 'scroll-conservatively) 10))
;(add-hook 'shell-mode-hook 'set-scroll-conservatively)

(unless (string= window-system "w32")
  (setenv "PAGER" "cat")
  (setq explicit-shell-file-name "/bin/bash")
  (add-hook 'term-mode-hook 
	    '(lambda ()
	       (setq-local comint-prompt-regexp "^[^$#\n]*[$#] *")
	       (setq-local comint-use-prompt-regexp t)
		(setq-local shell-prompt-pattern comint-prompt-regexp)
		(setq-local term-prompt-regexp comint-prompt-regexp)
		))
)
			       
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


(defun term-send-input ()
  "Send input to process.
After the process output mark, sends all text from the process mark to
point as input to the process.  Before the process output mark, calls value
of variable `term-get-old-input' to retrieve old input, copies it to the
process mark, and sends it.  A terminal newline is also inserted into the
buffer and sent to the process.  The list of function names contained in the
value of `term-input-filter-functions' is called on the input before sending
it.  The input is entered into the input history ring, if the value of variable
`term-input-filter' returns non-nil when called on the input.

Any history reference may be expanded depending on the value of the variable
`term-input-autoexpand'.  The list of function names contained in the value
of `term-input-filter-functions' is called on the input before sending it.
The input is entered into the input history ring, if the value of variable
`term-input-filter' returns non-nil when called on the input.

If variable `term-eol-on-send' is non-nil, then point is moved to the
end of line before sending the input.

The values of `term-get-old-input', `term-input-filter-functions', and
`term-input-filter' are chosen according to the command interpreter running
in the buffer.  E.g.,

If the interpreter is the csh,
    term-get-old-input is the default: take the current line, discard any
        initial string matching regexp term-prompt-regexp.
    term-input-filter-functions monitors input for \"cd\", \"pushd\", and
	\"popd\" commands.  When it sees one, it cd's the buffer.
    term-input-filter is the default: returns t if the input isn't all white
	space.

If the term is Lucid Common Lisp,
    term-get-old-input snarfs the sexp ending at point.
    term-input-filter-functions does nothing.
    term-input-filter returns nil if the input matches input-filter-regexp,
        which matches (1) all whitespace (2) :a, :c, etc.

Similarly for Soar, Scheme, etc."
  (interactive)
  ;; Note that the input string does not include its terminal newline.
  (let ((proc (get-buffer-process (current-buffer))))
    (if (not proc) (error "Current buffer has no process")
      (let* ((pmark (process-mark proc))
	     (pmark-val (marker-position pmark))
	     (input-is-new (>= (point) pmark-val))
	     (intxt (if input-is-new
			(progn (if term-eol-on-send (end-of-line))
			       (buffer-substring pmark (point)))
		      (funcall term-get-old-input)))
	     (input (if (not (eq term-input-autoexpand 'input))
			;; Just whatever's already there
			intxt
		      ;; Expand and leave it visible in buffer
		      (term-replace-by-expanded-history t)
		      (buffer-substring pmark (point))))
	     (history (if (not (eq term-input-autoexpand 'history))
			  input
			;; This is messy 'cos ultimately the original
			;; functions used do insertion, rather than return
			;; strings.  We have to expand, then insert back.
			(term-replace-by-expanded-history t)
			(let ((copy (buffer-substring pmark (point))))
			  (delete-region pmark (point))
			  (insert input)
			  copy))))
	(when (term-pager-enabled)
	  (save-excursion
	    (goto-char (process-mark proc))
	    (setq term-pager-count (term-current-row))))
	(when (and (funcall term-input-filter history)
		   (or (null term-input-ignoredups)
		       (not (ring-p term-input-ring))
		       (ring-empty-p term-input-ring)
		       (not (string-equal (ring-ref term-input-ring 0)
					  history))))
	  (ring-insert term-input-ring history))
	(let ((functions term-input-filter-functions))
	  (while functions
	    (funcall (car functions) (concat input "\n"))
	    (setq functions (cdr functions))))
	(setq term-input-ring-index nil)

	;; Update the markers before we send the input
	;; in case we get output amidst sending the input.
	(set-marker term-last-input-start pmark)
	(set-marker term-last-input-end (point))
	(when input-is-new
	  ;; Set up to delete, because inferior should echo.
	  (when (marker-buffer term-pending-delete-marker)
	    (delete-region term-pending-delete-marker pmark))
	  (set-marker term-pending-delete-marker pmark-val)
	  (set-marker (process-mark proc) (point)))
	(goto-char pmark)
	(funcall term-input-sender proc input)))))
