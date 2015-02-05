(require 'ech-env)
(require 'debug-utils)

;; menu customization
(defun make-easy-menu()
  (easy-menu-create-menu "Words"
		      '(("Display"
			 ["Forward word" forward-word t])
			("Org"
			 ["Capture" org-capture [help:"Quick capture of Anything for post processing" ]]))))

;; (ech-find-string-in-keymap (make-easy-menu))
;; (ech-find-string-in-keymap (make-easy-menu))
;(dbg-print (dbg-parsed-keymap-to-string (dbg-parse-keymap (make-easy-menu)) 0))
(defun test-display-menu()
  (let ((submenu-keymap (make-easy-menu)))
    (ech-add-menu "Test2" submenu-keymap)
    (ech-add-menu "Test2")
    (ech-add-menu "Test2" submenu-keymap)
    (ech-add-submenu-to-menu "Test2" "Words" submenu-keymap)
    ))

;; (ech-find-string-in-keymap (make-sparse-keymap "titi"))
;;(test-display-menu)

(defun test-menu-define-key(menu-title)
  (let ((menu-map (cdr (assoc menu-title ech-menu-maps-alist)))
	(submenumap (make-sparse-keymap)))
    (define-key menu-map (vector 'String) submenumap)
    (define-key submenumap (vector 'forward) (cons "Forward word" 'forward-word))))

(defun create-test-keymap ()
  (let ((test-kmap (make-sparse-keymap))
	(menu-map (make-sparse-keymap "essai")))
    (define-key test-kmap [essai] (cons "essai" menu-map))
       
    (define-key menu-map (vector 'tag-query) '(menu-item (substitute-command-keys "            Tags... (again: \\[tags-loop-continue])") tags-query-replace :help "Replace a regexp in tagged files, with confirmation"))
    ;;(define-key menu-map (vector 'continue) '(menu-item "Continue Replace" tags-loop-continue :help "Continue last tags replace operation"))
    ;;(define-key menu-map (vector 'backward) (cons "Backward word" (cons "goes backward" 'backward-word)))
    ;;(define-key menu-map (vector 'forward) (cons "Forward word" 'forward-word))
    test-kmap))

;; (ech-add-menu "titi")
;; (ech-display-or-hide-menus)
;; (ech-on)
;; (ech-display-or-hide-menus t)
;; (ech-restore-menu "toto")

;; (setq  ech-menu-maps-alist nil)

;; (print-debug "toto" '("titi" "tata"))
;; (test-menu-custom "titi")
;; (test-menu-define-key "titi")
;; (dbg-print menu)
;; (dbg-print ech-mode-map)
;; (dbg-print (format "%s" (cdr (assoc "titi" ech-menu-maps-alist))))
;; (force-mode-line-update)

(defun test-parsing-keymap()
  (setq testmap (create-test-keymap))
  (print-debug testmap)
  (setq parsed-map (parse-keymap testmap))
  (dbg-print parsed-map)
  (dbg-print "KeyBindings" (gethash "KeyBindings" parsed-map))
  (dbg-print "DefaultKeyBindings" (gethash "DefaultKeyBindings" parsed-map))
  (dbg-print "Keymap" (gethash "Keymap" parsed-map))
  (dbg-print "CharTable" (gethash "CharTable" parsed-map))
  (dbg-print "MenuKeyBindings" (gethash "MenuKeyBindings" parsed-map))
  (dbg-print "MenuStrings" (gethash "MenuStrings" parsed-map))
  (dbg-print (print-analysed-keymap parsed-map 0)))

;; (mapc (lambda(x) (dbg-print x)) (gethash "MenuKeyBindings" parsed-map))
;; (length (gethash "MenuKeyBindings" (nth 4 (car (gethash "MenuKeyBindings" parsed-map)))))
;; (test-parsing-keymap)
;; (dbg-print (print-analysed-keymap (parse-keymap ech-mode-map) 0))
;; (dbg-print global-map)
;; (command-remapping 'find-file-other-window)
;; 
