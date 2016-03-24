(require 'ech-env)

;; load key definitions
(require 'ech-keydefs)

(defvar ech-mode-map (make-sparse-keymap)  "Keymap for ech mode.")

(defvar ech-menu-maps-alist nil "association list of menu keymaps. car is the title of the menu cdr is its keymap")

(defun ech-add-menu (&optional menu-items-keymap menu-title)
  "add a menu that will be displayed in the menu bar and returns the keymap corresponding to this menu.


If menu-title is provided it is used as the menu title as well as the event symbol for this menu binding.
If no menu-title is provided then the menu-items-keymap must contains a menu string that will be used as the menu 
title as well as the event symbol for this menu binding.

If a menu with the same title already exists then returns its keymap and merge menu-items-keymap into it.
If no menu already exists with this title then create a key map for it and returns it.

The menu items found in menu-items-keymap are merged into the menu keymap as explain in function 
'ech-add-items-to-keymap'. 

If  menu-items-keymap is nil , a menu-title must be provided and the keymap corresponding to this menu is returned.
"
  (let* ((submenu-title (ech-find-string-in-keymap menu-items-keymap))
	 (menu-string (or menu-title submenu-title))
	 (registered-keymap (cdr (assoc menu-string ech-menu-maps-alist)))	 
	 (root-keymap (or registered-keymap (make-sparse-keymap menu-string)))
	 (menu-symb (if  menu-title
			(vector 'menu-bar (intern menu-title))
		      (vector 'menu-bar (intern menu-string))))
	 (force-merge (not menu-title)))
    (cl-assert menu-string)
    (when (null registered-keymap)
      (push (cons menu-string root-keymap) ech-menu-maps-alist)
      (define-key ech-mode-map (vector 'menu-bar (intern menu-string)) (cons menu-string root-keymap)))
    (when menu-items-keymap (ech-add-items-to-keymap (vector 'menu-bar (intern menu-string)) menu-items-keymap nil force-merge))
    root-keymap)) 

(defun ech-add-items-to-keymap(symbs-vector items-keymap &optional keymap-to-modify force-merge)
  "Add a key definitions to the mode map or to the keymap given par parameter keymap-to-modify if not nil.

The items to add are to be put in the keymap items-keymap which can be build with 'easy-menu-create-menu' or with 'define-key'
The  items are added to the keymap defined by the key sequence specified by the symbol vector symbs-vector (which is passed to 'lookup-key').
See function 'ech-merge-keymaps' for explanation on how the item-keymap is merged into the mode-map.
It is very important to note that for menu definition the menu string is used as the key definition event in order to keep things coherent between calls.

Advice for sub keyamp creation:
- submenu can be created with easy-menu-create-menu like this:
     (easy-menu-create-menu menu-title
		      '((\"Display\"
			 [\"Forward word\" forward-word t])))

- or with make-sparse-keymap and define-key like this:
       (let ((keymap (make-sparse-keymap \"Display\")))
           (define-key keymap (vector (make-symbol \"Forward word\")) (cons \"Forward word\" 'forward-char))
           (define-key keymap (vector (make-symbol \"Backward word\")) (cons \"Backward word\" 'backward-word))
"
  (cl-assert items-keymap)
  (let* ((map (or keymap-to-modify ech-mode-map))
	(root-keymap (lookup-key map  symbs-vector))
	(submenu-title (ech-find-string-in-keymap items-keymap)))
    (if (or force-merge (null submenu-title))	
	(define-key map symbs-vector
	  (if submenu-title
	      (cons submenu-title (ech-merge-keymaps root-keymap items-keymap force-merge))
	    (ech-merge-keymaps root-keymap items-keymap force-merge)))
      (define-key root-keymap (vector (intern submenu-title)) (cons submenu-title items-keymap)))
    root-keymap))

(defun ech-merge-keymaps (container mergee &optional force-merge)
  "Merge two keymaps by inserting mergee into container

If container already contains one mergee's key the key definition is overiden by the one provided by mergee.
When the mergee keymap has a menu string the assumption that it means that it defines a submenu. In this case menu string is used
as the title of the submenu as well as the the binding event of the submenu. 
BE CAREFUL: if a submenu already exists with the same event binding the mergee's one replace the original one. 
If no string is found in mergee just adds its elements to the container keymap. BE CAREFUL: if a mergee's event is already bouded to a key definition in the original keymap then it replaced by the mergee's definition.
keymap-to-modify must not be null
"
  (cl-assert (and container mergee))
  (let ((submenu-title (ech-find-string-in-keymap mergee)))
    (if (or force-merge (null submenu-title))
	(--each
	    (cdr mergee)
	  (let* ((elem it)
		 (index (and (listp elem) (-find-index  (lambda (x) (and (listp x) (equal (car x) (car elem)))) container))))
	    (when index
	      (setq container (-remove-at index container)))
	    (setq container (-snoc  container it))))
      (define-key container (vector (intern submenu-title)) (cons submenu-title mergee)))
    container))

(defun ech-find-string-in-keymap(keymap)
  "search for a menu string in keymap , if found returns it , returns nil otherwise"
  (-first
   (lambda(x) (stringp x))
   keymap))

(defun ech-display-or-hide-menus (&optional hide)
  "display or hide all menus added by the call to ech-add-menu. the menu bar
shows the menu by defautl or hides if hide is t"
  (mapc (lambda(cell)
	  (let* ((menu-map (cdr cell))
		(menu-title (car cell))
		(menu-symb (intern menu-title)))
	    (if hide
		(define-key ech-mode-map (vector 'menu-bar menu-symb) 'undefined)
	      (define-key ech-mode-map (vector 'menu-bar menu-symb) (cons menu-title menu-map)))))
	ech-menu-maps-alist))

;; define minor mode
(define-minor-mode ech-mode
  "Minor mode for ech customisations.
\\{ech-mode-map}"
  :lighter " Ech"
  :keymap ech-mode-map
  :global t
  :init-value t
  (if ech-mode
      ;; on start
      (ech-display-or-hide-menus)
    ;; on stop
    (ech-display-or-hide-menus t)))

(defun ech-on ()
  "Turn on `ech-mode'."
  (ech-mode +1))

(defun ech-off ()
  "Turn off `ech-mode'."
  (ech-mode -1))

(provide 'ech-mode)

