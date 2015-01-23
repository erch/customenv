;; placeholder
(cond
 ((or (string= system-type "ms-dos") (string= system-type "windows-nt"))
  nil)
 ((string= system-type "cygwin")
  nil)
 (t nil))

(setq init-dir (file-name-directory load-file-name))
(setq emacs-dir (expand-file-name "customenv/emacsdir" (getenv "MY_ENV")))
(setq ech-site-lisp-dir (expand-file-name "ech-site-lisp" emacs-dir))
(setq ech-emacs-d-dir (expand-file-name "ech-emacs.d" emacs-dir))
(add-to-list 'load-path ech-emacs-d-dir)
(add-to-list 'load-path (expand-file-name "misc" ech-site-lisp-dir))

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

(require 'helm-conf)
(require 'display-conf)
(require 'custom-conf)
(require 'calendar-conf)
;;(require '03-cygwin-conf)
(require 'browsing-conf)
(require 'calendar-conf)
(require 'cdargs-conf)
;;(require 'cedet-conf)  ; doesn't work
(require 'completion-conf)
(require 'crontab-conf)
(require 'custom-conf)
(require 'display-conf)
;;(require 'groovy-conf)
(require 'helm-conf)
;;(require 'highlight-conf)
;;(require 'ido-conf)
;; (require 'java-conf) ; requires cedet
(require 'json-conf)
(require 'lisp-conf)
(require 'org-conf)
(require 'outline-conf)
(require 'parens-conf)
(require 'pgg-conf)
(require 'pig-mode-conf)
;(require 'python-conf)
(require 'shell-conf)
(require 'spelling-conf)
(require 'sql-conf)
(require 'taskjuggler-conf)
(require 'tramp-conf)
(require 'twiki-conf)
(require 'vm-config)
(require 'web-conf)
(require 'xml-conf)
(require 'yasnippet-conf)
