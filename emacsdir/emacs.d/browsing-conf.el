; browsing with firefox
(when (or (string= system-type "ms-dos") (string= system-type "windows-nt") (string= system-type "cygwin"))
  (let (
	(firefoxprog
	 (locate-file "firefox" (mapcar (lambda(x) (concat x "/Mozilla Firefox/")) (list (getenv "PROGRAMFILES")(getenv "PROGRAMFILESX86")))  exec-suffixes)))
    (progn
     (setq   browse-url-firefox-program firefoxprog)
    ;; (setq exec-path (append exec-path '(file-name-os (file-name-directory firefoxprog))))
    )))

(defun ech-browse-file(file &rest args)
  "add file:// to file for browsing with firefox"
  (browse-url-default-browser
   (if (or (string-match "http://" file) (string-match "file://" file))
       file
     (concat "file://" file))
   args))

(setq browse-url-browser-function 'ech-browse-file
      browse-url-new-window-flag  t
      browse-url-firefox-new-window-is-tab t)

;;(add-to-list 'load-path (expand-file-name "w3m" site-lisp-dir))
;;(require 'w3m-load)
;;(setq browse-url-browser-function 'w3m-browse-url)
;;(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;; optional keyboard short-cut
(global-set-key "\C-xm" 'browse-url-at-point)
(setq w3m-use-cookies t)
(setq w3m-pop-up-frames t)
;;(ech-browse-file "c:/MyHome/dev/java/jdk1.5.0_18/docs/api")
(provide 'browsing-conf)
