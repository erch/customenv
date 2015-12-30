(require 'ech-env)
(eval-and-compile
  (add-to-list 'auto-mode-alist '("\\.xml\\'" . nxml-mode))
  (add-to-list 'auto-mode-alist '("\\.xsd\\'" . nxml-mode))
  (add-hook 'nxhtml-mode-hook 'flyspell-mode)
  (setq nxml-child-indent 4)
)
(provide 'xml-conf)
