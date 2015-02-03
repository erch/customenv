
(defun print-debug(&rest objs)
  (let* ((buffer (get-buffer-create "*Debug*"))
	 (window (get-buffer-window buffer)))
    (with-current-buffer buffer      
	(progn
	  (set-buffer buffer)
	  (goto-char (point-max))	  
	  (mapc (lambda(x)
		  (insert (format "%S\n" x)))
		    objs)))))	    

(defun truncate-string (string maxchar)
  (substring string  0 (min maxchar (- 1 (length string)))))

(defun analyse-keymap(keymap)
  (list (do-analyse-keymap keymap nil)))


;; keymap-struct := (("KeyBindings" . (key-binding*)) ("DefaultKeyBindings" . (binding*)) ("Keymap" . (keymap-struct*)) ("CharTable" . char-table) ("MenuKeyBindings" . (menu-binding*)) ("MenuStrings" . (menu-string*)))
;; key-binding := (evt binding)
;; menu-binding := (evt name help-string? prop-list? binding)
;; binding := command-symb-string | keymap-struct | keymap-ref
;; keymap-ref := "Keymap:" keymap-symb-string
(defun add-to-alist (keymap-struct list-name elem)
  (let ((innerlist (gethash list-name keymap-struct)))
    (if (null innerlist)
	(puthash  list-name (list elem) keymap-struct)
      (puthash  list-name (push  elem  innerlist) keymap-struct)))
      ;;(setcdr innerlist elem)))
  keymap-struct)

;; keymap := (`keymap key-def*)
;; key-def := string | char-table | default-key-binding | keymap | key-binding 
;; default-key-binding := (t binding-def)
;; key-binding := menu-key-binding |
;;                (evt binding-def)
;; menu-key-binding := (evt ('menu-item menu-item-def)) |
;;                (evt "item-name" "help-string" binding-def) |
;;                (evt "item-name"  binding-def)
;; menu-item-def := item-name | item-name binding-def | item-name binding-def properties-list
;; binding-def := keymap | binding | keymap-ref
;; binding := *
;; keymap-ref := <symbol whose function definition satisfies keymapp>
(defun parse-keymap (keymap)
  (let ((first (car keymap))
	(rest (cdr keymap))
	(keymap-struct (make-hash-table :test 'equal)))
    (if (and (symbolp first) (string= "keymap" (symbol-name first)))
	(parse-key-defs rest keymap-struct)
      (error (truncate-string (concat "Not a keymap: " (format "%S" keymap)) 80)))
    keymap-struct))

(defun parse-key-defs (keydefs keymap-struct)
  (if (listp keydefs)
      (mapc (lambda(x) (parse-keydef x keymap-struct)) keydefs)
    (error (truncate-string (concat "Not a keybinding list: " (format "%S" keydefs)) 80))))  

(defun parse-keydef (keydef keymap-struct)
  (cond
   ((stringp keydef)
    (add-to-alist keymap-struct "MenuStrings" (parse-menu-string keydef)))
   ((char-table-p keydef)
    (add-to-alist keymap-struct "CharTable" (parse-chartable keydef)))
   ((and (consp keydef) (eq t (car keydef)))
    (add-to-alist keymap-struct "DefaultKeyBindings" (parse-binding-def (car keydef) (cdr keydef))))
   ((and (listp keydef) (symbolp (car keydef)) (string= "keymap" (symbol-name (car keydef))))
    (add-to-alist keymap-struct "Keymap" (parse-keymap keydef)))
   ((consp keydef)
    (parse-keybinding keydef keymap-struct))
   (t (error (truncate-string (concat "Not a keydef: " (format "%S" keydef)) 80)))))

(defun parse-keybinding (keydef keymap-struct)
  (cond
   ((and (stringp (nth 1 keydef))
	 (or (atom (cdr (cdr keydef))) ;; how to deal with pure cons cells ?
	      (consp (cdr (cdr keydef)))))	  	
    (add-to-alist keymap-struct "MenuKeyBindings" (parse-simple-menu-keydef keydef keymap-struct)))
   ((stringp (nth 1 keydef))
    (add-to-alist keymap-struct "MenuKeyBindings" (parse-simple-menu-with-help-keydef keydef keymap-struct)))
   ((and (symbolp (nth 1 keydef)) (string= "menu-item" (symbol-name (nth 1 keydef))))
    (add-to-alist keymap-struct "MenuKeyBindings" (parse-menu-item-keydef keydef keymap-struct)))
   (t (add-to-alist keymap-struct "KeyBindings" (parse-simple-keydef keydef keymap-struct)))))

(defun parse-simple-keydef(keydef keymap-struct)
  (let ((evt (car keydef))
	(binding (car (cdr keydef))))	
    (parse-binding-def evt binding)))

(defun parse-simple-menu-with-help-keydef (keydef keymap-struct)
  (let* ((evt (car keydef))
	(name (car (cdr keydef)))
	(help (car (cdr (cdr keydef))))	
	(binding (cdr (cdr (cdr keydef)))))        
    (parse-binding-def evt binding name help)))

(defun parse-simple-menu-keydef (keydef keymap-struct)
  (let* ((evt (car keydef))
	 (name (car (cdr keydef)))
	 (binding (cdr (cdr keydef))))     
    (parse-binding-def evt binding name)))

(defun parse-menu-item-keydef (keydef keymap-struct)
  (let ((evt (car keydef))
	(menu-symb (car (cdr keydef)))
	(name (car (cdr (cdr keydef))))
	(binding (car (cdr (cdr (cdr keydef)))))
	(proplist (car (cdr (cdr (cdr (cdr keydef)))))))	   
    (if (null binding)
	(list evt name)
      (parse-binding-def evt binding name nil proplist))))

(defun parse-binding-def (evt bindingdef &optional name help proplist)
  (list
   evt
   name
   help
   proplist
   (cond
    ((and (listp bindingdef) (symbolp (car bindingdef)) (string= "keymap" (symbol-name (car bindingdef))))
     (parse-keymap bindingdef))
    ((and (symbolp bindingdef) (string= "keymap" (symbol-name bindingdef)))
     (parse-keymap (list bindingdef)))
    ((and (symbolp bindingdef) (equal 'keymap  (symbol-function bindingdef)))
     (concat "Keymap:" (symbol-name bindingdef)))
    (t (format "%S" bindingdef)))))

(defun parse-menu-string (menustring)
  menustring)

(defun parse-chartable (chartable)
  chartable)
   
(defun print-analysed-keymap (keymap-struct indent)
  (let ((indentStr (make-string indent ?\s))
	(keymaps-assoc (assoc "Keymap" keymap-struct))
	(tbindings-assoc (assoc "TrueBindings" keymap-struct))
	(bindings-assoc (assoc "Bindings" keymap-struct))
	(menustr-assoc (assoc "MenuString" keymap-struct))
	(chartable-assoc (assoc "CharTable" keymap-struct)))
    (concat
     (unless (null menustr-assoc)
       (concat "\n" indentStr "Menu String: " (mapconcat (lambda(x) x) (cdr menustr-assoc) " | ")))
     (unless (null bindings-assoc)
       (let ((indentStr (make-string (+ 2 indent) ?\s)))
	 (concat "\n" indentStr "Bindings:\n  " indentStr (mapconcat (lambda(x) (format "%S" x)) (cdr bindings-assoc) (concat "\n  " indentStr)))))
     (unless (null tbindings-assoc)
       (let ((indentStr (make-string (+ 2 indent) ?\s)))
	 (concat "\n" indentStr "True Bindings:\n  " indentStr (mapconcat (lambda(x) (format "%S" x)) (cdr tbindings-assoc) (concat "\n  " indentStr)))))
     (unless (null chartable-assoc)
       (concat "\n" indentStr "Char Table: " (mapconcat (lambda(x) "X ") (cdr chartable-assoc) " ")))
     (unless (null keymaps-assoc)
       (concat "\n" indentStr "Keymap:" (print-analysed-keymap (cdr keymaps-assoc) (+ 2 indent))))
     )))

  
					;(print-debug (print-key-map global-map 0))
(provide 'debug-utils)
