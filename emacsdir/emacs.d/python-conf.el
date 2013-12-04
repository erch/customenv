(message "loading python-conf ...")
;; add python to exec path
(add-to-list 'exec-path "/usr/bin")

(unless (locate-library "python-pkg")
  (progn
    (package-install 'python))
)

(require 'python)
(require 'completion-conf)
(require 'highlight-conf)
(require 'yasnippet-conf)
(require 'outline-conf)

(unless (require 'pyvirtualenv nil t)
  (progn
    (package-install 'pyvirtualenv)
    (require 'pyvirtualenv)
    ))

(unless (require 'nose nil t)
  (progn
    (package-install 'nose)
    (require 'nose)
))

(unless (locate-library "elpy")
  (progn
    (package-install 'elpy)
    (require 'elpy))
)

(defun my-get-python-buffer-name()
  (format "*%s*" (python-shell-get-process-name nil))
)

;; overide function to fix a bug
(defadvice elpy-shell-get-or-create-process (around elpy-shell-get-or-create-process-fixed activate)
  "Fix missing arg  when calling python-run."
  (let* ((bufname (my-get-python-buffer-name))
         (proc (get-buffer-process bufname)))
    (if proc
        proc
      (run-python nil (python-shell-parse-command))
      (get-buffer-process bufname))))


(defadvice elpy-shell-send-region-or-buffer (around elpy-shell-send-region-or-buffer-fixed activate)
  "Fix issue with indentation the switch to the shell buffer"
  ;; Ensure process exists
  (elpy-shell-get-or-create-process)
  (if (region-active-p)
;; A temporary buffer is used to apply filters
      (let ((origin (current-buffer))
	    (begin (region-beginning))
	    (end (region-end)))
	(with-temp-buffer
	  (setq filtered (current-buffer))
	  (insert-buffer-substring origin begin end)
	  ;;  Apply filters on the region
	  (delete-matching-lines "^[[:space:]]*$" (point-min) (point-max))
	  (goto-char (point-min))
	  (back-to-indentation)
	  (indent-rigidly (point-min) (point-max) (- (current-column)))
	  (goto-char (point-max))
	  (insert "\n")
	  (python-shell-send-region (point-min) (point-max))))
    (python-shell-send-buffer ad-set-args 0))
  (elpy-shell-switch-to-shell)
)

(defadvice elpy-shell-switch-to-shell (around  elpy-shell-switch-to-shell-fixed activate)
  "Switch to inferior Python process buffer."
  (interactive)
  (switch-to-buffer-other-window (process-buffer (elpy-shell-get-or-create-process))))


(setq elpy-mode-map (make-sparse-keymap))
(unless (require 'elpy nil t)
  (progn
    (package-install 'elpy)
    (require 'elpy)
))


(setq mypython-mode-map  
      (create-menu-and-key-bindings 
       "Python"
       '(
	 ("Navigation"
	  ["Nav menu" "Navigation menu" imenu  (kbd "C-c C-g n")]
	  ["Goto definition" "Jump to symbol definition" elpy-goto-definition (kbd "C-c C-g d")]
	  "--"
	  ["Find Occurrences" "Find Occurrences" elpy-occur-definitions (kbd "C-c C-g c")]
	  "--"
	  ["Beginning of def" "Move point to the beginning of def or class" python-beginning-of-defun-function (kbd "M-{")]
	  ["End of def" "Move point to end of def or class" python-end-of-defun-function (kbd "M-}")]
	  ["Move to next definition" "Forward definition" elpy-forward-definition  (kbd "M-S-n")]
	  ["Move to previous definition" "Backward definition" elpy-backward-definition  (kbd "M-S-p")]
	  ["Move to next Statement" "Forward Statement" elpy-nav-forward-statement (kbd "M-n")]
	  ["Move to previous Statement" "Backwared Statement" elpy-nav-backward-statement  (kbd "M-p")]
	  )
	 ("Project"
	  ["Set project root" "Set project root" elpy-set-project-root (kbd "C-c C-p r")]
	  "--"
	  ["Find file" "Find file" find-file-in-project (kbd "C-c C-p f")]
	  ["Grep symbol in project" "Grep in project" elpy-rgrep-symbol (kbd "C-c C-p g")]
	  )
	 ("Source"
	  ["Check" "Check" elpy-check (kbd "C-c C-s c")]
	  "--"
	  ["Show Snipets" "shows all possible snippets that can be expanded here" yas-insert-snippet]
	  ["Complete" "Auto complete complete" ac-complete]
	  )
	 ("Documentation"
	  ["Show documentation" "Show symbol at point documentation" elpy-doc (kbd "C-c C-d C-s")]
	  ["Search documentation" "Search documentation" elpy-pydoc-completions (kbd "C-c C-d S")]
	  ["Browse documentation" "Browse python documentation" pyde-doc-show (kbd "C-c C-d s")]
	  ["Browse symbol documentation" "Browse documentation for symbol at point" pylookup-lookup (kbd "C-c C-d b")]
	  )
	 ("Test"
	  ["Run nose" "Run nose test" elpy-test  (kbd "C-c C-t t")]
	  ["Test one" "Test one" nosetests-one (kbd "C-c C-t o")]
	  ["Test module debug" "Test module debug" nosetests-pdb-one (kbd "C-c C-t C-f")]
	  ["Test all debug" "Test all debug" nosetests-pdb-all (kbd "C-c C-t C-a")]
	  ["Test one debug" "Test one debug" nosetests-pdb-one (kbd "C-c C-t C-o")]
	  ["Test module" "Test module" nosetests-module (kbd "C-c C-t f")]
	  ["Test all" "Test all" nosetests-all (kbd "C-c C-t a")]
	  )
	 ("Refactor"
	  ["Show refactor menu" "Show refactor" elpy-refactor (kbd "C-c C-r s")]
	  )
	 ("Process"
	  ["Send defun" "Send defun" python-shell-send-defun (kbd "C-c C-i f")]
	  ["Send region or buffer" "Send region or buffer" elpy-shell-send-region-or-buffer (kbd "C-c C-i s")]
	  ["Switch to shell" "Switch to shell" elpy-shell-switch-to-shell (kbd "C-c C-i g")]
	  ["Start Python" "Start a Python interpreter" elpy-shell-get-or-create-process (kbd "C-c C-i r")]
	  )
	 )))

;; try to block the display of menu from python and elpy keymaps
(let ((blocking-map (make-sparse-keymap)))
  (define-key blocking-map [menu-bar] nil)
  (set-keymap-parent python-mode-map elpy-mode-map)
  (set-keymap-parent elpy-mode-map blocking-map)
  (set-keymap-parent blocking-map mypython-mode-map))

(defun modify-python-keymap()
  ;(define-key ropemacs-local-keymap [menu-bar] nil)
  (use-local-map mypython-mode-map)
  ;(setq python-mode-map (make-sparse-keymap))
)

(setq elpy-default-minor-modes '(eldoc-mode))

;; Browse online documentation ;
; Check https://github.com/tsgates/pylookup
(let ((pylookup-dir (file-name-as-directory (expand-file-name "pylookup-pkg"  site-lisp-dir))))
  (add-to-list 'load-path pylookup-dir)
  (require 'pylookup)
  (setq pylookup-program  (expand-file-name "pylookup.py"  pylookup-dir))
  (setq pylookup-db-file (expand-file-name "pylookup.db" "~/.emacs.d")))

;; 
(defun mygetoutline-level()
  "debug function that print the level of outline"
  (interactive)
  (message "%d" (funcall outline-level)))

(defun myheader-search()
  "debug function that searches in a line for the header used by outline"
  (interactive)
  (save-excursion
    (let* ((beg (point-at-bol))
	  (end (point-at-eol))
	  (str (buffer-substring beg end)) ;; same as (current-line-string)
	  (m (string-match-p "^[ \t]*\\(class\\|def\\|if\\|elif\\|else\\|while\\|for\\|try\\|except\\|finally\\|with\\|import\\|from\\)\\( \\|:\\)" str)))
      (message "string : [%s] = %s" str (if m "OK" "NOK")))))

(defun mypy-outline-level ()
  "function used by outline to get the level of a line"
   (save-excursion
     (let* (
 	   (buffer-invisibility-spec)
 	   (first-not-blank-pos (progn (beginning-of-line) (skip-chars-forward " \t"))))
       (+ 1 (/ first-not-blank-pos python-indent-offset)))))

(defun elpy-mode-setup-hook ()
  (modify-python-keymap)
  "hook to python mode"
  ;; add custom directory of snippets
  (activate-yasnippet-buffer-local-with-dirs (list (expand-file-name "snippets" (file-name-directory emacs-d-dir)) (concat (file-name-directory (locate-library "elpy")) "snippets/")))
  (setq-local python-guess-indent nil)

  ;; activation of outline.
  (setq-local python-indent-offset 4)
  (activate-outline-buffer-local "[ \t]*\\(class\\|def\\|if\\|elif\\|else\\|while\\|for\\|try\\|except\\|finally\\|with\\|import\\|from\\)\\( \\|:\\)" "\n" python-indent-offset)
  
  ;; `flymake-no-changes-timeout': The original value of 0.5 is too
  ;; short for Python code, as that will result in the current line to
  ;; be highlighted most of the time, and that's annoying. This value
  ;; might be on the long side, but at least it does not, in general,
  ;; interfere with normal interaction.
  (setq-local flymake-no-changes-timeout 60)

  ;; `flymake-start-syntax-check-on-newline': This should be nil for
  ;; Python, as;; most lines with a colon at the end will mean the next
  ;; line is always highlighted as error, which is not helpful and
  ;; mostly annoying.
  (setq-local flymake-start-syntax-check-on-newline nil)
  
  ;; Set `forward-sexp-function' to nil in python-mode. See
  ;; http://debbugs.gnu.org/db/13/13642.html
  (setq forward-sexp-function nil)
  ;; Enable warning faces for flake8 output.
  (when (string-match "flake8" python-check-command)
    (set (make-local-variable 'flymake-warning-re) "^W[0-9]"))

  ;; browse documentation with w3m
  (setq-local
   browse-url-browser-function 'w3m-browse-url)
  ; change key bindings and menu
  
  )

(add-hook 'elpy-mode-hook 'elpy-mode-setup-hook)
(setq elpy-rpc-backend "rope")
(elpy-enable t)

(message "python-conf loaded.")
(provide 'python-conf)

;; Rope keymap
;; ================  ============================
;; Key               Command
;; ================  ============================
;; C-x p o           rope-open-project
;; C-x p k           rope-close-project
;; C-x p f           rope-find-file
;; C-x p 4 f         rope-find-file-other-window
;; C-x p u           rope-undo
;; C-x p r           rope-redo
;; C-x p c           rope-project-config
;; C-x p n [mpfd]    rope-create-(module|package|file|directory)
;; \                 rope-write-project
;; \
;; C-c r r           rope-rename
;; C-c r l           rope-extract-variable
;; C-c r m           rope-extract-method
;; C-c r i           rope-inline
;; C-c r v           rope-move
;; C-c r x           rope-restructure
;; C-c r u           rope-use-function
;; C-c r f           rope-introduce-factory
;; C-c r s           rope-change-signature
;; C-c r 1 r         rope-rename-current-module
;; C-c r 1 v         rope-move-current-module
;; C-c r 1 p         rope-module-to-package
;; \
;; C-c r o           rope-organize-imports
;; C-c r n [vfcmp]   rope-generate-(variable|function|class|module|package)
;; \
;; C-c r a /         rope-code-assist
;; C-c r a g         rope-goto-definition
;; C-c r a d         rope-show-doc
;; C-c r a f         rope-find-occurrences
;; C-c r a ?         rope-lucky-assist
;; C-c r a j         rope-jump-to-global
;; C-c r a c         rope-show-calltip
;; \                 rope-analyze-module
;; \
;; \                 rope-auto-import
;; \                 rope-generate-autoimport-cache
;; ================  ============================
;; 
;; 
;; Shortcuts
;; ---------
;; 
;; Some commands are used very frequently; specially the commands in
;; code-assist group.  You can define your own shortcuts like this::
;; 
;;   (define-key ropemacs-local-keymap "\C-cg" 'rope-goto-definition)
;; 
;; Ropemacs itself comes with a few shortcuts:
;; 
;; ================  ============================
;; Key               Command
;; ================  ============================
;; M-/               rope-code-assist
;; M-?               rope-lucky-assist
;; C-c g             rope-goto-definition
;; C-c d             rope-show-doc
;; C-c f             rope-find-occurrences
;; ================  ============================


