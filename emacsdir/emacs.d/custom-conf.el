(message "loadind custom-conf ...")

(unless (require 'nav nil t)
  (progn
    (package-install 'nav)
    (require 'nav)
    ))

(nav-disable-overeager-window-splitting)

(insert-global-menu-and-key-bindings 
 "Custom"
 '(
   ("Display"
    ["Narrow to defun" "Narrow text to defun" narrow-to-defun]
    ["Narrow to region" "Narrow text to region" narrow-to-region]
    ["Widden" "Remove narrowing restriction" widen]
    )
   "--"
   ("Org"
    ["Capture" "Quick capture of Anything for post processing" org-capture]
    )
   ("Movement"
    ["Page Down" "Go One page down" scroll-down-command]
    ["Start of Sentence" "Go to the beginning of sentence" forward-sentence]
    ["End of Sentence" "Go to the end of sentence" backward-sentence]
    ["Start of paragraph" "Go to the beginning of paragraph" backward-paragraph]
    ["End of paragraph" "Go to end of paragraph" forward-paragraph]
    ["Up" "Go Previous Line" previous-line]
    ["Down" "Go next Line" next-line]
    ["Left" "Go forward one char" forward-char]
    ["Right" "Go backward one char" backward-char]
    ["Page Up" "Go One page up" scroll-up-command]
    )
   ("Edit"
    ["Delete previous word" "Kill word before cursor" backward-kill-word]
    ["Uper case region" "Change a region to upper case" upcase-region]
    ["Lower case region" "Change a region to lower case word" downcase-region]
    ;;["Text completion" "Cycle through possible completions" ]
    ["New line indent" "Insert CR after cursor and indent" newline-and-indent]
    ["Undo" "undo" undo]
    )
   )
 )

(message "custom-conf loaded.")
(provide 'custom-conf)
