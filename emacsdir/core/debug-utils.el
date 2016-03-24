(require 'ech-env)

(defun dbg-print(&rest objs)
  "print all emacs objs in a buffer called *Debug*. Each obj in objs is display with a %S format if it is not a string"
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

(defun dbg-truncate-string (string maxchar)
  "cut a string to maxchar if its length exceeds it"
  (substring string  0 (min maxchar (- 1 (length string)))))

(defun dbg-add-to-parsed-keymap (keymap-struct list-name elem)
  "used by dbg-parse-keympap. Add en element to a list insided a hashtable, Create the hashtable entry
if no list is already associated to the hashtable for this key"
  (let ((innerlist (gethash list-name keymap-struct)))
    (if (null innerlist)
	(puthash  list-name (list elem) keymap-struct)
      (puthash  list-name (push elem  innerlist) keymap-struct)))
      ;;(setcdr innerlist elem)))
  keymap-struct)


(defun dbg-parse-keymap (keymap)
  "Parse a keymap and build a more readable structure from it:

 keymap-struct := hastable with following keys
		KeyBindings => (key-binding*)
		DefaultKeyBindings => binding*
		Keymap => keymap-struct
		CharTable => char-table
		MenuKeyBindings => menu-binding
		MenuStrings => menu-string
 key-binding := (evt binding)
 menu-binding := (evt name help-string? prop-list? binding)
 binding := command-symb-string | keymap-struct | keymap-ref.

Assume the following structure for a keymap:
keymap := (`keymap key-def*)
key-def := string | char-table | default-key-binding | keymap | key-binding 
default-key-binding := (t binding-def)
key-binding := menu-key-binding |
               (evt binding-def)
menu-key-binding := (evt ('menu-item menu-item-def)) |
               (evt \"item-name\" \"help-string\" binding-def) |
               (evt \"item-name\"  binding-def)
menu-item-def := item-name | item-name binding-def | item-name binding-def properties-list
binding-def := keymap | binding | keymap-ref
binding := *
keymap-ref := <symbol whose function definition satisfies keymapp>.

One structure of keymap is not recognize when there is an array of keybinding"
  (let ((first (car keymap))
	(rest (cdr keymap))
	(keymap-struct (make-hash-table :test 'equal)))
    (if (and (symbolp first) (string= "keymap" (symbol-name first)))
	(dbg-parse-key-defs rest keymap-struct)
      (error (dbg-truncate-string (concat "Not a keymap: " (format "%S" keymap)) 80)))
    keymap-struct))

(defun dbg-parse-key-defs (keydefs keymap-struct)
  "called by dbg-parse-keymap, to parse a list of key definitions"
  (if (listp keydefs)
      (mapc (lambda(x) (dbg-parse-keydef x keymap-struct)) keydefs)
    (error (dbg-truncate-string (concat "Not a keybinding list: " (format "%S" keydefs)) 80))))  

(defun dbg-parse-keydef (keydef keymap-struct)
  "called by dbg-parse-key-defs to parse one key definitions.

Sort out the more obvious cases, and delegate to dbg-parse-keybinding the parsing all real key binding def"
  (cond
   ((stringp keydef)
    (dbg-add-to-parsed-keymap keymap-struct "MenuStrings" (dbg-parse-menu-string keydef)))
   ((char-table-p keydef)
    (dbg-add-to-parsed-keymap keymap-struct "CharTable" (dbg-parse-chartable keydef)))
   ((arrayp keydef)
    ;;(mapc (lambda(x) (dbg-parse-keydef x keymap-struct)) keydef)) ; unknown form of keymap
    nil)
   ((and (consp keydef) (eq t (car keydef)))
    (dbg-add-to-parsed-keymap keymap-struct "DefaultKeyBindings" (dbg-parse-binding-def (car keydef) (cdr keydef))))
   ((and (listp keydef) (symbolp (car keydef)) (string= "keymap" (symbol-name (car keydef))))
    (dbg-add-to-parsed-keymap keymap-struct "Keymap" (dbg-parse-keymap keydef)))
   ((and (listp keydef) (symbolp (car keydef)) (string= "remap" (symbol-name (car keydef))))
    (dbg-add-to-parsed-keymap keymap-struct "Remaping" (dbg-parse-remaping keydef)))
   ((consp keydef)
    (dbg-parse-keybinding keydef keymap-struct))
   (t (error (dbg-truncate-string (concat "Not a keydef: " (format "%S" keydef)) 80)))))

(defun dbg-parse-remaping (keydef)
  "parse a remaping"
  (cdr (cdr keydef)))

(defun dbg-parse-keybinding (keydef keymap-struct)
  "called by dbg-parse-key-def to parse a real key binding.

Sort out the simple, complext keybinding a the simple command key definition"
  (cond
   ((and (consp (cdr keydef)) (symbolp (nth 1 keydef)) (string= "menu-item" (symbol-name (nth 1 keydef))))
    (dbg-add-to-parsed-keymap keymap-struct "MenuKeyBindings" (dbg-parse-menu-item-keydef keydef keymap-struct)))
   ((or (atom (cdr keydef)) (and (symbolp (nth 1 keydef)) (string= "keymap" (symbol-name (nth 1 keydef)))))
    (dbg-add-to-parsed-keymap keymap-struct "KeyBindings" (dbg-parse-simple-keydef keydef keymap-struct)))
   ((and (stringp (nth 1 keydef))
	 (or (atom (cdr (cdr keydef))) ;; how to deal with pure cons cells ?
	     (not (stringp (nth 2 keydef)))))	  	
    (dbg-add-to-parsed-keymap keymap-struct "MenuKeyBindings" (dbg-parse-simple-menu-keydef keydef keymap-struct)))
   ((stringp (nth 1 keydef))
    (dbg-add-to-parsed-keymap keymap-struct "MenuKeyBindings" (dbg-parse-simple-menu-with-help-keydef keydef keymap-struct)))
   (t (error (dbg-truncate-string (concat "Not a keybinding: " (format "%S" keydef)) 80)))))

(defun dbg-parse-simple-keydef(keydef keymap-struct)
  "parse a simple command key definition"
  (let ((evt (car keydef))
	(binding (cdr keydef)))	
    (dbg-parse-binding-def evt binding)))

(defun dbg-parse-simple-menu-with-help-keydef (keydef keymap-struct)
  "parse a simple menu key definition with an help string"
  (let* ((evt (car keydef))
	(name (car (cdr keydef)))
	(help (car (cdr (cdr keydef))))	
	(binding (cdr (cdr (cdr keydef)))))        
    (dbg-parse-binding-def evt binding name help)))

(defun dbg-parse-simple-menu-keydef (keydef keymap-struct)
  "parse a simple menu key definition without an help string"
  (let* ((evt (car keydef))
	 (name (car (cdr keydef)))
	 (binding (cdr (cdr keydef))))     
    (dbg-parse-binding-def evt binding name)))

(defun dbg-parse-menu-item-keydef (keydef keymap-struct)
  "parse a menu definition with menu-item"
  (let ((evt (car keydef))
	(menu-symb (car (cdr keydef)))
	(name (car (cdr (cdr keydef))))
	(binding (car (cdr (cdr (cdr keydef)))))
	(proplist (cdr (cdr (cdr (cdr keydef))))))	   
    (if (null binding)
	(list evt name)
      (dbg-parse-binding-def evt binding name nil proplist))))

(defun dbg-parse-binding-def (evt bindingdef &optional name help proplist)
  "parse a key definition"
  (list
   evt
   name
   help
   proplist
   (cond
    ((and (listp bindingdef) (symbolp (car bindingdef)) (string= "keymap" (symbol-name (car bindingdef))))
     (dbg-parse-keymap bindingdef))
    ((and (symbolp bindingdef) (string= "keymap" (symbol-name bindingdef)))
     (dbg-parse-keymap (list bindingdef)))
    ((and (symbolp bindingdef) (equal 'keymap  (symbol-function bindingdef)))
     (concat "Keymap:" (symbol-name bindingdef)))
    (t (format "%S" bindingdef)))))

(defun dbg-parse-menu-string (menustring)
  menustring)

(defun dbg-parse-chartable (chartable)
  chartable)


(defun dbg-parsed-keymap-to-string (keymap-struct indent)
  "return a string representing a structure returned by parse-keymap"
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
       (mapconcat (lambda(x) (dbg-parsed-keymap-to-string x next-indent)) keymaps "\n"))
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
  "call by dbg-parsed-keymap-to-string "
  (let* ((format-string (or format-str "%s"))
	(indent-str (make-string indent ?\s))	
	(next-indent-str (make-string (+ 2 indent) ?\s))
	(sep-str (or sep (concat "\n" next-indent-str))))
    (concat "\n" indent-str title "\n" next-indent-str (mapconcat (lambda(x) (format format-string x)) item-list sep-str))))

(defun print-bindings (bindings title indent)
  "call by dbg-parsed-keymap-to-string "
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
			     (if (stringp name) name (format "%S" name))
			     (if (stringp help) help (format "%S" help))
			     (format "%S" proplist)
			     (if (hash-table-p binding)
				 (dbg-parsed-keymap-to-string binding  next-indent)
			       (format "%S" binding)))
			    " | ")))
		       bindings
		       sep))))

(defun dbg-print-keymap(keymap-or-keymap-name)
  "Print in the *Debug* buffer a keymap, keymap is the keymap or a string which is the name of the keymap."
  (interactive (list (read-string "Keymap:")) )
  (let ((keymap (if (stringp keymap-or-keymap-name)
		    (eval (intern keymap-or-keymap-name))
		  keymap-or-keymap-name)))
    (dbg-print (concat (dbg-parsed-keymap-to-string (dbg-parse-keymap keymap) 0) "\n"))))

(define-key ech-mode-map ech-key-dbg-print-keymap 'dbg-print-keymap)

(provide 'debug-utils)
