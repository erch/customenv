(require 'ech-env)
(require 'debug-utils)
(require 'ert)
(ech-install-and-load 'mocker)

;; Use (load-file) below because we want to always read the source.
;; Also, we don't want no stinking compiled source.
(load-file (expand-file-name "./utility-funcs.el" core-dir))

(defun make-keymap-test(menu-title)
  (let ((keymap (make-sparse-keymap menu-title)))
    (define-key keymap (vector (make-symbol "Forward word")) (cons "Forward word" 'forward-word))
    (define-key keymap (vector (make-symbol "Find File")) (cons "Find File" 'find-file))
    keymap
    ))

(defun make-keymap-mergee(menu-title)
  (let ((keymap (make-sparse-keymap menu-title)))
    (define-key keymap (vector (make-symbol "Forward word")) (cons "Mergee Forward word" 'forward-char))
    (define-key keymap (vector (make-symbol "Backward word")) (cons "Backward word" 'backward-word))
    keymap
    ))			

(defun keymap-correct-p (keymap expected-keys avoid-keys)
  "test that key map contains the keys in the expected-keys list and none of the keys in avoid-keys list.

The elements in both lists are lists of two elements (evt binding), works only with 
symbol bindings.
"  
  (not (or (catch 'incorrect
	     (--each
		 expected-keys
	       (let* ((evt (nth 0 it))
		      (binding (nth 1 it))
		      (key (lookup-key keymap evt)))
		 (cl-assert (symbolp binding))
		 (when (or (null key)
			   (not (symbolp key))
			   (not (equal binding key)))
		   (throw 'incorrect t)))))      
	   (catch 'incorrect
	     (--each avoid-keys
	       (let* ((evt (nth 0 it))
		      (binding (nth 1 it))
		      (key (lookup-key keymap evt)))
		 (cl-assert (symbolp binding))
		 (when (and (not (null key))
			    (equal binding key))
		   (throw 'incorrect t))))))))

(ert-deftest test-ech-add-menu-same-menu-string-menu-title-parameter ()
  "test ech-add-menu with a menu that already exists with  one key overiden. use the menu-title parameter
and the mergee key map has no menu string"
  (let ((ech-mode-map (make-sparse-keymap))
	(test-keymap (make-keymap-test nil))
	(ech-menu-maps-alist nil)
	(mergee (make-keymap-mergee nil)))
    (push (cons "Test" test-keymap) ech-menu-maps-alist)
    (define-key ech-mode-map (vector 'menu-bar (intern "Test")) (cons "Test" test-keymap))
    (dbg-print-keymap ech-mode-map)
    (dbg-print-keymap mergee)
    (ech-add-menu mergee "Test" )
    (dbg-print-keymap ech-mode-map)
    (should (keymap-correct-p ech-mode-map
			      `(				
				([menu-bar Test ,(make-symbol "Forward word")] forward-char)
				([menu-bar Test ,(make-symbol "Backward word")] backward-word)
				([menu-bar Test ,(make-symbol "Find File")] find-file))
			      `(([menu-bar Test ,(make-symbol "Forward word")] forward-word))))))

(ert-deftest test-ech-add-menu-same-menu-string-no-menu-string-parameter ()
  "test ech-add-menu with a menu that already exists with  one key overiden. use a mergee key map with a menu string and don't pass a menu-title parameter"
  (let ((ech-mode-map (make-sparse-keymap))
	(test-keymap (make-keymap-test nil))
	(ech-menu-maps-alist nil)
	(mergee (make-keymap-mergee "Test")))
    (push (cons "Test" test-keymap) ech-menu-maps-alist)
    (define-key ech-mode-map (vector 'menu-bar (intern "Test")) (cons "Test" test-keymap))
    (dbg-print-keymap ech-mode-map)
    (dbg-print-keymap mergee)
    (ech-add-menu mergee)
    (dbg-print-keymap ech-mode-map)
    (should (keymap-correct-p ech-mode-map
			      `(				
				([menu-bar Test ,(make-symbol "Forward word")] forward-char)
				([menu-bar Test ,(make-symbol "Backward word")] backward-word)
				([menu-bar Test ,(make-symbol "Find File")] find-file))
			      `(([menu-bar Test ,(make-symbol "Forward word")] forward-word))))))


(ert-deftest test-ech-add-items-to-keymap-no-menu-string ()
  "test  ech-add-items-to-keymap to a keymap, one key is overiden"
  (let ((ech-mode-map (make-sparse-keymap))
	(test-keymap (make-keymap-test "Test"))
	(mergee (make-keymap-mergee nil)))    
    (define-key ech-mode-map (vector 'menu-bar (intern "Test")) (cons "Test" test-keymap))
    (ech-add-items-to-keymap (vector 'menu-bar (intern "Test")) mergee)    
    ;;(dbg-print-keymap mergee)
    (dbg-print-keymap ech-mode-map)
    (should (keymap-correct-p ech-mode-map
			      `(				
				([menu-bar Test ,(make-symbol "Forward word")] forward-char)
				([menu-bar Test ,(make-symbol "Backward word")] backward-word)
				([menu-bar Test ,(make-symbol "Find File")] find-file))
			      `(([menu-bar Test ,(make-symbol "Forward word")] forward-word))))))

(ert-deftest test-ech-merge-keymaps-no-menu-string ()
  "add keys to test-keymap"
  (let ((test-keymap (make-keymap-test "Test"))	
	(mergee (make-keymap-mergee nil))	
	res) 
    (setq res (ech-merge-keymaps test-keymap mergee))
    ;;(dbg-print-keymap test-keymap)
    ;;(dbg-print-keymap mergee)
    ;;(dbg-print-keymap res)
    (should (keymap-correct-p res
			      `(				
				([,(make-symbol "Forward word")] forward-char)
				([,(make-symbol "Backward word")] backward-word)
				([,(make-symbol "Find File")] find-file))
			      `(([,(make-symbol "Forward word")] forward-word))))))

(ert-deftest test-ech-merge-keymaps-with-menu-string-no-overlap ()
  "add a submenu to test-keymap"
  (let ((test-keymap (make-keymap-test "Test"))	
	(mergee (make-keymap-mergee "Words"))	
	res) 
    (setq res (ech-merge-keymaps test-keymap mergee))
    ;;(dbg-print-keymap test-keymap)
    ;;(dbg-print-keymap mergee)
    (dbg-print-keymap res)
    (should (keymap-correct-p res
			      `(				
				([Words ,(make-symbol "Forward word")] forward-char)
				([Words ,(make-symbol "Backward word")] backward-word)
				([,(make-symbol "Forward word")] forward-word)
				([,(make-symbol "Find File")] find-file))
			      nil))))

(ert-deftest test-ech-merge-keymaps-with-menu-string-with-overlap ()
  "test overiding a submenu, the old one is replaced by mergee"
  (let ((test-keymap (make-keymap-test nil))
	(words-keymap (make-sparse-keymap "Words"))
	(mergee (make-keymap-mergee "Words"))	
	res)    
    (define-key words-keymap (vector (make-symbol "Forward word")) (cons "Forward word" 'forward-word))
    (define-key words-keymap (vector (make-symbol "Find File")) (cons "Find File" 'find-file))
    (define-key test-keymap  (vector (make-symbol "Words")) (cons "Words" words-keymap))
    (setq res (ech-merge-keymaps test-keymap mergee))
    ;;(dbg-print-keymap test-keymap)
    ;;(dbg-print-keymap mergee)
    (dbg-print-keymap res)
    (should (keymap-correct-p res
			      `(				
				([Words ,(make-symbol "Forward word")] forward-char)
				([Words ,(make-symbol "Backward word")] backward-word)				
				([,(make-symbol "Forward word")] forward-word)
				([,(make-symbol "Find File")] find-file))
			      nil))))
