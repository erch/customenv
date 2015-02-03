;;; ech-env --- Sumary
;;; Commentary:
;; init file for emacs configuration

;;; Code:
(let ((core-d (expand-file-name "customenv/emacsdir/core" (getenv "MY_ENV"))))
  (add-to-list 'load-path core-d))

(require 'ech-env)

;; load utility functions
(require 'utility-funcs)

;; compile configuration files if not yet done
(mapcar 'compile-if-newer (sort (directory-files confs-dir t ".*\\.el$") 'string<))

;; start emacs server for emacsclient
(server-start)

;; load the mode
(require 'ech-mode)

;; load configuration files
(requires-files confs-dir)

;; install the mode at the end so that it overide all key mappings
(ech-mode +1)
