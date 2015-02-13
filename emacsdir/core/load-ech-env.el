(require 'ech-env)
;; compile configuration files if not yet done
(mapc 'compile-if-newer (sort (directory-files confs-dir t ".*\\.el$") 'string<))
(mapc 'compile-if-newer (sort (directory-files core-dir t ".*\\.el$") 'string<))
;; start emacs server for emacsclient
(server-start)

;; menu bar+ requires to be loaded before all other module that can change th menu bar
(unless (package-installed-p 'menu-bar+)
  (package-install (make-symbol "menu-bar+")))
(eval-after-load "menu-bar" '(require 'menu-bar+))

;; load the minor mode
(require 'ech-mode)

;; load configuration files
(requires-files confs-dir)

(provide 'load-ech-env)
