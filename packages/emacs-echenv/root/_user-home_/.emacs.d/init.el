;; placeholder
(cond
 ((or (string= system-type "ms-dos") (string= system-type "windows-nt"))
  nil)
 ((string= system-type "cygwin")
  nil)
 (t nil))

(setq init-dir (file-name-directory load-file-name))
(setq emacs-dir (expand-file-name "customenv/emacsdir" (getenv "MY_ENV")))
(setq ech-site-lisp-dir (expand-file-name "ech-lisp-site" emacs-dir))
(setq ech-emacs-d-dir (expand-file-name "ech-emacs.d" emacs-dir))
(add-to-list 'load-path ech-emacs-d-dir)

(setq prelude-modules-file (expand-file-name "prelude-modules.el" (file-name-directory load-file-name)))
;;folder stores all the automatically generated save/history-files.
(setq prelude-savefile-dir (expand-file-name "~/.ebackup"))
(setq prelude-dir (expand-file-name "emacs-prelude" (getenv "WIN_OPT")))

;; initialized package
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t )
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/") t)
(setq package-load-list '(all))
(package-initialize)

;; load needed files for all other configuration files
(require '01-emacs-conf)
(require '02-utility-funcs)

;; compile files in emacs.d
(defun compile-if-newer (file)
  "Byte compile FILE.el if newer than file.elc."
  (let* ((file-ext (file-name-extension file))
	 (file-name
	  (if (or (equal "el" file-ext) (equal "elc" file-ext))
	      (file-name-sans-extension file)
	    (file))))
    (if (file-newer-than-file-p (concat file-name ".el")
				(concat file-name ".elc"))
	(byte-compile-file (concat file-name ".el")))))  

;; (mapcar 'compile-if-newer (sort (directory-files ech-emacs-d-dir t ".*\\.el$") 'string<))
;; (mapcar 'compile-if-newer (sort (directory-files (expand-file-name "core" prelude-dir) t ".*\\.el$") 'string<))
;; (mapcar 'compile-if-newer (sort (directory-files (expand-file-name "modules" prelude-dir) t ".*\\.el$") 'string<))

(server-start)

;;folder stores all the automatically generated save/history-files.
(setq prelude-savefile-dir (expand-file-name "~/.ebackup"))
(load (expand-file-name "init.el" prelude-dir))


