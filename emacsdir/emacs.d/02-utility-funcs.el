; utility functions
(load-library "cl-seq")

(if (memq system-type '(windows-nt))
    (progn
      (setq path-sep "\\")
      (setq clpath-sep ";"))
  (progn
    (setq path-sep "/")
    (setq clpath-sep ":")))

(unless (boundp 'setq-local)
  (defmacro setq-local (var value) 
    `(progn
      (make-local-variable ',var)
      (setq ,var ,value))))

;(setq myvar 1)
;(setq-local myvar 2)

(defun flattenlists(res &rest lists)
  "return a list of string with all strings find in any lists inside list and otherlist recursively"
  (cond ((null lists) res)
	((consp (car lists)) (flattenlists res (car (car lists)) (append (cdr (car lists)) (cdr lists))))
	(t (flattenlists (cons (car lists) res) (append (car (cdr lists)) (cdr (cdr lists)))))))

; (flattenlists () '("a" "b"))
; (flattenlists ())
; (flattenlists () "a")
; (cons "a" '( "b" "c"))
; (append nil nil)
(defun list2string(list)
"return all strings in list in one string with space as separator"
  (if (eq (cdr list) nil) (car list)
    (concat (car list) " " (list2string (cdr list)))))

(defun intercal (chars list)
  "returns a string in which the string chars is intercalled between each element in list"
  (if (eq (cdr list) nil) (car list)
    (concat (car list) chars (intercal chars (cdr list)))))

(defun file-name-os (file-name)
  "get a file name according to the os naming convention"
  (let ((fn (if (listp file-name) (list2string file-name) file-name)))
    (if (memq system-type '(windows-nt cygwin)) 
        (intercal "\\"  (split-string fn "/"))
      fn)))

(defun prj-path-less-path (path-to-suppress path )
  "delete  path-to-suppress in path. path are list of strings."
  (if (eq path-to-suppress nil) path
    (remove (car path-to-suppress) (prj-path-less-path (cdr path-to-suppress) path))))

(defun find-first-named-dirs-in-list (dirs src depth exclude-list maxdepth)
  (let ((first (car dirs))
        (others (cdr dirs)))
    (cond 
     ((not others) nil)
     ((or 
       (not first)
       (not (file-directory-p first))
       (member (file-name-nondirectory (directory-file-name first)) exclude-list))
      (find-first-named-dirs-in-list others src depth exclude-list maxdepth))
     (t (append 
         (find-first-named-dirs-in-dirtree-rec first src depth exclude-list maxdepth) (find-first-named-dirs-in-list others src depth exclude-list maxdepth))))))

(defun find-first-named-dirs-in-dirtree-rec (from src depth exclude-list maxdepth)
  "called by find-first-named-dirs-in-dirtree to initiate recursivity with depth count"
  (and (file-directory-p from)
       (or (and maxdepth (< depth maxdepth)) (not maxdepth))
       (let*
           ((dirs (directory-files from))
            (srcdir (find  src dirs :test 'string=)))
         (if srcdir 
             (list (file-name-as-directory (expand-file-name srcdir from)))
           (progn
             (find-first-named-dirs-in-list 
              (mapcar (lambda(x) 
                        (and (not (string= "." x))
                             (not (string= ".." x))
                             (file-name-as-directory (expand-file-name x from)))) dirs) src (+  1 depth) exclude-list maxdepth))))))

(defun find-first-named-dirs-in-dirtree(from src &optional exclude-list maxdepth)
  "return the list of path to directories named src find in the directory from. Go in childs directories recursively but stop going deeper in a directory when found a matching directory"
  (and (file-directory-p from)
       (progn
         (find-first-named-dirs-in-dirtree-rec (file-name-as-directory (expand-file-name from)) src 0 exclude-list maxdepth))))

(defun print-list(x)
  (message (intercal " " x)))


(defun non-dot-directory-files (dir)
  "Return a list of file names in dir without the . and .. directories"
  (let ((dirn (or (and (null dir) nil) (file-name-nondirectory (directory-file-name dir)))))
    ;;(message "=> dir is %s,dirn is %s" dir dirn)
    (when
	(and (not (null dir)) 
	     (not (string= "." dirn)) 
	     (not (string= ".." dirn)))
      (sup-dots (directory-files dir t)))))

(defun sup-dots (list)
  "suppress . and .. from a list of file names"
  (when (not (null list))
    (let* ((first (car list))
	   (end (cdr list))
	   (fnd (or (and (null first) nil) (file-name-nondirectory (directory-file-name first)))))
      ;;(message "\t + list is %s, first is %s, end is %s, fnd is %s" list first end fnd)
      (cond
       ((null list) ())
       ((or (null first) 
	    (string= "." fnd) 
	    (string= ".." fnd)) 
	(sup-dots end))
       (t (cons first (sup-dots end)))))))

;;(non-dot-directory-files project-dir)

(require 'calendar)

(defun week-day-time-from-date (wkday  &optional nth-week time)
    "time of the nth wkday after/before time - default time is now.
A wkday of 0 means Sunday, 1 means Monday, and so on.
If nth-week > 0, return the Nth DAYNAME after time (inclusive).
If nth-week < 0, return the Nth DAYNAME before time  (inclusive)."
    (let* ((tl (if (null time) (decode-time) (decode-time time)))
	   (wk (if (null nth-week) +1 nth-week))
	   (sec (nth 0 tl))
	   (min (nth 1 tl))
	   (hour (nth 2 tl))  
	   (day (nth 3 tl))
	   (month (nth 4 tl))
	   (year (nth 5 tl))
	   (prev-day (calendar-nth-named-day wk wkday month year day))
	   (prev-year (nth 2 prev-day))
	   (prev-month (nth 0 prev-day))
	   (prev-day (nth 1 prev-day)))
      (list prev-year prev-month prev-day)))

;(week-day-time-from-date 2)

(defun format-week-day-from-date (format-str wkday &optional week time)
  "Return the formated date of a week day prior to a date. week days are number from 0 to 6 with 0 being Sunday. By default time is now. The number of weeks before or after is an integer with -1 meaning the day before current week, +1 current week after, by default it's -1"
  (let* ((prev-day (week-day-time-from-date wkday week time))      
	 (prev-year (nth 0 prev-day))
	 (prev-month (nth 1 prev-day))
	 (prev-day (nth 2 prev-day)))
      (format  format-str prev-year prev-month prev-day)))

(defun time-nth-months-back (n &optional tme)
  "get the month number for n month back than time"
  (let* ((tl  (if (null tme) (decode-time) (decode-time tme)))
	 (sec (nth 0 tl))
	 (min (nth 1 tl))
	 (hour (nth 2 tl))
	 (day (nth 3 tl))
	 (month (nth 4 tl))
	 (year (nth 5 tl))
	 (dest-month (+ 1 (% (- (+ month (* 12 (+ 1 (/ n 12)))) (+ 1 n)) 12)))
	 (dest-year (- year (/ n 12))))
    (encode-time sec min hour day dest-month dest-year)))

;;(calendar-nth-named-day -1 1 07 2009 27)
;;(decode-time (week-day-time-from-date 3))
;;(format-week-day-from-date  "%4d-%02d" 3)
;;(format-week-day-from-date  "%4d-%02d-%02d" 1 +1 (encode-time 0 0 0 1 7 2011))
;;(week-day-from-date 1 +1  (encode-time 0 0 0 1 8 2011))

(provide '02-utility-funcs)
