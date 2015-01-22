(eval-and-compile
  (add-to-list 'load-path (expand-file-name "vm"  ech-site-lisp-dir))
  
  (autoload 'vm "vm" "Start VM on your primary inbox." t)
  (autoload 'vm-other-frame "vm" "Like `vm' but starts in another frame." t)
  (autoload 'vm-visit-folder "vm" "Start VM on an arbitrary folder." t)
  (autoload 'vm-visit-virtual-folder "vm" "Visit a VM virtual folder." t)
  (autoload 'vm-mode "vm" "Run VM major mode on a buffer" t)
  (autoload 'vm-mail "vm" "Send a mail message using VM." t)
  (autoload 'vm-submit-bug-report "vm" "Send a bug report about VM." t)

  (setq user-full-name "Eric Chastan"
	mail-from-style 'angles
	user-mail-address "echastan@bestofmedia.com"
	mail-default-reply-to user-mail-address)     

  (setq vm-mutable-windows t
	vm-mutable-frames nil)

  (let* ((mail-dir (expand-file-name "../mail-archive" (getenv "DEV_HOME")))
	 (default-inbox  (expand-file-name "inbox" mail-dir))
	 (default-crashbox (expand-file-name "crash-box" mail-dir))
	 )
    (progn 
      (setq vm-primary-inbox default-inbox	    
	  vm-crash-box default-crashbox)
      (setq vm-spool-files
	    (list
	     (list default-inbox    "imap:mail.bestofmedia.com:143:INBOX:login:echastan@bestofmedia.com:*" default-crashbox)))))

  (setq vm-imap-messages-per-session 1000)
  (setq vm-mutable-windows t
	vm-mutable-frames nil
	vm-auto-get-new-mail t)
  )
(provide 'vm-config)
