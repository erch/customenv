(message "loadind cedet-conf ...")

;; cedet is loaded from site-start.el file to avoid conflicts with emacs default installation of cedet.

(require 'semantic)
(require 'semantic-ia)
(require 'semanticdb-javap)

(defun activate-cedet-buffer-local()
  ;(setq-local semantic-default-submodes (quote (global-semantic-highlight-func-mode global-semantic-decoration-mode global-semantic-stickyfunc-mode global-semantic-idle-completions-mode global-semantic-idle-scheduler-mode global-semanticdb-minor-mode global-semantic-idle-summary-mode global-semantic-mru-bookmark-mode global-semantic-idle-local-symbol-highlight-mode global-semantic-highlight-edits-mode global-semantic-show-unmatched-syntax-mode global-semantic-show-parser-state-mode)))
  ;(semantic-mode 1)
  (semantic-load-enable-gaudy-code-helpers)
)

(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)

(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  (add-to-list 'ac-sources 'ac-source-gtags)
  (add-to-list 'ac-sources 'ac-source-semantic))

(add-hook 'c-mode-common-hook 'my-cedet-hook)

(message "cedet-conf loaded.")
(provide 'cedet-conf)
