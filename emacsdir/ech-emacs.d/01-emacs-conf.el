(setq max-specpdl-size 20000)
(setq max-lisp-eval-depth 20000)

(when (or (string= system-type "ms-dos") (string= system-type "windows-nt"))
  ;;(setq exec-path (append exec-path '("c:/Program Files/GetGnuWin32/gnuwin32/bin/dll")))
  ;;(setq exec-path (append exec-path '("c:/Program Files/GetGnuWin32/gnuwin32/bin")))
  ;; adding cygwin for bash command support
  (setq exec-path (append '("C:/cygwin/bin") exec-path)))

(add-to-list 'load-path (expand-file-name "misc" ech-site-lisp-dir))

;; enabling some functions
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

; by default don't set line truncation
(setq truncate-lines nil)
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
;  (progn
;    (delete-selection-mode 1)
;  )

;; Syntaxe highlighting pour tout
(require 'font-lock)
; (setq initial-major-mode
;       (lambda ()
;     (text-mode)
;     (font-lock-mode)))
; (setq font-lock-mode-maximum-decoration t
;       font-lock-use-default-fonts t
;       font-lock-use-default-colors t)

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
;(global-font-lock-mode 1)		;Color syntax highlighting
;(icomplete-mode 1)
(auto-compression-mode 1) ; Use compressed files as if they were normal
;(add-hook 'text-mode-hook 'auto-fill-mode)  ;auto-fill
;(auto-fill-mode -1)
(setq transient-mark-mode nil)		;highlights selections
(setq set-mark-command-repeat-pop t)
(setq comment-style 'plain)
(setq frame-title-format (list '("emacs ") '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;;-----------------------------------------------------------------------------
;; Windows only settings
;;-----------------------------------------------------------------------------
(defun windows-only-settings ()
  ;; What long lines should look like
  (set-fringe-mode (cons 0 8))
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
(server-start)

(setq visible-bell t)
(provide '01-emacs-conf)
