
(defun print-debug(&rest objs)
  (let* ((buffer (get-buffer-create "*Debug*"))
	 (window (get-buffer-window buffer)))
    (with-current-buffer buffer      
	(progn
	  (set-buffer buffer)
	  (goto-char (point-max))	  
	  (mapc (lambda(x)		  
		  (insert
		   (if (stringp x)
		       x
		     (format "%S\n" x))))
		objs)))))	    

(defun truncate-string (string maxchar)
  (substring string  0 (min maxchar (- 1 (length string)))))


;; keymap-struct := (("KeyBindings" . (key-binding*)) ("DefaultKeyBindings" . (binding*)) ("Keymap" . (keymap-struct*)) ("CharTable" . char-table) ("MenuKeyBindings" . (menu-binding*)) ("MenuStrings" . (menu-string*)))
;; key-binding := (evt binding)
;; menu-binding := (evt name help-string? prop-list? binding)
;; binding := command-symb-string | keymap-struct | keymap-ref
;; keymap-ref := "Keymap:" keymap-symb-string
(defun add-to-alist (keymap-struct list-name elem)
  (let ((innerlist (gethash list-name keymap-struct)))
    (if (null innerlist)
	(puthash  list-name (list elem) keymap-struct)
      (puthash  list-name (push elem  innerlist) keymap-struct)))
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
   ((arrayp keydef)
    nil)
   ((stringp keydef)
    (add-to-alist keymap-struct "MenuStrings" (parse-menu-string keydef)))
   ((char-table-p keydef)
    (add-to-alist keymap-struct "CharTable" (parse-chartable keydef)))
   ((and (consp keydef) (eq t (car keydef)))
    (add-to-alist keymap-struct "DefaultKeyBindings" (parse-binding-def (car keydef) (cdr keydef))))
   ((and (listp keydef) (symbolp (car keydef)) (string= "keymap" (symbol-name (car keydef))))
    (add-to-alist keymap-struct "Keymap" (parse-keymap keydef)))
   ((and (listp keydef) (symbolp (car keydef)) (string= "remap" (symbol-name (car keydef))))
    (add-to-alist keymap-struct "Remaping" (parse-remaping keydef)))
   ((consp keydef)
    (parse-keybinding keydef keymap-struct))
   (t (error (truncate-string (concat "Not a keydef: " (format "%S" keydef)) 80)))))

(defun parse-remaping (keydef)
  (cdr (cdr keydef)))

(defun parse-keybinding (keydef keymap-struct)
  (cond
   ((and (consp (cdr keydef)) (symbolp (nth 1 keydef)) (string= "menu-item" (symbol-name (nth 1 keydef))))
    (add-to-alist keymap-struct "MenuKeyBindings" (parse-menu-item-keydef keydef keymap-struct)))
   ((or (atom (cdr keydef)) (and (symbolp (nth 1 keydef)) (string= "keymap" (symbol-name (nth 1 keydef)))))
    (add-to-alist keymap-struct "KeyBindings" (parse-simple-keydef keydef keymap-struct)))
   ((and (stringp (nth 1 keydef))
	 (or (atom (cdr (cdr keydef))) ;; how to deal with pure cons cells ?
	     (not (stringp (nth 2 keydef)))))	  	
    (add-to-alist keymap-struct "MenuKeyBindings" (parse-simple-menu-keydef keydef keymap-struct)))
   ((stringp (nth 1 keydef))
    (add-to-alist keymap-struct "MenuKeyBindings" (parse-simple-menu-with-help-keydef keydef keymap-struct)))
   (t (error (truncate-string (concat "Not a keybinding: " (format "%S" keydef)) 80)))))

(defun parse-simple-keydef(keydef keymap-struct)
  (let ((evt (car keydef))
	(binding (cdr keydef)))	
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
  (let* ((indent-str (make-string indent ?\s))
	(next-indent (+ 2 indent))
	(next-indent-str (make-string next-indent  ?\s))
	(keymaps (gethash "Keymap" keymap-struct))
	(menu-strings (gethash "MenuStrings" keymap-struct))
	(chartable (gethash "CharTable" keymap-struct))
	(default-binding (gethash "DefaultKeyBindings" keymap-struct))
	(remaping (gethash "Remaping" keymap-struct))
	(keybindings (gethash "KeyBindings" keymap-struct))
	(menubindings (gethash "MenuKeyBindings"keymap-struct)))
    (concat     
     "KeyMap:"
     (unless (null keymaps)
       (mapconcat (lambda(x) (print-analysed-keymap x next-indent)) keymaps "\n"))
     (unless (null menu-strings)
       (print-item menu-strings next-indent "Menu String:"  " | "))       
     (unless (null chartable)
       (print-item chartable next-indent "Char Table:"  " " "X"))
     (unless (null default-binding)
       (print-bindings default-binding "Default Bindings:" next-indent))
     (unless (null remaping)
       (print-item remaping next-indent "Remaping:" nil "%S"))
     (unless (null keybindings)
       (print-bindings keybindings "Key Bindings:" next-indent))
     (unless (null menubindings)
       (print-bindings menubindings "Menu Bindings:" next-indent)))))

(defun print-item (item-list indent title &optional sep format-str)
  (let* ((format-string (or format-str "%s"))
	(indent-str (make-string indent ?\s))	
	(next-indent-str (make-string (+ 2 indent) ?\s))
	(sep-str (or sep (concat "\n" next-indent-str))))
    (concat "\n" indent-str title "\n" next-indent-str (mapconcat (lambda(x) (format format-string x)) item-list sep-str))))

(defun print-bindings (bindings title indent)
  (let* ((indent-str (make-string indent ?\s))
	(next-indent  (+ 2 indent))
	(next-indent-str (make-string next-indent ?\s))
	(sep (concat "\n" next-indent-str)))	
    (concat "\n"
	    indent-str
	    title
	    "\n"
	    next-indent-str
	    (mapconcat (lambda(x)
			 (let ((evt (car x))
			      (name (nth 1 x))
			      (help (nth 2 x))
			      (proplist (nth 3 x))
			      (binding (nth 4 x)))
			   (mapconcat
			    (lambda(x) (if (not (string= "nil" x)) x ""))
			    (list			     
			     (format "%S" evt)
			     ;;(format "%S" name)
			     name
			     (format "%S" help)
			     (format "%S" proplist)
			     (if (hash-table-p binding)
				 (print-analysed-keymap binding  next-indent)
			       (format "%S" binding)))
			    " | ")))
		       bindings
		       sep))))
  					
(provide 'debug-utils)
