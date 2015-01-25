(message "loadind display-conf ...")
(require 'ech-env)
(require 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("dired" (mode . dired-mode))
               ("java" (mode . java-mode))
               ("org" (mode . org-mode))
               ("sql" (mode . sql-mode))
               ("xml" (mode . nxml-mode))
	       ("python"  (mode . python-mode))
	      ("perl" (mode . perl-mode))
	      ))))

(setq ibuffer-show-empty-filter-groups nil)

(add-hook 'ibuffer-mode-hook
 (lambda ()
  (ibuffer-switch-to-saved-filter-groups "default")
  (ibuffer-filter-by-name "^[^*]")
  (ibuffer-filter-by-filename "."))) ;; to show only dired and files buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq mouse-buffer-menu-mode-mult 0)

(ech-install-and-load 'leuven-theme)
(enable-theme 'leuven)

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(menu-bar-mode 1)                       ; show menu bar
(scroll-bar-mode 1)			;show scroll-bar
; Laisser le curseur en place lors d'un défilement par pages.
; Par défaut, Emacs place le curseur en début ou fin d'écran
; selon le sens du défilement.
(setq scroll-preserve-screen-position t)

(setq inhibit-startup-message t)        ;no splash screen

; by default don't set line truncation
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

(setq transient-mark-mode nil)		;highlights selections
(setq set-mark-command-repeat-pop t)
(setq comment-style 'plain)
;; Newline at end of file
(setq require-final-newline t)
;; highlight the current line
(global-hl-line-mode +1)

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("" invocation-name " Prelude - " (:eval (if (buffer-file-name)
                                            (abbreviate-file-name (buffer-file-name))
                                          "%b"))))
;; diminish keeps the modeline tidy
(ech-install-and-load 'diminish)

(winner-mode 1)

(ech-install-and-load 'framemove)
(framemove-default-keybindings)
(windmove-default-keybindings)
(setq framemove-hook-into-windmove t)

(ech-install-and-load 'frame-fns)
(ech-install-and-load 'frame-cmds)

(defun myenlarge-frame()
  (interactive)
  (enlarge-frame 10))
; (myenlarge-frame)

(defun myenlarge-frame-horizontally()
  (interactive)
  (enlarge-frame-horizontally 20))
;(myenlarge-frame-horizontally)

(defun myshrink-frame()
  (interactive)
  (shrink-frame 10))
; (myshrink-frame)

(defun myshrink-frame-horizontally()
  (interactive)
  (shrink-frame-horizontally 20))
;(myshrink-frame-horizontally)

(defadvice fm-next-frame (around next-frame-ignore-error activate)
  "Ignore errors in fm-next-frame"
  (ignore-errors
    ad-do-it))

;; (defun myframe-next(dir)
;;   "call framemove function with ignore errors to avoid jumping in debug windows that debug-on-error is toggled"
;;   (ignore-errors
;;     (fm-next-frame dir)))
;;
;; (defun myframe-right()
;;   (interactive)
;;   (myframe-next 'right))
;;
;; (defun myframe-left()
;;   (interactive)
;;   (myframe-next 'left))
;;
;; (defun myframe-up()
;;   (interactive)
;;   (myframe-next 'up))
;;
;; (defun myframe-dow()
;;   (interactive)
;;   (myframe-next 'down))

;;   (global-set-key [(meta up)]                    'move-frame-up)
;;   (global-set-key [(meta down)]                  'move-frame-down)
;;   (global-set-key [(meta left)]                  'move-frame-left)
;;   (global-set-key [(meta right)]                 'move-frame-right)
(global-set-key [(meta shift ?v)]              'move-frame-to-screen-top)      ; like `M-v'
(global-set-key [(control shift ?v)]           'move-frame-to-screen-bottom)   ; like `C-v'
(global-set-key [(control shift prior)]        'move-frame-to-screen-left)     ; like `C-prior'
(global-set-key [(control shift next)]         'move-frame-to-screen-right)    ; like `C-next'
(global-set-key [(control meta down)]          'myenlarge-frame)
(global-set-key [(control meta right)]         'myenlarge-frame-horizontally)
(global-set-key [(control meta up)]            'myshrink-frame)
(global-set-key [(control meta left)]          'myshrink-frame-horizontally)
;;   (global-set-key [(control ?x) (control ?z)]    'iconify-everything)
;;   (global-set-key [vertical-line S-down-mouse-1] 'iconify-everything)
;;   (global-set-key [(control ?z)]                 'iconify/map-frame)
;;   (global-set-key [mode-line mouse-3]            'mouse-iconify/map-frame)
;;   (global-set-key [mode-line C-mouse-3]          'mouse-remove-window)
;;   (global-set-key [(control meta ?z)]            'show-hide)
;;   (global-set-key [vertical-line C-down-mouse-1] 'show-hide)
;;   (global-set-key [C-down-mouse-1]               'mouse-show-hide-mark-unmark)
;;   (substitute-key-definition 'delete-window      'remove-window global-map)
;;   (define-key ctl-x-map "o"                      'other-window-or-frame)
;;   (define-key ctl-x-4-map "1"                    'delete-other-frames)
;;   (define-key ctl-x-5-map "h"                    'show-*Help*-buffer)
;;   (substitute-key-definition 'delete-window      'delete-windows-for global-map)
;;   (define-key global-map "\C-xt."                'save-frame-config)
;;   (define-key ctl-x-map "o"                      'other-window-or-frame)
;;
;;   (defalias 'doremi-prefix (make-sparse-keymap))
;;   (defvar doremi-map (symbol-function 'doremi-prefix) "Keymap for Do Re Mi commands.")
;;   (define-key global-map "\C-xt" 'doremi-prefix)
;;   (define-key doremi-map "." 'save-frame-config)
;;
;;  Customize the menu.  Uncomment this to try it out.
;;
;;

(let ((menu-bar-frames-menu (make-sparse-keymap "Frames")))
  (define-key-after global-map [menu-bar frames]
    (cons "Frames" menu-bar-frames-menu))
  (define-key menu-bar-frames-menu [set-all-params-from-frame]
    '(menu-item "Set All Frame Parameters from Frame" set-all-frame-alist-parameters-from-frame
		:help "Set frame parameters of a frame to their current values in frame"))
  (define-key menu-bar-frames-menu [set-params-from-frame]
    '(menu-item "Set Frame Parameter from Frame..." set-frame-alist-parameter-from-frame
		:help "Set parameter of a frame alist to its current value in frame"))
  (define-key menu-bar-frames-menu [separator-frame-1] '("--"))
  (define-key menu-bar-frames-menu [tile-frames-vertically]
    '(menu-item "Tile Frames Vertically..." tile-frames-vertically
		:help "Tile all visible frames vertically"))
  (define-key menu-bar-frames-menu [tile-frames-horizontally]
    '(menu-item "Tile Frames Horizontally..." tile-frames-horizontally
		:help "Tile all visible frames horizontally"))
  (define-key menu-bar-frames-menu [separator-frame-2] '("--"))
  (define-key menu-bar-frames-menu [toggle-max-frame-vertically]
    '(menu-item "Toggle Max Frame Vertically" toggle-max-frame-vertically
		:help "Maximize or restore the selected frame vertically"
		:enable (frame-parameter nil 'restore-height)))
  (define-key menu-bar-frames-menu [toggle-max-frame-horizontally]
    '(menu-item "Toggle Max Frame Horizontally" toggle-max-frame-horizontally
		:help "Maximize or restore the selected frame horizontally"
		:enable (frame-parameter nil 'restore-width)))
  (define-key menu-bar-frames-menu [toggle-max-frame]
    '(menu-item "Toggle Max Frame" toggle-max-frame
		:help "Maximize or restore the selected frame (in both directions)"
		:enable (or (frame-parameter nil 'restore-width) (frame-parameter nil 'restore-height))))
  (define-key menu-bar-frames-menu [maximize-frame-vertically]
    '(menu-item "Maximize Frame Vertically" maximize-frame-vertically
		:help "Maximize the selected frame vertically"))
  (define-key menu-bar-frames-menu [maximize-frame-horizontally]
    '(menu-item "Maximize Frame Horizontally" maximize-frame-horizontally
		:help "Maximize the selected frame horizontally"))
  (define-key menu-bar-frames-menu [maximize-frame]
    '(menu-item "Maximize Frame" maximize-frame
		:help "Maximize the selected frame (in both directions)"))
  (define-key menu-bar-frames-menu [separator-frame-3] '("--"))
  (define-key menu-bar-frames-menu [iconify-everything]
    '(menu-item "Iconify All Frames" iconify-everything
		:help "Iconify all frames of session at once"))
  (define-key menu-bar-frames-menu [show-hide]
    '(menu-item "Hide Frames / Show Buffers" show-hide
		:help "Show, if only one frame visible; else hide."))
  (define-key menu-bar-frames-menu [separator-frame-4] '("--"))
  (define-key menu-bar-frames-menu [move-to-top]
    '(menu-item "Move frame to top of screen" move-frame-to-screen-top
		:help "Move the frame to the top of the screen."))
  (define-key menu-bar-frames-menu [move-to-bottom]
    '(menu-item "Move frame to the bottom of screen" move-frame-to-screen-bottom
		:help "Move the frame to the bottom of the screen."))
  (define-key menu-bar-frames-menu [move-to-left]
    '(menu-item "Move frame to the left" move-frame-to-screen-left
		:help "Move the frame to the left of the screen."))
  (define-key menu-bar-frames-menu [move-to-right]
    '(menu-item "Move frame to the right" move-frame-to-screen-right
		:help "Move the frame to the right of the screen."))
  (define-key menu-bar-frames-menu [enlarge]
    '(menu-item "Enlarge the frame vertically" myenlarge-frame
		:help "Enlarge the frame vertically until it reaches the borders."))
  (define-key menu-bar-frames-menu [enlarge-horizontally]
    '(menu-item "Enlarge the frame horizontally" myenlarge-frame-horizontally
		:help "Enlarge the frame horizontally until it reaches the borders."))
  (define-key menu-bar-frames-menu [shrink]
    '(menu-item "Shrink the frame vertically" myshrink-frame
		:help "Shrink the frame vertically."))
  (define-key menu-bar-frames-menu [shrink-horizontally]
    '(menu-item "Shrink the frame horizontally" myshrink-frame-horizontally
		:help "Shrink the frame horizontally."))
  (define-key menu-bar-frames-menu [separator-frame-5] '("--"))
  (define-key menu-bar-frames-menu [winner-undo]
    '(menu-item "Restore previous windows" winner-undo
		:help "Restore previous windows layout."))
  (define-key menu-bar-frames-menu [winner-redo]
    '(menu-item "Undo restore windows" winner-redo
		:help "Come back to windows layout before the last restore."))
  (define-key menu-bar-frames-menu [separator-frame-6] '("--"))
  (define-key menu-bar-frames-menu [jump-to-next-frame]
    '(menu-item "Other windows frame" other-window-or-frame
		:help "Jump to other window or frame."))
  (define-key menu-bar-frames-menu [jump-to-frame-right]
    '(menu-item "Jump to frame right" fm-right-frame
		:help "Jump to frame on the right."))
  (define-key menu-bar-frames-menu [jump-to-frame-left]
    '(menu-item "Jump to frame left" fm-left-frame
		:help "Jump to frame on the left."))
  (define-key menu-bar-frames-menu [jump-to-frame-up]
    '(menu-item "Jump to frame up" fm-up-frame
		:help "Jump to frame up."))
  (define-key menu-bar-frames-menu [jump-to-frame-down]
    '(menu-item "Jump to frame down" fm-down-frame
		:help "Jump to frame down."))
  (define-key menu-bar-frames-menu [other-frame]
    '(menu-item "Switch frame" other-frame
		:help "Switch to other frame."))
)

;; (defvar menu-bar-doremi-menu (make-sparse-keymap "Do Re Mi"))
;; (define-key global-map [menu-bar doremi]
;;   (cons "Do Re Mi" menu-bar-doremi-menu))
;; (define-key menu-bar-doremi-menu [doremi-font+]
;;   '("Save Frame Configuration" . save-frame-config))


;;-----------------------------------------------------------------------------
;; Windows only settings
;;-----------------------------------------------------------------------------
(defun windows-only-settings ()
  ;; What long lines should look like
  (set-fringe-mode (cons 0 8))
)

;;-----------------------------------------------------------------------------
;; Console only settings
;;-----------------------------------------------------------------------------
(defun console-only-settings ()
  (interactive)
  ;; Scroll wheel and mouse in console rock!
  ;; but they only work in emacs 21 with these settings
  (require 'xt-mouse)
  (xterm-mouse-mode t)
  (mouse-wheel-mode t)

  ;; does this work ?
  (if (load "mwheel" t)
      (mwheel-install))
)

;; Load Windows or Console settings
(when (string= window-system "w32") (windows-only-settings))
(when (eq window-system nil) (console-only-settings))

(provide 'display-conf)
