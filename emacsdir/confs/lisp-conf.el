
(require 'ech-env)
(require 'programming-conf)
(require 'yasnippet-conf)
(require 'parens-conf)

(ech-install-and-load 'elisp-slime-nav)

;; remove annoying pair with single quote
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)

;; stolen from prelude
(defun prelude-recompile-elc-on-save ()
  "Recompile your elc when saving an elisp file."
  (add-hook 'after-save-hook
            (lambda ()
              (when (file-exists-p (byte-compile-dest-file buffer-file-name))
                (emacs-lisp-byte-compile)))
            nil
            t))

(defun prelude-visit-ielm ()
  "Switch to default `ielm' buffer.
Start `ielm' if it's not already running."
  (interactive)
  (prelude-start-or-switch-to 'ielm "*ielm*"))

(define-key emacs-lisp-mode-map (kbd "C-c C-z") 'prelude-visit-ielm)
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-defun)
(define-key emacs-lisp-mode-map (kbd "C-c C-b") 'eval-buffer)

(setq flycheck-emacs-lisp-load-path `inherit)
(defun emacs-lisp-mode-hook ()
  "Customization hook for elisp buffers."
  (setq-local flycheck-checkers '(emacs-lisp))
  (eldoc-mode +1)
  (prelude-recompile-elc-on-save)
  (rainbow-mode +1)
  (activate-yasnippet-buffer-local-with-dirs
   (list (expand-file-name "snippets" (file-name-directory emacs-dir)))))

(add-hook 'emacs-lisp-mode-hook 'emacs-lisp-mode-hook)
(add-hook 'ielm-mode-hook 'emacs-lisp-mode-hook)

(eval-after-load "elisp-slime-nav"
  '(diminish 'elisp-slime-nav-mode))
(eval-after-load "rainbow-mode"
  '(diminish 'rainbow-mode))
(eval-after-load "eldoc"
  '(diminish 'eldoc-mode))

;; enable elisp-slime-nav-mode
(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'elisp-slime-nav-mode))

(defun conditionally-enable-smartparens-mode ()
  "Enable `smartparens-mode' in the minibuffer, during `eval-expression'."
  (if (eq this-command 'eval-expression)
      (smartparens-mode 1)))

(add-hook 'minibuffer-setup-hook 'conditionally-enable-smartparens-mode)

(provide 'lisp-conf)
