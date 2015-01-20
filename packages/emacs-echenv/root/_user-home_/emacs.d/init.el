;; init.el


;; placeholder
(cond
 ((or (string= system-type "ms-dos") (string= system-type "windows-nt"))
  nil)
 ((string= system-type "cygwin")
  nil)
 (t nil))

(load (expand-file-name "/emacs-prelude/init.el" (getenv "WIN_OPT")))
