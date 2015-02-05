(message "loadind custom-conf ...")
(require 'ech-env)
(require 'ech-mode)

(ech-add-menu "Custom"
	      (easy-menu-create-menu "Custom"
				     '(("Display"
				      ["Narrow to defun" narrow-to-defun [help:"Narrow text to defun"]]
				      ["Narrow to region" narrow-to-region   [help:"Narrow text to region"]]
				      ["Widden"  widen  [help:"Remove narrowing restriction"]])
				     "--"
				     ("Org"
				      ["Capture" org-capture  [help:"Quick capture of Anything for post processing"]])
				     ("Movement"
				      ["Page Down" scroll-down-command  [help:"Go One page down" ]]
				      ["Start of Sentence" forward-sentence  [help:"Go to the beginning of sentence" ]]
				      ["End of Sentence" backward-sentence  [help:"Go to the end of sentence" ]]
				      ["Start of paragraph"  backward-paragraph  [help:"Go to the beginning of paragraph"]]
				      ["End of paragraph"  forward-paragraph  [help:"Go to end of paragraph"]]
				      ["Up" previous-line   [help:"Go Previous Line"]]
				      ["Down" next-line   [help:"Go next Line"]]
				      ["Left" forward-char   [help:"Go forward one char"]]
				      ["Right" backward-char  [help:"Go backward one char"]]
				      ["Page Up"  scroll-up-command  [help:"Go One page up"]])
				     ("Edit"
				      ["Delete previous word" backward-kill-word  [help:"Kill word before cursor" ]]
				      ["Uper case region"  upcase-region  [help:"Change a region to upper case"]]
				      ["Lower case region"  downcase-region  [help:"Change a region to lower case word"]]
				      ;;["Text completion" "Cycle through possible completions" ]
				      ["New line indent" newline-and-indent   [help:"Insert CR after cursor and indent" ]]
				      ["Undo" undo   [help:"undo"]])
				     )))

(message "custom-conf loaded.")
(provide 'custom-conf)
