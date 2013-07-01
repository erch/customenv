(message "loading java-conf ...")
(unless (require 'eclim nil t)
  (progn
    (package-install 'emacs-eclim)
    (require 'eclim)
))

(unless (require 'javadoc-lookup nil t)
  (progn
    (package-install 'javadoc-lookup)
    (require 'javadoc-lookup)
))

;; bug in eclim-maven that defines a wrong regexp for compilation buffer
(let 
    ((error-reg-list compilation-error-regexp-alist))
  (require 'eclim-maven)
  (setq compilation-error-regexp-alist error-reg-list))

(require 'yasnippet-conf)
(require 'javadoc-lookup)
(require 'maven-fetch)
(require 'eclimd)

(require 'completion-conf)
(require 'cedet-conf)
(require 'outline-conf)
(require 'cc-mode)

(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)
(global-eclim-mode)

(setq javadoc-lookup-cache-dir "~/.javadoc")
(setq eclimd-executable "~/opt/eclipse/eclimd")
(setq eclim-eclipse-dirs '("~/opt/eclipse"))
(setq eclimd-wait-for-process t)
(setq eclimd-default-workspace "~/eclimworkspace")
(setq eclim-executable "~/opt/eclipse/eclim")

(defun  java-mode-setup-hook()
  ;; java mode is based on cc-mode: different settings for cc-mode
  ;; indentation
  (setq c-basic-offset 4)

  ;; enabling cedet
  (activate-cedet-buffer-local)

  ;;  auto-complete
  (auto-complete-mode 1)
  (setq-local ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
  (setq-local help-at-pt-display-when-idle t)
  (setq-local help-at-pt-timer-delay 0.1)
  (setq-local ac-auto-start 0)
  (help-at-pt-set-timer)

  ;; eclim customisation
  (setq-local eclim-auto-save t)
  
  ;; configuration for maven compilation buffer
  (make-local-variable 'compilation-error-regexp-alist-alist)
  (add-to-list 'compilation-error-regexp-alist 'maven)
  (add-to-list 'compilation-error-regexp-alist-alist
	       '(maven "\\[ERROR\\] \\(.+?\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\].*"
		       1 2 3))
  
  ;; yasnipet configuration
  (let* 
      ((ecust-snips (file-name-as-directory (expand-file-name "snippets" (file-name-directory emacs-d-dir))))
       (eclim-snips (file-name-as-directory (expand-file-name "snippets" (file-name-directory (locate-library "eclim"))))))
    (activate-yasnippet-buffer-local-with-dirs (list ecust-snips eclim-snips)))
  
  ;; outline configuration
  (activate-outline-buffer-local "\\(?:\\([ \t]*.*\\(class\\|interface\\)[ \t]+[a-zA-Z0-9_]+[ \t\n]*\\({\\|extends\\|implements\\)\\)\\|[ \t]*\\(public\\|private\\|static\\|final\\|native\\|synchronized\\|transient\\|volatile\\|strictfp\\| \\|\t\\)*[ \t]+\\(\\([a-zA-Z0-9_]\\|\\( *\t*< *\t*\\)\\|\\( *\t*> *\t*\\)\\|\\( *\t*, *\t*\\)\\|\\( *\t*\\[ *\t*\\)\\|\\(]\\)\\)+\\)[ \t]+[a-zA-Z0-9_]+[ \t]*(\\(.*\\))[ \t]*\\(throws[ \t]+\\([a-zA-Z0-9_, \t\n]*\\)\\)?[ \t\n]*{\\)" "\n" c-basic-offset) 
  ;;(message (list ecust-snips eclim-snips))
  
  ;; create custom menu for Java
  (modify-java-keymap)
  )
     
(defun modify-java-keymap()
  "install the custom java keymap"
  (use-local-map myjava-mode-map))

(setq myjava-mode-map  
      (create-menu-and-key-bindings 
       "Java"
       '(
	 ("Navigation"
	  ["Goto definition" "Jump to symbol definition" eclim-java-find-declaration (kbd "C-c C-g d")]
	  ["Find Occurrences" "Find Occurrences" eclim-java-find-references (kbd "C-c C-g c")]
	  ["Find Type" "Find type" eclim-java-find-type]
	  ["Find Generic" "Find Generic" eclim-java-find-generic]
	  ["Find Implementation" "Find Implementation" rope-find-implementations (kbd "C-c C-g i")]
	  "--"
	  ["Forward Statement" "Forward Statement" c-end-of-statement]
	  ["Backward Statement" "Backward Statement" c-beginning-of-statement]
	  )
	 ("Project"
	  ["Import Project" "Import Eclim Project" eclim-project-import]
	  ["Open project" "Open project" eclim-project-goto]
	  ["Manage Projects" "Manage Eclim Projects" eclim-manage-projects]
	  ["Create Projects" "Create Eclim Project" eclim-project-create]
	  )
	 ("Process"
	  ["Stop Eclim" "Stop Eclim deamon" stop-eclimd (kbd "C-c C-i S-s")]
	  ["Start Eclim" "Start Eclim deamon" start-eclimd (kbd "C-c C-i s")]
	  )
	 ("Maven"
	  ["Run Goal" "Execute a specific Maven goal in the context of the current
project" eclim-maven-run (kbd "C-c C-c c")]
	  ["Run Phase" "Run any given Maven life-cycle phase in the context of the current
project" eclim-maven-lifecycle-phase-run (kbd "C-c C-c t")]	 
	  )
	 ("Refactor"
	  ["Organize Imports" "Organize Imports" eclim-java-import-organize]
	  ["Rename" "Rename" eclim-java-refactor-rename-symbol-at-point]
	  )
	 ("Documentation"
	  ["Show documentation" "Show documentation" javadoc-lookup (kbd "C-c C-d M-s")]
	  )
	 ("Source"
	  ("Toggle..."
	   ["Syntactic indentation" "Syntactic indentation" c-toggle-syntactic-indentation]
	   ["Electric mode" "Electric mode" c-toggle-electric-state]
	   ["Auto newline" "Auto newline" c-toggle-auto-newline]
	   ["Hungry delete" "Hungry delete" c-toggle-hungry-state]
	   ["Subword mode" "Subword mode" subword-mode]
	   )
	  ("Style"
	   ["Set Style" "Set Style..." c-set-style]
	   ["Show Current Style Name"  "Show Current Style Name" c-guess-style-name]
	   ["Guess Style from this Buffer" "Guess Style from this Buffer" c-guess-buffer-no-install]
	   ["Install the Last Guessed Style" "Install the Last Guessed Style..." c-guess-install]
	   ["View the Last Guessed Style" "View the Last Guessed Style" c-guess-view]
	   )
	  ["Fill Comment Paragraph" "Fill Comment Paragraph" c-fill-paragraph]
	  ["Indent Line or Region" "Indent Line or Region" c-indent-line-or-region]
	  ["Indent Expression" "Indent Expression" c-indent-exp]
	  ["Uncomment Region" "format source" uncomment-region]
	  ["Comment out Region" "format source" comment-region]
	  "--"
	  ("Generate"
	   ["Add import" "Insert an import statement at import section at the top of the file." add-java-import]
	   ["Add Comment" "Insert a javadoc comment" eclim-java-doc-comment]
	   ["Implement" "Insert a skeleton for a method implementation" eclim-java-implement]
	   )
	  ["Format" "format source" eclim-java-format]
	  ["Show Snipets" "shows all possible snippets that can be expanded here" yas-insert-snippet]
	  ["Complete" "Auto complete complete" ac-complete]
	  ["Complete (eclim)" "eclim complete" eclim-complete]
	  )	 
	 ("Problems"
	  ["Show" "Show Problems" eclim-problems (kbd "C-c S-p s")]
	  ["Open" "Open Problem window" eclim-problems-open (kbd "C-c S-p o")]
	  )
	 )))
		       
(let ((blocking-map (make-sparse-keymap)))
  (define-key blocking-map [menu-bar] nil)
  (set-keymap-parent blocking-map java-mode-map)
  (set-keymap-parent myjava-mode-map blocking-map))

(add-hook 'java-mode-hook 'java-mode-setup-hook)
(message "java-conf loaded")
(provide 'java-conf)



