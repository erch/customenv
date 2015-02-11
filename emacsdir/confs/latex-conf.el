(require 'ech-env)
(require 'completion-conf)
(require 'parens-conf)

(ech-install-and-load 'auctex nil t)
(ech-install-and-load 'cdlatex nil t)

(require 'smartparens-latex)

(eval-after-load "company"
  '(progn
     (ech-install-and-load 'company-auctex '(("melpa" . "http://melpa.org/packages/")))
     (company-auctex-init)))

;; AUCTeX configuration
(setq TeX-auto-save t)
(setq TeX-parse-self t)

(setq-default TeX-master nil)

;; use pdflatex
(setq TeX-PDF-mode t)

;; sensible defaults for OS X, other OSes should be covered out-of-the-box
(when (eq system-type 'darwin)
  (setq TeX-view-program-selection
        '((output-dvi "DVI Viewer")
          (output-pdf "PDF Viewer")
          (output-html "HTML Viewer")))

  (setq TeX-view-program-list
        '(("DVI Viewer" "open %o")
          ("PDF Viewer" "open %o")
          ("HTML Viewer" "open %o"))))

(defun latex-mode-hook ()
  "hook for `LaTeX-mode'."
  (turn-on-auto-fill)
  (abbrev-mode +1)
  (smartparens-mode +1)
  (LaTeX-math-mode 1))

(add-hook 'LaTeX-mode-hook 'latex-mode-hook)

(provide 'latex-conf)

;;; prelude-latex.el ends here
