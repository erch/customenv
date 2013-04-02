(message "loading java-conf ...")
(unless (require 'eclim nil t)
  (progn
    (package-install 'emacs-eclim)
    ;(load-library "eclim")
))

(unless (require 'javadoc-lookup nil t)
  (progn
    (package-install 'javadoc-lookup)
    ;(load-library "javadoc-lookup")
))

;; bug in eclim-maven that defines a wrong regexp for compilation buffer
(let 
    ((error-reg-list compilation-error-regexp-alist))
  (require 'eclim-maven)
  (setq compilation-error-regexp-alist error-reg-list))

(require 'yasnippet-conf)
(require 'javadoc-lookup)
(require 'maven-fetch)
(require 'eclimd)
(require 'eclim)

(require 'completion-conf)

(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)
(global-eclim-mode)

(setq javadoc-lookup-cache-dir "~/.javadoc")
(setq eclimd-executable "~/opt/eclipse/eclimd")
(setq eclim-eclipse-dirs '("~/opt/eclipse"))
(setq eclimd-wait-for-process t)
(setq eclimd-default-workspace "~/eclimworkspace")
(setq eclim-executable "~/opt/eclipse/eclim")

(defun  java-mode-cust()
  "customisation for java buffers"
  (setq-local eclim-auto-save t)
  ;;  auto-complete
  (auto-complete-mode 1)
  (setq-local ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
  (setq-local help-at-pt-display-when-idle t)
  (setq-local help-at-pt-timer-delay 0.1)
  (setq-local ac-delay 0.1)
  (setq-local ac-auto-start 0)
  (help-at-pt-set-timer)
  (make-local-variable 'compilation-error-regexp-alist-alist)
  (add-to-list 'compilation-error-regexp-alist 'maven)
  (add-to-list 'compilation-error-regexp-alist-alist
	       '(maven "\\[ERROR\\] \\(.+?\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\].*"
		       1 2 3))
  (let* 
      ((ecust-snips (file-name-as-directory (expand-file-name "snippets/java" (file-name-directory emacs-d-dir))))
       (eclim-snips (file-name-as-directory (expand-file-name "snippets" (file-name-directory (locate-library "eclim"))))))
    (activate-yasnippet-with-dirs (list ecust-snips eclim-snips))
    ;(message (list ecust-snips eclim-snips))
    ))      

(java-mode-cust)
(add-hook 'java-mode-hook 'java-mode-cust)
(message "java-conf loaded")
(provide 'java-conf)
