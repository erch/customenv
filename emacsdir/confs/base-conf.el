(require 'ech-env)
(setq max-specpdl-size 20000)
(setq max-lisp-eval-depth 20000)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; enabled change region case commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; enable narrowing commands
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

;; enable erase-buffer command
(put 'erase-buffer 'disabled nil)

;; encoding in utf-8
(set-terminal-coding-system 'utf-8-emacs)
(set-keyboard-coding-system 'utf-8-emacs)
(set-language-environment 'utf-8)

(setq x-select-enable-clipboard t)	;use system clipboard
(column-number-mode 1)			;show column number
(auto-compression-mode 1) ; Use compressed files as if they were normal

;; put backup files in a specific directory
(setq backup-dir (expand-file-name "~/.ebackup"))
;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist `((".*" . ,backup-dir)))
(setq auto-save-file-name-transforms `((".*" ,backup-dir t)))

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; smart tab behavior - always indent
(setq tab-always-indent t)

;; meaningful names for buffers with the same name
(ech-install-and-load 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;; bookmarks
(require 'bookmark)
(setq bookmark-default-file (expand-file-name "bookmarks" backup-dir)
      bookmark-save-flag 1)

;; anzu-mode enhances isearch & query-replace by showing total matches and current match position
(ech-install-and-load 'anzu)
(diminish 'anzu-mode)
(global-anzu-mode)

(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

;; dired - reuse current buffer by pressing 'a'
(put 'dired-find-alternate-file 'disabled nil)

;; always delete and copy recursively
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

;; if there is a dired buffer displayed in the next window, use its
;; current subdir, instead of the current subdir of this dired buffer
(setq dired-dwim-target t)

;; enable some really cool extensions like C-x C-j(dired-jump)
(require 'dired-x)

;; ediff - don't start another frame
(require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; clean up obsolete buffers automatically
(require 'midnight)

;; smarter kill-ring navigation
(ech-install-and-load 'browse-kill-ring)
(browse-kill-ring-default-keybindings)
(global-set-key (kbd "s-y") 'browse-kill-ring)

;; saner regex syntax
(require 're-builder)
(setq reb-re-syntax 'string)

(setq visible-bell t)
(provide 'base-conf)
