(message "loading shell-conf ...")
(require 'ech-env)
(require 'term)

(if ech-use-cygwin
    (require 'cygwin-conf)
  (progn
    (setenv "PAGER" "cat")
    (setq explicit-shell-file-name "/bin/bash")
    (add-hook 'term-mode-hook 
	      '(lambda ()
		 (setq-local comint-prompt-regexp "^[^$#\n]*[$#] *")
		 (setq-local comint-use-prompt-regexp t)
		 (setq-local shell-prompt-pattern comint-prompt-regexp)
		 (setq-local term-prompt-regexp comint-prompt-regexp)
		 )))
  
(ech-install-and-load 'multi-term)
(ech-install-and-load 'isend-mode)
(ech-install-and-load 'helm-mt)
(global-set-key (kbd "C-x t") 'helm-mt)
(setq isend-forward-line nil)
(setq isend-strip-empty-lines t)
(setq isend-delete-indentation t)
(setq isend-end-with-empty-line t)

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
     (let* (
 	   (beg (progn (beginning-of-line) (term-skip-prompt) (point)))
 	   (end (progn (end-of-line) (point)))
 	   (nbdel (- end beg))
 	   (input (if (> nbdel 0) (buffer-substring-no-properties beg end) "")))
       (when (> nbdel 0)	        
 	(message "beg : %d, end : %d , input %s - going to delete %d char" beg end input nbdel)
 	;(term-send-raw-string (make-string nbdel ?\C-? )))
 	(term-send-invisible (make-string nbdel ?\C-? )))
       input)))


(defadvice term-line-mode (around clean-process-input-before-line-mode disable)
  (interactive)
  (let* (
	 (pos (point))
	 (proc (get-buffer-process (current-buffer)))
	 (end (progn (end-of-line) (point)))
	 (beg (progn (beginning-of-line) (term-skip-prompt) (point)))
	 (input-before (buffer-substring-no-properties beg pos))
	 (input-after (buffer-substring-no-properties pos end)))
    (message "switching to line mode: %s->%s" input-before input-after)
    ;;(insert (myterm-clear-process-input))
    ;(goto-char pos)
    (term-send-string proc "\C-a\C-k")
    ;(goto-char (+ 2 beg))
    ;(set-marker (process-mark proc) (point))
    ad-do-it
    ;(save-excursion
      ;; Insert the text, advancing the process marker.
     ;(goto-char (process-mark proc))
    (let ((markpos (point)))
     (insert (concat input-before input-after)))
     ;(set-marker (process-mark proc) markpos))
    ;(goto-char pos)
))
 
;; -------------- from mutli-term.el

; The key list that will need to be unbind.
(setq term-unbind-key-list
  '("C-z" "C-x" "C-l" "C-c" "C-h" "C-y" "M-x"))
 
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
    ("C-r" . myterm-send-reverse-search-history)
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

(defun myterm-send-reverse-search-history ()
  "Search history reverse."
  (interactive)
  (term-send-raw-string "\C-r"))

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
 
(progn (setq term-mode-hook ())(setq yas-after-exit-snippet-hook ())(setq yas-before-expand-snippet-hook ()))

(add-hook 'term-mode-hook
	  '(lambda ()	  
	     (myterm-keystroke-setup)
	     (setq-local overflow-newline-into-fringe t)
	     (define-key term-raw-map (kbd "C-c C-j") 'term-line-mode)
	     (setq-local  autopair-dont-activate t)
	     (activate-yasnippet-buffer-local-with-dirs (list (expand-file-name "snippets" (file-name-directory emacs-dir))))
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
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

; interpret and use ansi color codes in shell output windows
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(defun set-scroll-conservatively ()
  "Add to shell-mode-hook to prevent jump-scrolling on newlines in shell buffers."
  (set (make-local-variable 'scroll-conservatively) 10))

(add-hook 'shell-mode-hook 'set-scroll-conservatively)

)			       
(message "shell-conf loaded")    
(provide 'shell-conf)
