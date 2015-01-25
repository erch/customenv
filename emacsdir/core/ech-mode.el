(require 'easymenu)

(defvar ech-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c o") 'prelude-open-with)
    (define-key map (kbd "C-c g") 'prelude-google)
    (define-key map (kbd "C-c G") 'prelude-github)
    (define-key map (kbd "C-c y") 'prelude-youtube)
    (define-key map (kbd "C-c U") 'prelude-duckduckgo)
    ;; mimic popular IDEs binding, note that it doesn't work in a terminal session
    (define-key map [(shift return)] 'prelude-smart-open-line)
    (define-key map (kbd "M-o") 'prelude-smart-open-line)
    (define-key map [(control shift return)] 'prelude-smart-open-line-above)
    (define-key map [(control shift up)]  'move-text-up)
    (define-key map [(control shift down)]  'move-text-down)
    (define-key map [(meta shift up)]  'move-text-up)
    (define-key map [(meta shift down)]  'move-text-down)
    (define-key map (kbd "C-c n") 'prelude-cleanup-buffer-or-region)
    (define-key map (kbd "C-c f")  'prelude-recentf-ido-find-file)
    (define-key map (kbd "C-M-z") 'prelude-indent-defun)
    (define-key map (kbd "C-c u") 'prelude-view-url)
    (define-key map (kbd "C-c e") 'prelude-eval-and-replace)
    (define-key map (kbd "C-c s") 'prelude-swap-windows)
    (define-key map (kbd "C-c D") 'prelude-delete-file-and-buffer)
    (define-key map (kbd "C-c d") 'prelude-duplicate-current-line-or-region)
    (define-key map (kbd "C-c M-d") 'prelude-duplicate-and-comment-current-line-or-region)
    (define-key map (kbd "C-c r") 'prelude-rename-buffer-and-file)
    (define-key map (kbd "C-c t") 'prelude-visit-term-buffer)
    (define-key map (kbd "C-c k") 'prelude-kill-other-buffers)
    (define-key map (kbd "C-c TAB") 'prelude-indent-rigidly-and-copy-to-clipboard)
    (define-key map (kbd "C-c I") 'prelude-find-user-init-file)
    (define-key map (kbd "C-c S") 'prelude-find-shell-init-file)
    (define-key map (kbd "C-c i") 'prelude-goto-symbol)
    ;; extra prefix for projectile
    (define-key map (kbd "s-p") 'projectile-command-map)
    ;; make some use of the Super key
    (define-key map (kbd "s-g") 'god-local-mode)
    (define-key map (kbd "s-r") 'prelude-recentf-ido-find-file)
    (define-key map (kbd "s-j") 'prelude-top-join-line)
    (define-key map (kbd "s-k") 'prelude-kill-whole-line)
    (define-key map (kbd "s-m m") 'magit-status)
    (define-key map (kbd "s-m l") 'magit-log)
    (define-key map (kbd "s-m f") 'magit-file-log)
    (define-key map (kbd "s-m b") 'magit-blame-mode)
    (define-key map (kbd "s-o") 'prelude-smart-open-line-above)

    map)
  "Keymap for ech mode.")

(defun ech-mode-add-menu ()
  "Add a menu entry for `ech-mode' under."
  (easy-menu-add-item nil '("Tools")
                      '("Prelude"
                        ("Files"
                         ["Open with..." prelude-open-with]
                         ["Delete file and buffer" prelude-delete-file-and-buffer]
                         ["Rename buffer and file" prelude-rename-buffer-and-file])

                        ("Buffers"
                         ["Clean up buffer or region" prelude-cleanup-buffer-or-region]
                         ["Kill other buffers" prelude-kill-other-buffers])

                        ("Editing"
                         ["Insert empty line" prelude-insert-empty-line]
                         ["Move line up" prelude-move-line-up]
                         ["Move line down" prelude-move-line-down]
                         ["Duplicate line or region" prelude-duplicate-current-line-or-region]
                         ["Indent rigidly and copy to clipboard" prelude-indent-rigidly-and-copy-to-clipboard]
                         ["Insert date" prelude-insert-date]
                         ["Eval and replace" prelude-eval-and-replace]
                         )

                        ("Windows"
                         ["Swap windows" prelude-swap-windows])

                        ("General"
                         ["Visit term buffer" prelude-visit-term-buffer]
                         ["Search in Google" prelude-google]
                         ["View URL" prelude-view-url]))
                      "Search Files (Grep)...")

  (easy-menu-add-item nil '("Tools") '("--") "Search Files (Grep)..."))

(defun ech-mode-remove-menu ()
  "Remove `ech-mode' menu entry."
  (easy-menu-remove-item nil '("Tools") "Prelude")
  (easy-menu-remove-item nil '("Tools") "--"))

;; define minor mode
(define-minor-mode ech-mode
  "Minor mode for ech customisations.

\\{ech-mode-map}"
  :lighter " Ech"
  :keymap ech-mode-map
  (if ech-mode
      ;; on start
      (ech-mode-add-menu)
    ;; on stop
    (ech-mode-remove-menu)))

(define-globalized-minor-mode ech-global-mode ech-mode ech-on)

(defun ech-on ()
  "Turn on `ech-mode'."
  (ech-mode +1))

(defun ech-off ()
  "Turn off `ech-mode'."
  (ech-mode -1))

(provide 'ech-mode)

