;; key prefix for the mode is :
;; C-c C-e for minor mode commands
;; C-C C-d for debuging commands

(require 'utility-funcs)
(ech-install-and-load 'dash) ;enhanced list functions

(defvar ech-mode-map (make-sparse-keymap)  "Keymap for ech mode.")

(defvar ech-menu-maps-alist nil "association list of menu keymaps. car is the title of the menu cdr is its keymap")

(defun ech-add-menu (menu-title menu-items-keymap)
  "add a menu that will be displayed in the menu bar if it not already exists and returns the keymap corresponding to this menu.

In both cases (menu already exists or not) adds to the menu the items defined in the provided keymap. 
See function 'ech-add-items-to-keymap for explanation on how keymap are added knowing that it is called with the
vector ['menu-bar]
"
  (cl-assert (and menu-title menu-items-keymap))
  (let* ((submenu-title (ech-find-string-in-keymap menu-items-keymap))
	 (registered-keymap (cdr (assoc menu-title ech-menu-maps-alist)))	
	 (root-keymap (or registered-keymap (make-sparse-keymap menu-title))))	 
    (when (null registered-keymap)
      (push (cons menu-title root-keymap) ech-menu-maps-alist)
      (define-key ech-mode-map (vector 'menu-bar (intern menu-title)) (cons menu-title root-keymap)))
    (ech-add-items-to-keymap (vector 'menu-bar (intern menu-title)) menu-items-keymap)
    root-keymap)) 

(defun ech-add-items-to-keymap(symbs-vector items-keymap &optional keymap-to-modify)
  "Add a key definitions to the mode map or to the keymap given par parameter keymap-to-modify if not nil.

The items to add are to be put in the keymap items-keymap which can be build with 'easy-menu-create-menu' or with 'define-key'
The  items are added to the keymap defined by the key sequence specified by the symbol vector symbs-vector (which is passed to 'lookup-key').
If the provided keymap has a menu string it makes the assumption that it defines a submenu 
and thus uses this menu string as the title of the submenu as well as the the binding event of the submenu. 
BE CAREFUL: if a submenu already exists with the same event binding it replaces it. 
If no string is found just add the elements of the provided keymap to the keymap bounded to the events. BE CAREFUL: in this case the call CAN REPLACE EXISTING keys descructively, ie if an event is already bouded to a key definition in the original keymap then it is removed and the one found in items-keymap replaces it.
keymap-to-modify must not be null
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
    (if (null submenu-title)	
	(define-key map symbs-vector (ech-merge-keymaps root-keymap items-keymap))
      (define-key root-keymap (vector (intern submenu-title)) (cons submenu-title items-keymap)))
    root-keymap))

(defun ech-merge-keymaps (container mergee)
  (cl-assert (and container mergee))
  (let ((submenu-title (ech-find-string-in-keymap mergee)))
    (if (null submenu-title)
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

;(define-globalized-minor-mode ech-global-mode ech-mode ech-on)

(defun ech-on ()
  "Turn on `ech-mode'."
  (ech-mode +1))

(defun ech-off ()
  "Turn off `ech-mode'."
  (ech-mode -1))




(provide 'ech-mode)

