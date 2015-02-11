(require 'ech-env)
(require 'debug-utils)

(ech-install-and-load 'mocker)

;; menu customization
(defun make-display-easy-menu(menu-title)
  (easy-menu-create-menu menu-title			 
		      '(("Display"
			 ["Forward word" forward-word]))))

(defun make-org-easy-menu(menu-title)
  (easy-menu-create-menu menu-title			 
		      '(("Org"
			 ["Capture" org-capture :help "Quick capture of Anything for post processing"]))))

;; (ech-find-string-in-keymap (make-easy-menu))
;; (ech-find-string-in-keymap (make-easy-menu))
;; (dbg-print (dbg-parsed-keymap-to-string (dbg-parse-keymap (make-easy-menu)) 0))
(defun test-display-easy-menu()
  (let ((display-submenu (make-display-easy-menu "Test4"))
	(orgmenu (make-org-easy-menu "Test4")))
    (ech-add-menu display-submenu)
    (ech-add-menu orgmenu)))
;;(test-display-easy-menu)
;;(ech-add-menu "Test3" (make-easy-menu "Test3"))
;;(ech-add-menu "Test3")
(defun test-add-easy-menu-submenu()
  (let ((submenu (easy-menu-create-menu "Submenu"
		      '(
			 ["back ward word" backward-word t]))))
    (ech-add-menu (make-easy-menu "Test4") "Test4" )
    (ech-add-submenu-to-menu (vector 'menu-bar 'Test4 'Words 'Display) submenu)))
;; (test-add-easy-menu-submenu)
;;(lookup-key ech-mode-map  (vector 'menu-bar 'Test2 'Display))

(defun make-menu-define-key(menu-title)
  (let ((submenumap (make-sparse-keymap menu-title))
	(displaymap (make-sparse-keymap "Display"))
	(orgmap (make-sparse-keymap "Org")))
    (define-key displaymap (vector (make-symbol "Forward word")) (cons "Forward word" 'forward-word))
    (define-key orgmap (vector 'Capture) (cons "Capture" (cons "Quick capture of Anything for post processing" 'org-capture)))
    (define-key submenumap (vector 'Display) (cons "Display" displaymap))
    (define-key submenumap (vector 'Org) (cons "Org" orgmap))
    submenumap))

(defun test-display-define-key-menu()
  (let ((submenu-keymap (make-menu-define-key "Test3")))
    (ech-add-menu submenu-keymap "Test3")
    (ech-add-menu nil "Test3")
    (ech-add-menu submenu-keymap "Test3" )
    ))
;; (test-display-define-key-menu)
;;(dbg-print (dbg-parsed-keymap-to-string (dbg-parse-keymap (make-easy-menu "Test2")) 0))
;;(dbg-print (dbg-parsed-keymap-to-string (dbg-parse-keymap (make-menu-define-key "Test3")) 0))

(defun test-add-define-key-menu-submenu()
  (let ((submenu (easy-menu-create-menu "Submenu"
		      '(
			 ["back ward word" backward-word t]))))
    (ech-add-menu  (make-menu-define-key "Test5") "Test5")
    (ech-add-submenu-to-menu (vector 'menu-bar 'Test5 'Words 'Display) submenu)))

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
