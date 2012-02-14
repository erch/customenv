;; installation directory
(toggle-debug-on-error)
(setq site-lisp-dir (expand-file-name ".." (locate-library "site-start.el")))
(setq emacs-d-dir (expand-file-name "emacs.d" (file-name-directory  site-lisp-dir)))
(setq my-home-dir (expand-file-name "../.." (file-name-directory  site-lisp-dir)))

(add-to-list 'load-path emacs-d-dir)

;; loading stuff from emacs.d
(defun compile-if-newer-and-load (file)
  "Byte compile FILE.el if newer than file.elc."
  (let* ((file-ext (file-name-extension file))
	 (file-name 
	  (if (or (equal "el" file-ext) (equal "elc" file-ext)) 
	      (file-name-sans-extension file)
	    (file))))
    (if (file-newer-than-file-p (concat file-name ".el")
				(concat file-name ".elc"))
	(byte-compile-file (concat file-name ".el")))
    (load file-name)))
  
(mapcar 'compile-if-newer-and-load (sort (directory-files emacs-d-dir t ".*\\.el$") 'string<))
