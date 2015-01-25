(require 'ech-env)
(when (or (string= system-type "ms-dos") (string= system-type "windows-nt"))
  (add-to-list 'exec-path "c:/Program Files/MySQL/MySQL Server 5.0/bin"))
(require 'ech-env)
(load "sql")
(load-library "sql-indent")
(eval-and-compile
  (setq sql-user "ech")
  (setq sql-password "ech")
  (setq sql-database "project_management")
  (setq sql-server "forceweight.corp.yahoo.com")
  (setq sql-product "MySQL")
  (setq sql-mysql-options '("-C" "-t" "-f" "-n" "-v")))

;(eval-after-load "sql"
;  '(load-library "sql-with-placeholders"))

(add-hook 'sql-mode-hook (lambda nil
                           (local-set-key [(control c) (control b)] 'sql-send-buffer)
                           (local-set-key [(control c) (control c)] 'sql-send-paragraph)
                           (local-set-key [(control c) (control r)] 'sql-send-region)))

;;(setq sql-association-alist
;;      '(("-" ("LABEL1" "" ""))
;;        ("-" ("----" "" ""))
;;        ("MNEMONIC1" ("SERVER1" "LOGIN-ID1" "PASSWORD1" "DATABASE1"))
;;        ("MNEMONIC2" ("SERVER2" "LOGIN-ID2" "PASSWORD2"))
;;        ("-" ("----" "" ""))
;;        ("-" ("LABEL2" "" ""))
;;        ("-" ("----" "" ""))
;;        ("MNEMONIC3" ("SERVER3" "LOGIN-ID3" nil "DATABASE3"))
;;        ("MNEMONIC4" ("SERVER4" "LOGIN-ID4" "PASSWORD4"))))
(provide 'sql-conf)
