(eval-and-compile
  ;(add-to-list 'load-path (expand-file-name "org/lisp"  site-lisp-dir))
  ;(add-to-list 'load-path (expand-file-name "org/contrib/lisp" site-lisp-dir))

  ;;-----------------------------------------------------------------------------
  ;; Org-mode
  ;;-----------------------------------------------------------------------------
  (require 'org-install)
  ;(load-library "org-depend")
  (require 'org-crypt)

  ;; Standard org stuff
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
					;(define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)

  ;; Settings
  (setq org-list-indent-offset 2)
  (setq org-tags-match-list-sublevels nil) ; don't inherite tags when searching
  (setq org-completion-use-ido t)
  (setq org-return-follows-link t)
  (setq org-ellipsis "...")
  (setq org-cycle-separator-lines 1) ; Display blank lines, like outline-blank-lines
  (setq org-special-ctrl-a/e t)
  (setq org-tags-column -79)		    ; tags right aligned
  (setq org-agenda-align-tags-to-column 70) ; try to right align tags in agenda
  (setq org-hide-leading-stars t)	    ; only show one *
  (setq org-log-done 'time)		       ; add CLOSED when complete item
  (setq org-startup-folded 'showall) ; Best default for small files with tables
  (setq org-agenda-span 7)		; default to one day in agenda
  (setq org-agenda-start-on-weekday nil)
  (setq org-deadline-warning-days 14)
  (setq org-agenda-skip-deadline-if-done t)
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-show-all-dates t)
  (setq org-reverse-note-order t)
  (setq org-fontify-done-headline t)
  (setq org-cycle-include-plain-lists t)
  (setq org-startup-truncated nil)
  (setq org-log-into-drawer nil)
  (setq org-highest-priority ?A)
  (setq org-lowest-priority ?Z)
  (setq org-default-priority ?M)
  (setq org-odd-levels-only t)
  (setq org-agenda-todo-list-sublevels t)
  (setq org-enforce-todo-dependencies t)
  (setq org-treat-S-cursor-todo-selection-as-state-change nil)
  (setq org-agenda-prefix-format "%t %s")

  ;; Managing org files
  (setq org-directory (file-name-as-directory (expand-file-name "Orga" my-home-dir)))

  (defun get-journal-time (&optional wk time)
    "Return the file name of the current journal file"
    (let* ((tl  (if (null time) (decode-time) (decode-time time)))
	   (sec (nth 0 tl))
	   (min (nth 1 tl))
	   (hour (nth 2 tl))
	   (day 1)
	   (month (nth 4 tl))
	   (year (nth 5 tl)))
      (week-day-time-from-date 1 +1 (encode-time sec min hour day month year))))

; (get-journal-time 1 (encode-time 0 0 0 10 5 2011))
; (get-journal-time 1)

  (defun get-journal-file-name (&optional wk time)
    (let* ((dt (get-journal-time 1))
	   (year (nth 0 dt))
	   (month (nth 1 dt)))
      (expand-file-name (format "Orga_Dairy-%4d-%02d.org" year month) org-directory)))
  
  ;;(get-journal-file-name)
  
  (setq
   ;; notes will be put in the journal file when an automatic function will return the journal
   backup-dir (file-name-as-directory (expand-file-name ".archive/org" org-directory))
   project-dir (file-name-as-directory (expand-file-name "ActiveProjects" org-directory))
   business-as-usual-dir (file-name-as-directory (expand-file-name "BusinessAsUsual" org-directory))
   notes-file (expand-file-name "Orga_Inbox.org" org-directory)  
   project-file (expand-file-name "projects.mm" project-dir)
   org-default-notes-file notes-file  
   google-cal-ical-export (expand-file-name "google-cal-ical.org" org-directory)
   todos-file-name-patterns (list "^.+_ActionsPlan.org$" "^.+_Dairy.*\.org$")
   org-archive-location (expand-file-name "%s_archive::" backup-dir))

  (unless (file-exists-p backup-dir) (make-directory  backup-dir t))

  (defun find-todos-in-files (list pattern)
    "find todo files in a list of file names, search in directories if there are some in the list"
    (when (not (null list))
      (let* ((first (car list))
	     (end (cdr list))
	     (fn (or (and (null first) nil) (file-name-nondirectory (directory-file-name first)))))
	;;(message "\t --> first is %s, end is %s, fn is %s" first end fn)
	(cond 
	 ((and (file-regular-p first) (string-match-p pattern fn)) 
	  (cons first (find-todos-in-files end pattern))) 
	 ((and (file-directory-p first) (not (string= ".backup" first)))
	  (append (find-todos-in-dir first pattern) (find-todos-in-files end pattern)))
	 (t (find-todos-in-files end pattern))))))

  ;;  (string-match-p action-plan-file-pattern "working on the grid_AP.org")

  (defun find-todos-in-dir (root pattern)
    "find todos files in  a directory, 
     return the list of full path files."
    (when (file-directory-p root)
      (let ((files (non-dot-directory-files root)))
	;;(message "=> root %s, files are %s" root files)
	(when (not (null files))
	  (find-todos-in-files files pattern)))))
  ;;(find-todos-in-dir project-dir)

  (setq org-agenda-files ())
  (add-to-list 'org-agenda-files notes-file)
  (mapc (lambda(x) (add-to-list 'org-agenda-files x)) (find-todos-in-dir project-dir "^.+_ActionsPlan.org$"))
  (mapc (lambda(x) (add-to-list 'org-agenda-files x)) (find-todos-in-dir business-as-usual-dir "^.+_ActionsPlan.org$"))
;;  (mapc (lambda(x) (add-to-list 'org-agenda-files x)) (find-todos-in-dir project-dir "^.+_Dairy.*\.org$"))
;;  (mapc (lambda(x) (add-to-list 'org-agenda-files x)) (directory-files org-directory t "^.+_Dairy.*\.org$"))
  (add-to-list 'org-agenda-files (expand-file-name "Orga_Scheduling.org" org-directory))
  (add-to-list 'org-agenda-files (expand-file-name "Orga_ActionsPlan.org" org-directory))
  (when (file-exists-p google-cal-ical-export) (add-to-list 'org-agenda-files google-cal-ical-export))
;;  (let ((refile-targets ()))
;;    (mapc (lambda (x) (add-to-list 'refile-targets (cons x '(:tag . "Tasks"))))
;;    (find-action-plan-in-dir project-dir))
;;    (setq org-refile-targets refile-targets))
  ;(setq org-refile-targets `((org-agenda-files :tag . "Tasks")))

  (setq org-refile-targets '((org-agenda-files . (:regexp . "Tasks"))))
  (setq org-refile-use-outline-path t)

  ;; Org tags definition
  (setq org-tag-alist '(
			(:startgroup . nil)
			("@office" . ?f) 
			("@home" . ?h) 
			("@computer" . ?c)
			("@online" . ?o)
			("@errand" . ?e)
			("@phone" . ?p)
			("@anywhere" . ?a)
			(:endgroup . nil)
			(:startgroup . nil)
			("ACTION" . ?A)
			("WAITING_FOR" . ?W)
			("LATER" . ?L)
			("SOMEDAY_MAYBE" . ?S)
			("AGENDA" . ?G)
			("CALLS" . ?C)
			("READ_REVIEW" . ?R)
			("MEETING" . ?M)
			(:endgroup . nil)
			("crypt" . ?Y) 
			(:startgroup . nil)
			("Archi" . ?r)
			("Management" . ?m)
			("Project_management" . ?j)
			("Project" . ?J)
			(:endgroup . nil)
			(:startgroup . nil)
			("Platform" . ?P)
			("ServiceEngineering" . ?E)
			("Properties" . ?y)
			("Science" . ?x)
			("Business_Support" . ?b)
			(:endgroup . nil)
			(:startgroup . nil)
			("Perso" . ?z)
			("Work" . ?w)
			(:endgroup . nil)
			;(:startgroup . nil)
			("PATRICK" . nil)
			("CHRISTOPHE" . nil)		       
			("GILLES" . nil)
			("XAVIER" . nil)
			("REDOUANE" . nil)
			("TEAM" . nil)
			("BSO" . nil)
			("PO" . nil)
			("FE" . nil)
			("SCIENCE" . nil)
			("GUILLAUME" . nil)
			("CYRILLE" . nil)
			("JULIEN_Mo" . nil)
			("SEVERINE" . nil)
			("LAURENT" . nil)
			("FRANCK" . nil)
			("JEFF" . nil)
			("BRICE" . nil)
			;(:endgroup . nil)
			))

  ;; Custom keywords
  (setq org-todo-keywords
	'((sequence "INBOX(i)" "TODO(t)" "NEXT_ACTION(n)" "TODAY(y)" "ON_HOLD(h)" "ON_PROGRESS(p)"  "SCHEDULED(s)" "|" "DONE(d!@)" "CANCEL(c!@)")
	  (sequence "REVIEW(1!)" "REMEMBER-2(2!)" "REMEMBER-3(3!)" "REMEMBER-END(e!)")
	  ))

  ;; Publish my website
  (setq publish-dir  (file-name-as-directory (expand-file-name  "Orga" (getenv "WEB_HOME"))))
  (setq org-publish-project-alist
	(list (cons "orgdir" (list :base-directory org-directory
				   :base-extension "org"
				   :auto-index t
				   :make-index t
				   :recursive t
				   :publishing-directory publish-dir
				   :with-section-numbers t
				   :table-of-contents t
				   :auto-postamble nil
				   :inline-images t
				   :exclude "\\(^OldProjects\\)\\|\\(^References\\)\\|\\(^\\.[^ ]+$\\)"
;.emacs
;OldProjects
;References
				   ))))

  ;; Added for printing agenda
  (setq org-agenda-include-diary t)

;; Custom search command
  (setq org-agenda-custom-commands
           '(
	     ("Tw" "All TODO Work" tags-todo "Work+CALL|Work+ACTION")
	     ("Tp" "All TODO Perso" tags-todo "Perso+CALL|Perso+ACTION")
	     ("w" "Next actions Work" tags-todo "Work+CALL|Work+ACTION/!+NEXT_ACTION|+TODAY")
	     ("p" "Next actions Perso" tags-todo "Perso+CALL|Perso+ACTION/!+NEXT_ACTION|+TODAY")
	     ("W" "Non Actions Work" tags-todo "Work/!-ACTION-CALL")
	     ("P" "Non Actions Perso" tags-todo "Perso/!-ACTION-CALL")
	     ("l" "Later" tags-todo "LATER+SOMEDAY_MAYBE")
	     ("s" "Scheduled things" tags-todo "TODO=\"SCHEDULED\""
             )))


  ;; capture
  (define-key global-map "\C-cc" 'org-capture)

  (setq org-capture-templates
	'(("t" "Todo" entry (file "")
	   "**** INBOX %?\n")))

  ;; set the encryption key to use
  (setq org-crypt-key "Eric Chastan <eric@chastan-jeannin.fr>")
  (org-crypt-use-before-save-magic)

  (add-hook 'org-mode-hook
	    (lambda ()
	      (define-key org-mode-map (kbd "C-c e") 'org-encrypt-entries)
	      (define-key org-mode-map (kbd "C-c D") 'org-decrypt-entries)
	      (define-key org-mode-map (kbd "C-c d") 'org-decrypt-entry)
	      (setq buffer-auto-save-file-name nil) ;; recommended for buffer with crypted parts
	      )
	    )
  ;; enabling clocking
  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate)
  (setq org-clock-idle-time 10)
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; With this typing "L" in agenda and todo buffers allows toggling
   ;; whether category/file names appear or not at the left or entries in
   ;; agenda/todo listings.
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   
   (defvar my-org-agenda-list-category t)
   (defun my-org-agenda-toggle-list-category ()
    "Toggles whether category/file name appears or not at the left
     of entries in agenda listings. Useful to unclutter listings."
     (interactive)
     (if my-org-agenda-list-category
         (progn 
           (setq my-org-agenda-list-category nil)
           (setq org-agenda-prefix-format
                 '((agenda  . "  %-12:c%?-12t% s")
                   (timeline  . "  % s")
                   (todo  . "  %-12:c")
                   (tags  . "  %-12:c")
                   (search . "  %-12:c")))
           )
       (setq my-org-agenda-list-category t)
       (setq org-agenda-prefix-format
             '((agenda  . "  %?-12t% s")
               (timeline  . "  % s")
               (todo  . "  ")
               (tags  . "  ")
               (search . "  ")))
       )
     (org-agenda-redo))
   
   (add-hook 
    'org-mode-hook
    (lambda ()
      (define-key org-agenda-keymap   "L" 'my-org-agenda-toggle-list-category)
      (define-key org-agenda-mode-map "L" 'my-org-agenda-toggle-list-category)

    ))

;;   (add-hook 
;;    'org-agenda-mode-hook
;;    (lambda ()
;;      (setq split-height-threshold nil)
;;      (setq split-width-threshold 0)
;;      ))

  
   (defun gtd (c)
     "Brings directly to a gtd file"
     (interactive "c (p)=project (i)=todo (n)=notes (j)=journal")
     (cond 
      ((char-equal c ?p) (progn (browse-url project-file) t))
      ((char-equal c ?n) (progn (find-file notes-file) t))
      ((char-equal c ?j) (progn (find-file (get-journal-file-name) t)))
      ))
   
  (define-key global-map "\C-cg" 'gtd)

  (compile-if-newer-and-load (expand-file-name "08-yasnippet-conf.el" emacs-d-dir))
  (let* ((mlist '("January" "February" "March" "April" "May" "June" "July" "August" "September" "October" "November" "December"))
	 (month (nth (nth 1 (get-journal-time)) mlist))
	 (title (concat "#+TITLE: Journal for " month "\n#+OPTIONS: toc:2 H:2\n------------------------"))
	 )
    (yas/define-snippets `org-mode (list (list nil (concat "#+TITLE: Journal for " month "\n#+OPTIONS: toc:2 H:2\n------------------------") "journal" nil nil nil nil nil)) `text-mode))
  
  ; enabling fly mode
  (add-hook 'org-mode-hook 'turn-on-flyspell 'append)
)
