(require 'ech-env)
(require 'debug-utils)

;; menu customization
(defun test-menu-custom(menu-title)
  (let ((menu (easy-menu-create-menu "Words"
		      '(
			["Forward word" forward-word]
			["Backward word" backward-word])))
	(menu-map (cdr (assoc menu-title ech-menu-maps-alist))))
    (define-key menu-map  menu)))

(defun test-menu-define-key(menu-title)
  (let ((menu-map (cdr (assoc menu-title ech-menu-maps-alist)))
	(submenumap (make-sparse-keymap)))
    (define-key menu-map (vector 'String) submenumap)
    (define-key submenumap (vector 'forward) (cons "Forward word" 'forward-word))))

(defun create-test-keymap ()
  (let ((test-kmap (make-sparse-keymap))
	(menu-map (make-sparse-keymap "essai")))
    (define-key test-kmap [essai] (cons "essai" menu-map))    
    (define-key menu-map (vector 'continue) '(menu-item "Continue Replace" tags-loop-continue :help "Continue last tags replace operation"))
    (define-key menu-map (vector 'backward) (cons "Backward word" (cons "goes backward" 'backward-word)))
    (define-key menu-map (vector 'forward) (cons "Forward word" 'forward-word))
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
;; (print-debug menu)
;; (print-debug ech-mode-map)
;; (print-debug (format "%s" (cdr (assoc "titi" ech-menu-maps-alist))))
;; (force-mode-line-update)

(defun test-parsing-keymap()
  (setq testmap (create-test-keymap))
  (print-debug testmap)
  (setq parsed-map (parse-keymap testmap))
  (print-debug parsed-map)
  (print-debug "KeyBindings" (gethash "KeyBindings" parsed-map))
  (print-debug "DefaultKeyBindings" (gethash "DefaultKeyBindings" parsed-map))
  (print-debug "Keymap" (gethash "Keymap" parsed-map))
  (print-debug "CharTable" (gethash "CharTable" parsed-map))
  (print-debug "MenuKeyBindings" (gethash "MenuKeyBindings" parsed-map))
  (print-debug "MenuStrings" (gethash "MenuStrings" parsed-map)))

;; (test-parsing-keymap)
