(setq max-specpdl-size 20000)
(setq max-lisp-eval-depth 20000)

(when (or (string= system-type "ms-dos") (string= system-type "windows-nt"))
  ;;(setq exec-path (append exec-path '("c:/Program Files/GetGnuWin32/gnuwin32/bin/dll")))
  ;;(setq exec-path (append exec-path '("c:/Program Files/GetGnuWin32/gnuwin32/bin")))
  ;; adding cygwin for bash command support
  (setq exec-path (append '("C:/cygwin/bin") exec-path)))

(add-to-list 'load-path (expand-file-name "misc" site-lisp-dir))

;; enabling upcase and downcase
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

; by default don't set line truncation
(setq default-truncate-lines nil)
(setq truncate-partial-width-windows nil)

;; encoding in utf-8
(set-terminal-coding-system 'utf-8-emacs)
(set-keyboard-coding-system 'utf-8-emacs)
(set-language-environment 'utf-8)

; Laisser le curseur en place lors d'un défilement par pages.
; Par défaut, Emacs place le curseur en début ou fin d'écran
; selon le sens du défilement.
(setq scroll-preserve-screen-position t)

;  écrasement des lignes sélectionnées et lorsqu'on saisit du texte dans la foulée.
  (progn
    (delete-selection-mode 1)
  )

;; Syntaxe highlighting pour tout
(require 'font-lock)
(setq initial-major-mode
      (lambda ()
    (text-mode)
    (font-lock-mode)))
(setq font-lock-mode-maximum-decoration t
      font-lock-use-default-fonts t
      font-lock-use-default-colors t)

;; use find file at point bindings
(ffap-bindings)

(setq show-paren-style 'parenthesis) ; highlight just parens
(setq show-paren-style 'expression) 
;;(global-set-key "%" 'match-paren)

;; (defun match-paren (arg)
;;   "Go to the matching parenthesis if on parenthesis otherwise insert %."
;;   (interactive "p")
;;   (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;; 	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;; 	(t (self-insert-command (or arg 1))))) 

;; Backup
(defvar backup-dir (expand-file-name "~/.ebackup/"))
(defvar autosave-dir (expand-file-name "~/.eautosave/"))
(setq backup-directory-alist (list (cons ".*" backup-dir)))
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))

;; do not make backup files
;; (setq make-backup-files nil)

;; Some better defaults
(fset 'yes-or-no-p 'y-or-n-p)           ;replace y-e-s by y
(setq inhibit-startup-message t)        ;no splash screen
(setq ls-lisp-dirs-first t)             ;display dirs first in dired
(setq x-select-enable-clipboard t)	;use system clipboard
;(menu-bar-mode -1)			;hide menu-bar
;(scroll-bar-mode -1)			;hide scroll-bar
(tool-bar-mode -1)			;hide tool-bar
(column-number-mode 1)			;show column number
(global-font-lock-mode 1)		;Color syntax highlighting
(icomplete-mode 1)
(auto-compression-mode 1) ; Use compressed files as if they were normal
;(add-hook 'text-mode-hook 'auto-fill-mode)  ;auto-fill
(auto-fill-mode -1)
;(setq transient-mark-mode t)		;highlights selections
(setq comment-style 'plain)
(setq frame-title-format (list '("emacs ") '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;;-----------------------------------------------------------------------------
;; Windows only settings
;;-----------------------------------------------------------------------------
(defun windows-only-settings () 
  "This is a test"  
  (global-unset-key "\C-z")		;iconify-or-deiconify-frame (C-x C-z)

  ;; What long lines should look like
  (set-fringe-mode (cons 0 8))

  (defun w32-maximize-frame ()
    "Maximize the current frame (windows only)"
    (interactive)
    (w32-send-sys-command 61488))

  (if (equal system-name "CALDERA1049")
      (w32-maximize-frame))

  (if (equal system-name "CALDERA1065")
      (progn (set-frame-position (selected-frame) 0 0)
	     (set-frame-width (selected-frame) 80)
	     (set-frame-height (selected-frame) 65)))

  ;; prompts for font and returns string (utility function)
  (defun insert-x-style-font() 
    "Insert a string in the X format which describes a font the
user can select from the Windows font selector."
    (interactive) 
    (insert (prin1-to-string (w32-select-font))))

  ;; tabbar
  (require 'tabbar)
  (setq tabbar-buffer-groups-function 
	(lambda (b) (list "All Buffers")))
  (setq tabbar-buffer-list-function
	(lambda ()
	  (remove-if
	   (lambda(buffer)
	     ; Only show a couple buffers with * in their names
	     (or (and (find (aref (buffer-name buffer) 0) " *")
		      (not (equal (buffer-name buffer) "*eshell*"))
		      (not (equal (buffer-name buffer) "*mpg123*")))
		 (equal (buffer-name buffer) "calendar.diary")
		 (equal (buffer-name buffer) "diary")))
	   (buffer-list))))

  (global-set-key [(meta P)] 'tabbar-backward)
  (global-set-key [(meta N)] 'tabbar-forward)

)

;;-----------------------------------------------------------------------------
;; Console only settings
;;-----------------------------------------------------------------------------
(defun console-only-settings () 
  (interactive)
  ;; Scroll wheel and mouse in console rock! 
  ;; but they only work in emacs 21 with these settings
  (require 'xt-mouse)
  (xterm-mouse-mode t)
  (mouse-wheel-mode t)

  ;; does this work ?
  (if (load "mwheel" t)
      (mwheel-install))
)

;; Load Windows or Console settings
(when (string= window-system "w32") (windows-only-settings))
(when (eq window-system nil) (console-only-settings))

; start emacs server
;(and (= emacs-major-version 23) (defun server-ensure-safe-dir (dir) (message "def ensure") t))
;(let ((f "~/.emacs.d/server"))
;      (set-file-modes f 700)) 
;(server-ensure-safe-dir ".")
(server-start)

(add-to-list 'completion-ignored-extensions  ".svn/")
(setq completion-auto-help "lazy")
;(setq iswitchb-mode t)
(setq visible-bell t)

(if (boundp 'compilation-error-regexp-alist)
    (add-to-list 'compilation-error-regexp-alist (list "^\\(.*\\):\\[\\([0-9]*\\),\\([0-9]*\\)\\]" 1 2 3))
  (setq compilation-error-regexp-alist (list (list "^\\(.*\\):\\[\\([0-9]*\\),\\([0-9]*\\)\\]" 1 2 3))))

;; (setq compilation-error-regexp-alist nil)
