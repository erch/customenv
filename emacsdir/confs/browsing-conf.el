(require 'ech-env)
;; browsing with firefox
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

;; w3m configuration : w3m enabled per mode when necessary
(unless (locate-library "w3m")
    (package-install 'w3m))
(setq browse-url-browser-function 'w3m-browse-url)
(setq 
 w3m-pop-up-windows t
 w3m-pop-up-frames nil
 w3m-use-tab t)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;; optional keyboard short-cut
(global-set-key "\C-xm" 'browse-url-at-point)
(setq w3m-use-cookies t)
(setq w3m-pop-up-frames t)

(provide 'browsing-conf)
