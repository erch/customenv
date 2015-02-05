;; key prefix for the mode is :
;; C-c C-e for minor mode commands
;; C-C C-d for debuging commands

(require 'utility-funcs)
(ech-install-and-load 'dash) ;enhanced list functions

(defvar ech-mode-map (make-sparse-keymap)  "Keymap for ech mode.")

(defvar ech-menu-maps-alist nil "association list of menu keymaps. car is the title of the menu cdr is its keymap")

(defun ech-add-menu (menu-title &optional keymap)
  "add a menu that will be displayed in the menu bar with title menu-title.
 
If there is no existing menu associated to this menu-title (ie no previous call to this function with the same menu-title) then:
- If no keymap is provided creates an empty one
- create a menu under the menu bar with menu-title as menu string as well as symbol name for the menu key, and adds the provided keymap or the empty one to this menu.
- Then returns the keymap added to the menu.

if a menu with same title had been already added with this function:
- If no keymap is provided then just returns the keymap associated to the menu
- If a keymap is provided then extract the string associated to the keymap => the keymap must be a menu keymap
- then adds keymap as a submenu with the extracted string as title as well as the key symbol name for this sub menu
- in this case if a keymap is provided and there is no string in keymap then raises an error

For instance : menu-title = Test and keymap has Essai as menu string

- Test doesn't exist => (define-key ech-mode-map [menu-bar Test] (cons \"Test\" keymap))
                     => keymap becomes test-keymap
- Test exists        => (define-key test-keymap [Essai] (cons \"Essai\" keymap))

Which results in the same menu, except if you call twice the function with the same parameters because in this case the events attached to the submenu will not be the same and thus the submenu will be duplicated.
"
  (let ((menu-map (if (null keymap) (make-sparse-keymap menu-title) keymap))
	(menu-entry (cdr (assoc menu-title ech-menu-maps-alist)))
	(submenu-title (ech-find-string-in-keymap keymap)))
    (cond
     ((null menu-entry)	
      (push (cons menu-title menu-map) ech-menu-maps-alist)
      (define-key ech-mode-map (vector 'menu-bar (intern menu-title)) (cons menu-title menu-map))
      menu-map)
     ((null keymap)
      menu-entry)
     ((null submenu-title)
      (error "Didn't find a string in keymap"))
     (t        
      (define-key menu-entry (vector (intern submenu-title)) (cons submenu-title menu-map))))
     menu-map))

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

(defun ech-add-submenu-to-menu(menu-title submenu-title sub-menu-keymap)
  "Add a submenu to a menu. Menu was registered by a call to ech-add-menu"
  (let ((menu-map (cdr (assoc menu-title ech-menu-maps-alist))))
    (define-key menu-map (vector (make-symbol submenu-title)) (cons submenu-title sub-menu-keymap))))

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

