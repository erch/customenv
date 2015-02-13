;;; ech-env --- Sumary
;;; Commentary:
;; init file for emacs configuration

;;; Code:
(let ((core-d (expand-file-name "customenv/emacsdir/core" (getenv "MY_ENV"))))
  (add-to-list 'load-path core-d))

(require 'load-ech-env)
