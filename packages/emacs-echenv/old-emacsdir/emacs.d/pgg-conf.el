(require 'epa-file)
(epa-file-enable)
 (when (or (string= system-type "ms-dos") (string= system-type "windows-nt"))
   (setq epg-gpg-program "c:/cygwin/bin/gpg.exe"))
;(require 'pgg)
 (setq epa-file-cache-passphrase-for-symmetric-encryption t)
; default mode to gpg
;(setq pgg-default-scheme 'gpg)
 
; forgot passphrase after 600 seconds
;(setq pgg-passphrase-cache-expiry 600)
 
; gpg default ID to use
;(setq pgg-default-user-id "Eric Chastan <eric@chastan-jeannin.fr>")
(setq epg-user-id "Eric Chastan <eric@chastan-jeannin.fr>")
(provide 'pgg-conf)
