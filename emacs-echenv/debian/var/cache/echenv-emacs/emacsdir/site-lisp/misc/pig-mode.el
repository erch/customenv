; -*- Mode: Emacs-Lisp -*-

;;; pig-mode.el -- Major mode for Pig files

;; Author: Sergiy Matusevych <motus@yahoo-inc.com>

;; Put this file into your Emacs lisp path (eg. site-lisp)
;; and add the following line to your ~/.emacs file:
;;
;;   (require 'pig-mode)

(require 'font-lock)

(defvar pig-mode-hook nil)

(defvar pig-mode-map
  (let ((keymap (make-sparse-keymap)))
    (define-key keymap (kbd "RET") 'newline-and-indent)
    keymap)
  "Keymap for pig major mode")

(add-to-list 'auto-mode-alist '("\\.pig\\'" . pig-mode))

(defconst pig-font-lock-keywords
  `((,(regexp-opt
       '("LOAD" "STORE" "FILTER" "FOREACH" "ORDER" "ARRANGE"
         "DISTINCT" "COGROUP" "JOIN" "CROSS" "UNION" "SPLIT" "INTO"
         "IF" "ALL" "ANY" "AS" "BY" "USING" "INNER" "OUTER" "PARALLEL"
         "GROUP" "CONTINUOUSLY" "WINDOW" "TUPLES" "GENERATE" "EVAL"
         "DEFINE" "INPUT" "OUTPUT" "SHIP" "CACHE" "STREAM" "THROUGH"
         "SECONDS" "MINUTES" "HOURS" "ASC" "DESC"
         "NULL" "AND" "OR" "NOT" "EQ" "NEQ" "GT" "LT" "GTE" "LTE"
         "MATCHES" "IS")
       'words)
     (1 font-lock-keyword-face))

    ("^ *\\(REGISTER\\) *\\([^;]+\\)"
     (1 font-lock-keyword-face)
     (2 font-lock-string-face))
    (,(concat
       (regexp-opt
        '("FLATTEN" "SUM" "COUNT" "MIN" "MAX" "AVG" "ARITY" "TOKENIZE"
          "DIFF" "SIZE" "CONCAT"
          "BinStorage" "PigStorage" "TextLoader" "PigDump" "IsEmpty")
        'words)
       "(")
     (1 font-lock-function-name-face))
    ("\\<\\([0-9]+[lL]\\|\\([0-9]+\\.?[0-9]*\\|\\.[0-9]+\\)\\([eE][-+]?[0-9]+\\)?[fF]?\\)\\>"
     . font-lock-constant-face)
    ("\\<$[0-9]+\\>" . font-lock-variable-name-face)
    (,(regexp-opt
       '("chararray" "bytearray" "int" "long" "float" "double" "tuple"
         "bag" "map")
       'words)
     (1 font-lock-type-face)))
  "regexps to highlight in pig mode")

(defvar pig-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?_  "w"      st)
    (modify-syntax-entry ?-  ". 56"   st)
    (modify-syntax-entry ?-  ". 12b"  st)
    (modify-syntax-entry ?/  ". 1456" st)
    (modify-syntax-entry ?*  ". 23"   st)
    (modify-syntax-entry ?\n "> b"    st)
    (modify-syntax-entry ?\" "\""     st)
    (modify-syntax-entry ?\' "\""     st)
    (modify-syntax-entry ?\` "\""     st)
    st)
  "Syntax table for pig mode")

(defun pig-indent-line ()
  "Indent current line as Pig code"
  (interactive)
  (indent-line-to (save-excursion
    (beginning-of-line)
    (if (looking-at ".*}[ \t]*;[ \t]*$")
        (pig-statement-indentation)
      (forward-line -1)
      (while (and (not (bobp)) (looking-at "^[ \t]*$"))
        (forward-line -1) )
      (cond
       ((bobp) 0)
       ((looking-at "^[ \t]*--") (current-indentation))
       ((looking-at ".*;[ \t]*$") (pig-statement-indentation))
       (t (+ (pig-statement-indentation) default-tab-width)) ) ) )) )

(defun pig-statement-indentation ()
  (save-excursion
    (beginning-of-line)
    (cond
     ((bobp) 0)
     ((looking-at ".*\\(}[ \t]*;\\|)\\)[ \t]*$")
      (end-of-line)
      (backward-list)
      (pig-statement-indentation) )
     ((search-backward-regexp "[{;][ \t]*$" nil t)
      (forward-line 1)
      (beginning-of-line)
      (while (and (looking-at "^[ \t]*\\(--.*\\)?$")
                  (save-excursion (end-of-line) (not (eobp))) )
        (forward-line 1) )
      (current-indentation) )
     (t 0) ) ) )

(define-derived-mode pig-mode fundamental-mode "pig"
  "Major mode for editing Yahoo! .pig files"
  :syntax-table pig-mode-syntax-table
  (set (make-local-variable 'font-lock-defaults) '(pig-font-lock-keywords nil t))
  (set (make-local-variable 'indent-line-function) 'pig-indent-line) )

(provide 'pig-mode)

;;; end of pig-mode.el
