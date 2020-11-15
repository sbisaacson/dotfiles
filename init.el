;;; init.el --- Initialization file for EMACS
;;; Commentary: Emacs Startup File --- initialization for EMACS

;;; Code:

(package-initialize)

(tool-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0)
(ido-mode 1)
(electric-indent-mode 1)
(show-paren-mode 1)

(add-hook 'prog-mode-hook (lambda () (linum-mode 1) (flymake-mode 1)))
(add-hook 'text-mode-hook
	  (lambda ()
	    (auto-fill-mode 1)
	    (flyspell-mode 1)))

(defun kill-region-or-backward-kill-word (beg end)
  "Kill region or delete previous word.

If variable `transient-mark-mode' is activated, kill the region; otherwise
kill backward until encountering the beginning of a word."
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

(defun recompile-all-packages ()
  (byte-recompile-directory package-user-dir nil 'force))

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
     ("melpa" . "https://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (eldoc-box company cargo rust-mode eglot clang-format toml-mode multiple-cursors ace-window avy markdown-mode magit expand-region rainbow-delimiters auctex paredit use-package solarized-theme)))
 '(solarized-scale-org-headlines nil)
 '(solarized-scale-outline-headlines nil)
 '(solarized-use-variable-pitch nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package company
  :config (global-company-mode t))

(use-package eglot :defer t
  :config (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
  ;; (add-to-list 'eglot-server-programs '(rust-mode eglot-rls "rust-analyzer"))
  :hook ((rust-mode c-mode c++-mode python-mode) . eglot-ensure))

;; Should this be eldoc-mode?
(use-package eldoc-box :hook (eglot-managed-mode . eldoc-box-hover-mode))

(use-package solarized-theme
  :config (load-theme 'solarized-light t))

(use-package tex :defer t)

(use-package paredit
  :hook ((lisp-mode emacs-lisp-mode) . paredit-mode)
  :defer t)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package clang-format
  :defer t
  :commands clang-format-buffer clang-format-region)

(use-package cc-mode
  :bind (:map c-mode-base-map ("C-c C-f" . clang-format-buffer)))

(use-package expand-region
  :bind (("C-=" . er/expand-region)))

(use-package magit :defer t)

(use-package markdown-mode :defer t)

(use-package avy :bind ("C-'" . avy-goto-char-2))

(use-package ace-window :bind ("M-o" . ace-window))

(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
	 ("C-<" . mc/mark-previous-like-this)
	 ("C-+" . mc/mark-more-like-this-extended)
	 ("C-S-c C-S-c" . mc/edit-lines)))

(use-package toml-mode)

(use-package rust-mode :defer t)

(use-package cargo :defer t :hook ((toml-mode rust-mode) . cargo-minor-mode))

(unless noninteractive
  (server-start))

;;; init.el ends here
