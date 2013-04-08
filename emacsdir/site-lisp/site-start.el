;;; site-start.el ---
;; installation directory
;;; Code:

(toggle-debug-on-error)

(setq site-lisp-dir (expand-file-name ".." (locate-library "site-start.el")))
(setq emacs-d-dir (expand-file-name "emacs.d" (file-name-directory  site-lisp-dir)))
(setq my-home-dir (expand-file-name "../.." (file-name-directory  site-lisp-dir)))
(add-to-list 'load-path emacs-d-dir)


;; 

(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t )
(setq package-initialize nil)
(setq package-load-list '(all))

(package-initialize)


; load needed files for all other configuration files
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

(mapcar 'compile-if-newer (sort (directory-files emacs-d-dir t ".*\\.el$") 'string<))

;; load configuration files
(defun requires-files(dir)
  (mapcar (lambda (x) 
	    (let* ((sym (file-name-sans-extension (file-name-nondirectory x))))
	      (progn  
	      (require (intern sym) nil t)
	      (message (concat "done for " sym))))) 
	  (sort  (directory-files dir t ".*\\.elc$") 'string<)))

(requires-files emacs-d-dir)

(provide 'site-start)

(require '01-emacs-conf nil t)
;;; site-start.el ends here
