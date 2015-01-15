(eval-and-compile 
 (add-to-list 'load-path (expand-file-name "w3m" site-lisp-dir))
 (require 'w3m-load)
 ;;(setq browse-url-browser-function 'w3m-browse-url)
 ;;(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
 ;; optional keyboard short-cut
 (global-set-key "\C-xm" 'browse-url-at-point)
 (setq w3m-use-cookies t)
 (setq w3m-pop-up-frames t)
)