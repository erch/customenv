;; set environment variables
(defvar core-dir (file-name-directory load-file-name) "core directory with main modules")
(defvar emacs-dir (file-name-directory (directory-file-name core-dir)) "directory that holds all emacs configuration")
(defvar site-lisp-dir (expand-file-name "site-lisp" emacs-dir) "directory with elisp file")
(defvar confs-dir (expand-file-name "confs" emacs-dir) "directory with all configuration files")
(add-to-list 'load-path confs-dir)
(add-to-list 'load-path core-dir)
(add-to-list 'load-path (expand-file-name "misc" site-lisp-dir))

;; initialized package
(require 'package)
;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t ) ;; avoid duplication with marmelade
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("sunrise" . "http://joseito.republika.pl/sunrise-commander/") t)
;;(add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/") t)
(setq package-load-list '(all))
(package-initialize)


;; menu bar+ requires to be loaded before all other module that can change th menu bar
(unless (package-installed-p 'menu-bar+)
  (package-install 'menu-bar+))
(eval-after-load "menu-bar" '(require 'menu-bar+))

;; load cl-seq once here (no require in it ??)
(load-library "cl-seq")

;; load key definitions
(require 'ech-keydefs)
;; load utility functions
(require 'utility-funcs)

(provide 'ech-env)
