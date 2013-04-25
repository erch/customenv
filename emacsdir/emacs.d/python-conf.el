(message "loading python-conf ...")

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

;; Browse online documentation ;
; Check https://github.com/tsgates/pylookup
(let ((pylookup-dir (file-name-as-directory (expand-file-name "pylookup-dir"  site-lisp-dir))))
  (add-to-list 'load-path pylookup-dir)
  (require 'pylookup)
  (setq pylookup-program  (file-name-as-directory(expand-file-name "pylookup.py"  pylookup-dir)))
  (setq pylookup-db-file (expand-file-name "pylookup.db" "~/.emacs.d")))

(unless (string= window-system "w32")
  (progn
    (unless (require 'pyde nil t)
      (progn
	(package-install 'pyde)
	(require 'pyde)))
    (pyde-enable)
    (pyde-clean-modeline)
    ;; Flymake support using flake8, including warning faces.
    (if (executable-find "flake8")
	(setq python-check-command "flake8")
      (setq python-check-command "pylint"))
    ;; bug fix
    (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
      (setq flymake-check-was-interrupted t))
    (ad-activate 'flymake-post-syntax-check)
    ))

(defun mygetoutline-level()
  "debug function that print the level of outline"
  (interactive)
  (message "%d" (funcall outline-level)))

(defun myheader-search()
  "debug function that searc in a line for a regexp"
  (interactive)
  (save-excursion
    (let* ((beg (point-at-bol))
	  (end (point-at-eol))
	  (str (buffer-substring beg end)) ;; same as (current-line-string)
	  (m (string-match-p "^[ \t]*\\(class\\|def\\|if\\|elif\\|else\\|while\\|for\\|try\\|except\\|finally\\|with\\|import\\|from\\)\\( \\|:\\)" str)))
      (message "string : [%s] = %s" str (if m "OK" "NOK")))))

(defun mypy-outline-level ()
  "will be used by outline to get the level of a line"
   (save-excursion
     (let* (
 	   (buffer-invisibility-spec)
 	   (first-not-blank-pos (progn (beginning-of-line) (skip-chars-forward " \t"))))
       (+ 1 (/ first-not-blank-pos python-indent-offset)))))

(defun python-mode-setup-hook ()
  "hook to python mode"
  ;; add custom directory of snippets
  (activate-yasnippet-buffer-local-with-dirs (list (expand-file-name "snippets" (file-name-directory emacs-d-dir))))
  (setq-local python-guess-indent nil)

  ;; activation of outline.
  (setq-local python-indent-offset 4)
  (activate-outline-buffer-local "[ \t]*\\(class\\|def\\|if\\|elif\\|else\\|while\\|for\\|try\\|except\\|finally\\|with\\|import\\|from\\)\\( \\|:\\)" "\n" 'mypy-outline-level)
  
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
  ; change key bindings and menu
  (modify-python-keymap)
  )

(defun modify-python-keymap()
  (setq-local pyde-mode-map nil)
  (setq-local ropemacs-local-keymap nil)
  (setq-local python-mode-map mypython-mode-map))

(defun define-mypython-mode-map()
  (setq mypython-mode-map (make-sparse-keymap))
  ;; (define-prefix-command 'document-bindings)
  ;; Navigation
  (define-key mypython-mode-map (kbd "C-c C-g n") 'imenu)
  (define-key mypython-mode-map (kbd "C-c C-g d") 'rope-goto-definition)
  (define-key mypython-mode-map (kbd "C-c C-g m") 'rope-pop-mark)
  (define-key mypython-mode-map (kbd "C-c C-g g") 'rope-jump-to-global)
  (define-key mypython-mode-map (kbd "C-c C-g f") 'rope-find-file)
  (define-key mypython-mode-map (kbd "C-c C-g c") 'rope-find-occurrences)
  (define-key mypython-mode-map (kbd "C-c C-g i") 'rope-find-implementations)
  (define-key mypython-mode-map (kbd "M-e") 'pyde-nav-forward-statement)
  (define-key mypython-mode-map (kbd "M-a") 'pyde-nav-backward-statement)
  ;; Test
  (define-key mypython-mode-map (kbd "C-c C-t a") 'nosetests-all)
  (define-key mypython-mode-map (kbd "C-c C-t f") 'nosetests-module)
  (define-key mypython-mode-map (kbd "C-c C-t o") 'nosetests-one)
  (define-key mypython-mode-map (kbd "C-c C-t C-a") 'nosetests-pdb-all)
  (define-key mypython-mode-map (kbd "C-c C-t C-f") 'nosetests-pdb-module)
  (define-key mypython-mode-map (kbd "C-c C-t C-o") 'nosetests-pdb-one)
  ;; Documentation
  ; setup pylookup to search in documentation
  (define-key mypython-mode-map (kbd "C-c C-d b") 'pylookup-lookup)
  (easy-menu-define python-menu python-mode-map
    "Python menu"
    '("Python"
      ("Navigation"
       ["Nav menu" imenu t]
       ["Goto definition" rope-goto-definition t]
       ["Pop mark" rope-pop-mark t]
       ["Jump to global" rope-jump-to-global t]
       ["Find file" rope-find-file t]
       ["Find Occurrences" rope-find-occurrences t]
       ["Find Occurrences" rope-find-implementations t]
       ["Forward Statement" pyde-nav-forward-statement t]
       ["Backwared Statement" pyde-nav-backward-statement t]
       )
      ("Source"
       ["Code assist" rope-code-assist t]
       ["Lucky assist" rope-lucky-assist t]
       ["Analyze module" rope-analyze-module t]
       ["Check" pyde-check t]
       )
      ("Documentation"
       ["Show documentation" rope-show-doc t]
       ["Show documentation (pyde)" pyde-doc-rope t]
       ["Search documentation" pyde-doc-search t]
       ["Show documentation (pyde 2)" pyde-doc-show t]
       ["Browse documentation" pylookup-lookup t]
       )
      ("Refactor"
       ["Inline" rope-inline t]
       ["Extract Variable" rope-extract-variable t]
       ["Extract Method" rope-extract-method t]
       ["Organize Imports" rope-organize-imports t]
       ["Rename" rope-rename t]
       ["Move" rope-move t]
       ["Restructure" rope-restructure t]
       ["Use Function" rope-use-function t]
       ["Introduce Factory" rope-introduce-factory t]
       ("Generate"
	["Class" rope-generate-class t]
	["Function" rope-generate-function t]
	["Module" rope-generate-module t]
	["Package" rope-generate-package t]
	["Variable" rope-generate-variable t]
	)
       ("Module"
	["Module to Package" rope-module-to-package t]
	["Rename Module" rope-rename-current-module t]
	["Move Module" rope-move-current-module t]
	)
       "--"
       ["Undo" rope-undo t]
       ["Redo" rope-redo t]
       )
      ("Test"
       ["Test all" nosetests-all t]
       ["Test module" nosetests-module t]
       ["Test one" nosetests-one t]
       ["Test all debug" nosetests-pdb-all t]
       ["Test module debug" nosetests-pdb-one t]
       ["Test one debug" nosetests-pdb-one t]
       )
      ("Process"
       ["Activate virtual env" rope-module-to-package t]
       ["Disable virtual env" pyvirtualenv t]
       ["Send region or buffer" pyde-shell-send-region-or-buffer t]
       ["Switch to shell" python-shell-switch-to-shell t]
       ["Send defun" python-shell-send-defun t]
       )
      ("Project"
       ["Open project" rope-open-project t]
       ["Close project" rope-close-project t]
       ["Find file" rope-find-file t]
       ["Open project config" rope-project-config t]
       )
      ("Create"
       ["Module" rope-create-module t]
       ["Package" rope-create-package t]
       ["File" rope-create-file t]
       ["Directory" rope-create-directory t]
       )
      )))

(defun myremove-keymap-key (keymap evt binding)
  (cond
   ((keymapp binding)
    (progn (myempty-keymap binding)
	   (define-key keymap evt nil)))
   ((fboundp binding) (define-key keymap evt nil))))

(defun myempty-keymap(keymap)
  (interactive)
  (map-keymap (lambda(evt binding) (myremove-keymap-key keymap evt binding)) keymap)
)

(define-mypython-mode-map)

(add-hook 'python-mode-hook 'python-mode-setup-hook)

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


