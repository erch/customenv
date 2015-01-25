(require 'ech-env)
(load "tramp")
(eval-and-compile
(if (or (string= system-type "ms-dos") (string= system-type "windows-nt"))
  (setq tramp-default-method "sshx")
  (setq tramp-default-method "ssh"))
  (setq tramp-verbose 10)
  (setq tramp-debug-buffer t))

(provide 'tramp-conf)
