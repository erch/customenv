(require 'ech-env)
(require 'ech-mode)

;; Nav not so much cool because it opens a window anywhere, not just on frame boarder.
;(ech-install-and-load 'nav)
;(define-key ech-mode-map ech-key-run-nav 'nav)

;; Ido :  “Interactively DO things” enhances Emacs’s completion engine for file and buffers , the “Ido-powered” completion engine matches anywhere in a name, instead of just the beginning
;; use helm instead of ido
;;(ech-install-and-load 'ido-ubiquitous)
;;(require 'ido)
;;(setq ido-enable-flex-matching t)
;;(ido-mode 1)
;;(ido-ubiquitous-mode t)
;;(setq ido-create-new-buffer 'always) ;; avoid ido asking for creation of new buffer when no file/buffer match the
;;(setq ido-use-filename-at-point 'guess) ; look for a filename at point as the starting point for filename selection.
;;(setq ido-use-url-at-point 't) ; look at point if there is an url as starting ...

;; enabled looking in cdargs list of directory
(when (locate-library "cdargs.el")
  (require 'cdargs)
  (define-key ech-mode-map (kbd "C-c C-v") 'cdargs)
)   

;; remote access to file
(require 'tramp)

(eval-and-compile
(if (or (string= system-type "ms-dos") (string= system-type "windows-nt"))
  (setq tramp-default-method "sshx")
  (setq tramp-default-method "ssh"))
  (setq tramp-verbose 10)
  (setq tramp-debug-buffer t))

;; ibuffer: lets you operate on buffers much in the same manner as Dired. The most important Ibuffer features are highlighting and various alternate layouts
(require 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("dired" (mode . dired-mode))
               ("java" (mode . java-mode))
               ("org" (mode . org-mode))
               ("sql" (mode . sql-mode))
               ("xml" (mode . nxml-mode))
	       ("python"  (mode . python-mode))
	      ("perl" (mode . perl-mode))
	      ))))
(setq ibuffer-show-empty-filter-groups nil)
(add-hook 'ibuffer-mode-hook
 (lambda ()
  (ibuffer-switch-to-saved-filter-groups "default")
  (ibuffer-filter-by-name "^[^*]")
  (ibuffer-filter-by-filename "."))) ;; to show only dired and files buffers
(define-key ech-mode-map (kbd "C-x C-b") 'ibuffer)


;; sunrise commander : OFM (“Orthodox File Manager”) for emacs
(ech-install-and-load 'sunrise-commander)
(ech-install-and-load 'sunrise-x-popviewer)
(ech-install-and-load 'sunrise-x-tree)
(ech-install-and-load 'sunrise-x-tabs)
(setq sr-terminal-program 'ansi-term) ; use ansi term instead of eshell
(define-key ech-mode-map (kbd ech-key-run-sunrise) 'sunrise)
(provide 'file-dirs-config)
