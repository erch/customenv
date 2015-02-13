;; create key definition for ensuring coherency

(defconst ech-key-dbg-prefix "C-c C-d " "key prefix for all commands related to debuging")
(defconst ech-key-dbg-print-keymap (kbd (concat ech-key-dbg-prefix "k")))

(defconst ech-key-mode-prefix "C-c C-e " "key prefix for ech mode commands")

(defconst ech-key-mode-prefix (kbd (concat ech-key-mode-prefix "s")) "key for starting sunrise commander")
(defconst ech-key-completion (kbd "M-<space>"))

(provide 'ech-keydefs)
