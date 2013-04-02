(unless (require 'smartparens nil t)
  (progn
    (package-install 'smartparens)
    ;(load-library "smartparens"))
))
(require 'smartparens)
(smartparens-global-mode 1)

;; highlights matching pairs
(show-smartparens-global-mode t)

;(setq show-paren-delay 0)           ; how long to wait?
;(show-paren-mode nil)                 ; turn paren-mode off
;;(setq show-paren-style 'expression) ; alternatives are 'parenthesis' and 'mixed'

;; (defun match-paren (arg)
;;   "Go to the matching parenthesis if on parenthesis otherwise insert %."
;;   (interactive "p")
;;   (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;; 	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;; 	(t (self-insert-command (or arg 1))))) 


;;;;;;;;;;;;;;;;;;;;;;;;
;; configuration from: https://github.com/Fuco1/smartparens/wiki/Example-configuration

(define-key sp-keymap (kbd "C-M-f") 'sp-forward-sexp)
(define-key sp-keymap (kbd "C-M-b") 'sp-backward-sexp)
  
(define-key sp-keymap (kbd "C-M-d") 'sp-down-sexp)
(define-key sp-keymap (kbd "C-M-a") 'sp-backward-down-sexp)

(define-key sp-keymap (kbd "C-M-e") 'sp-up-sexp)
(define-key sp-keymap (kbd "C-M-u") 'sp-backward-up-sexp)

(define-key sp-keymap (kbd "C-M-n") 'sp-next-sexp)
(define-key sp-keymap (kbd "C-M-p") 'sp-previous-sexp)

;; (define-key sp-keymap (kbd "C-M-k") 'sp-kill-sexp)
;; (define-key sp-keymap (kbd "M-<delete>") 'sp-unwrap-sexp)
;; (define-key sp-keymap (kbd "M-<backspace>") 'sp-backward-unwrap-sexp)
;; (define-key sp-keymap (kbd "C-<right>") 'sp-forward-slurp-sexp)
;; (define-key sp-keymap (kbd "C-<left>") 'sp-forward-barf-sexp)
;; (define-key sp-keymap (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
;; (define-key sp-keymap (kbd "C-M-<right>") 'sp-backward-barf-sexp)

;; (define-key sp-keymap (kbd "M-D") 'sp-splice-sexp)
;; (define-key sp-keymap (kbd "C-M-<delete>") 'sp-splice-sexp-killing-forward)
;; (define-key sp-keymap (kbd "C-M-<backspace>") 'sp-splice-sexp-killing-backward)
;; (define-key sp-keymap (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around)
;; 
;; (define-key sp-keymap (kbd "C-]") 'sp-select-next-thing-exchange)
;; (define-key sp-keymap (kbd "C-<left_bracket>") 'sp-select-previous-thing)
;; (define-key sp-keymap (kbd "C-M-]") 'sp-select-next-thing)

(define-key sp-keymap (kbd "M-F") 'sp-forward-symbol)
(define-key sp-keymap (kbd "M-B") 'sp-backward-symbol)

  ;;;;;;;;;;;;;;;;;;
;; pair management

;;  (sp-local-pair 'minibuffer-inactive-mode "'" nil :actions nil)

;;  ;;; markdown-mode
;;  (sp-with-modes '(markdown-mode gfm-mode rst-mode)
;;    (sp-local-pair "*" "*")
;;    (sp-local-tag "2" "**" "**")
;;    (sp-local-tag "s" "```scheme" "```")
;;    (sp-local-tag "<"  "<_>" "</_>" :transform 'sp-match-sgml-tags))

  ;;; tex-mode latex-mode
;;  (sp-with-modes '(tex-mode plain-tex-mode latex-mode)
;;    (sp-local-tag "i" "e23b2c0677aefe835963afab98e797186e9ccec0quot;<" "e23b2c0677aefe835963afab98e797186e9ccec0quot;>"))

  ;;; html-mode
;;  (sp-with-modes '(html-mode sgml-mode)
;;  (sp-local-pair "<" ">"))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom defuns and macros
(defun my-wrap-with-paren (&optional arg)
  "Select ARG next things and wrap them with a () pair."
  (interactive "p")
  (sp-select-next-thing-exchange arg)
  (execute-kbd-macro (kbd "(")))
(define-key sp-keymap (kbd "C-(") 'my-wrap-with-paren)
(provide 'parens-conf)

