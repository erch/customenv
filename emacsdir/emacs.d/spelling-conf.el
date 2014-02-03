(when (executable-find "aspell")
  (setq-default ispell-program-name "aspell")
  (autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)

  (setq flyspell-issue-welcome-flag nil)
  (setq flyspell-issue-message-flag nil)

  (let ((langs '("american" "francais")))
    (setq lang-ring (make-ring (length langs)))
    (dolist (elem langs) (ring-insert lang-ring elem)))

  (defun cycle-ispell-languages ()
    (interactive)
    (let ((lang (ring-ref lang-ring -1)))
      (ring-insert lang-ring lang)
      (ispell-change-dictionary lang)))

  (global-set-key [f6] 'cycle-ispell-languages)
)
(provide 'spelling-conf)
