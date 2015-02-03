(setq core-dir (file-name-directory load-file-name))
(setq emacs-dir (file-name-directory (directory-file-name core-dir)))
(setq site-lisp-dir (expand-file-name "site-lisp" emacs-dir))
(setq confs-dir (expand-file-name "confs" emacs-dir))
(add-to-list 'load-path confs-dir)
(add-to-list 'load-path core-dir)
(add-to-list 'load-path (expand-file-name "misc" site-lisp-dir))

;; initialized package
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t )
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
;;(add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/") t)
(setq package-load-list '(all))
(package-initialize)


(unless (package-installed-p 'menu-bar+)
  (package-install 'menu-bar+))

(eval-after-load "menu-bar" '(require 'menu-bar+))

;; load utility functions
(require 'utility-funcs)

(provide 'ech-env)
