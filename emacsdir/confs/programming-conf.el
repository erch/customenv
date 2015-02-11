(require 'ech-env)
(require 'spelling-conf)
(require 'ido)

(ech-install-and-load 'rainbow-mode)
(ech-install-and-load 'rainbow-delimiters)
(ech-install-and-load 'flycheck)
(ech-install-and-load 'flycheck-pos-tip '(("melpa" . "http://melpa.org/packages/")))

(defun prog-mode-defaults ()
  "Default coding hook, useful with any programming language."
  (when (and (boundp 'ispell-program-name) (executable-find ispell-program-name))
    (flyspell-prog-mode))
  (setq-local comment-auto-fill-only-comments t)
  (smartparens-mode +1)
  (smartparens-strict-mode -1)
  (rainbow-delimiters-mode +1)
  (whitespace-mode -1)
  (flycheck-mode)
  (setq-local flycheck-check-syntax-automatically '(save  mode-enabled idle-change))
  (setq-local flycheck-completion-system 'ido)
  (setq-local flycheck-display-errors-function 'flycheck-pos-tip-error-messages)
  (font-lock-add-keywords
   nil '(("\\<\\(\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):\\)"
          1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook 'prog-mode-defaults)

(provide 'programming-conf)






