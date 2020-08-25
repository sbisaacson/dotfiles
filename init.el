(defun kill-region-or-backward-kill-word (beg end)
  "Kill region if transient mark is activated; otherwise kill
backward until encountering the beginning of a word."
  (interactive (list (point) (mark)))
  (if (and transient-mark-mode mark-active)
      (kill-region beg end)
    (backward-kill-word 1)))

(defun back-to-indentation-then-beginning-of-line ()
  "Move point to indentation, then to beginning of line if
repeated."
  (interactive)
  (if (eq last-command this-command)
      (move-beginning-of-line nil)
    (back-to-indentation)))

(global-set-key (kbd "C-a") 'back-to-indentation-then-beginning-of-line)
(global-set-key (kbd "M-m") 'move-beginning-of-line)
(global-set-key (kbd "C-w") 'kill-region-or-backward-kill-word)
