(package-initialize)

(tool-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0)
(ido-mode 1)
(electric-indent-mode 1)

(add-hook 'prog-mode-hook (lambda () (linum-mode 1)))
(add-hook 'text-mode-hook
	  (lambda ()
	    (auto-fill-mode 1)
	    (flyspell-mode 1)))

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
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-width 80)
 '(c-basic-offset 4)
 '(ido-enable-flex-matching t)
 '(inhibit-startup-screen t)
 '(org-hide-leading-stars t)
 '(org-latex-classes
   (quote
    (("beamer" "\\documentclass[presentation]{beamer}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("article" "\\documentclass[11pt]{article}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
     ("report" "\\documentclass[11pt]{report}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("book" "\\documentclass[11pt]{book}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("amsart" "\\documentclass{amsart}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))))
 '(package-archives
   (quote
    (("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa-stable" . "https://stable.melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (markdown-mode magit expand-region rust-mode rainbow-delimiters auctex paredit use-package solarized-theme)))
 '(solarized-scale-org-headlines nil)
 '(solarized-scale-outline-headlines nil)
 '(solarized-use-variable-pitch nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package solarized-theme
  :config (load-theme 'solarized-light t))

(use-package tex :defer t)

(use-package paredit
  :hook ((lisp-mode emacs-lisp-mode) . paredit-mode)
  :defer t)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package rust-mode :defer t)

(use-package clang-format
  :defer t
  :commands clang-format-buffer clang-format-region)

(use-package cc-mode
  :bind (:map c-mode-base-map ("C-c C-f" . clang-format-buffer)))

(use-package expand-region
  :bind (("C-=" . er/expand-region)))

(use-package magit :defer t)

(use-package markdown-mode :defer t)

(unless noninteractive
  (server-start))
