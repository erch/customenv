(if (or (string= system-type "ms-dos") (string= system-type "windows-nt"))
    (progn 
      (add-to-list 'exec-path "C:\\cygwin\\bin")
      (setq multi-term-program "bash --login -i"))
  (setq multi-term-program "/bin/bash"))
(add-to-list 'load-path (expand-file-name "misc" site-lisp-dir))
(require 'multi-term)
(multi-term-keystroke-setup) 
(global-set-key (kbd "<f2>") 'multi-term)
(global-set-key (kbd "S-<f2>") 'multi-term-next)

(add-hook 'term-mode-hook
      '(lambda ()
	 (define-key term-raw-map (kbd "C-c C-j") 'term-line-mode)
	 (setq multi-term-scroll-show-maximum-output t)))



