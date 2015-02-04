(require 'easymenu)

(defvar ech-mode-map (make-sparse-keymap)  "Keymap for ech mode.")

(defvar ech-menu-maps-alist nil "association list of menu maps")

(defun ech-add-menu (menu-title)
  "add a menu that will be displayed in the menu bar with title menu-title , returns an empty keymap for this menu, the menu is displayed at the next display menu command"
  (let ((menu-map (make-sparse-keymap menu-title)))
    (push (cons menu-title menu-map) ech-menu-maps-alist)
    menu-map))

(defun ech-display-or-hide-menus (&optional hide)
  "display or hide all menus added by the call to ech-add-menu toin the menu bar
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
  (let ((menu-map (cdr (assoc menu-title ech-menu-maps-alist))))
    (define-key menu-map (vector (make-symbol submenu-title)) (cons submenu-title sub-menu-keymap))))

;; define minor mode
(define-minor-mode ech-mode
  "Minor mode for ech customisations.
\\{ech-mode-map}"
  :lighter " Ech"
  :keymap ech-mode-map
  (if ech-mode
      ;; on start
      (ech-display-or-hide-menus)
    ;; on stop
    (ech-display-or-hide-menus t)))

(define-globalized-minor-mode ech-global-mode ech-mode ech-on)

(defun ech-on ()
  "Turn on `ech-mode'."
  (ech-mode +1))

(defun ech-off ()
  "Turn off `ech-mode'."
  (ech-mode -1))




(provide 'ech-mode)

