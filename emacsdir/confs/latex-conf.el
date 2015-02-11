(require 'ech-env)
(require 'completion-conf)
(require 'parens-conf)

(ech-install-and-load 'auctex t)  ; THE latex mode
(ech-install-and-load 'cdlatex t) ; minor mode, supporting fast insertion of environment templates
					; and math stuff in LaTeX
(require 'smartparens-latex)  ;; adds pairs for latex

(ech-install-and-load  'company-auctex)
(ech-install-and-load 'company-math)

(company-auctex-init)

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
  (LaTeX-math-mode 1)
  (turn-on-cdlatex)
  (setq-local company-backends
              (append
	       '(company-math-symbols-latex company-latex-commands company-math-symbols-unicode)
	       company-backends)))

(add-hook 'LaTeX-mode-hook 'latex-mode-hook)

(provide 'latex-conf)

;;; prelude-latex.el ends here
