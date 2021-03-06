;; set environment variables
(defvar core-dir (file-name-directory load-file-name) "core directory with main modules")
(defvar emacs-dir (file-name-directory (directory-file-name core-dir)) "directory that holds all emacs configuration")
(defvar site-lisp-dir (expand-file-name "site-lisp" emacs-dir) "directory with elisp file")
(defvar confs-dir (expand-file-name "confs" emacs-dir) "directory with all configuration files")


(defvar cygwin-root-directory
  (if (and (or (string= system-type "ms-dos") (string= system-type "windows-nt")) (getenv "CYGWIN_ROOT"))
      (getenv "CYGWIN_ROOT")
    "/")
  "Root directory of cygwin installation")

(when (or (string= system-type "ms-dos") (string= system-type "windows-nt") (string= system-type "cygwin")) 
  (defvar ech-use-cygwin t "use cygwin in ech-env"))

(add-to-list 'load-path confs-dir)
(add-to-list 'load-path core-dir)
(add-to-list 'load-path (expand-file-name "misc" site-lisp-dir))

;; initialized package
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t )
;;(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("sunrise" . "http://joseito.republika.pl/sunrise-commander/") t)
;;(add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/") t)
(setq package-load-list '(all))
(package-initialize)

;; load utility functions
(require 'utility-funcs)

(provide 'ech-env)
