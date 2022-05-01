;;; init.el --- Initialization file for EMACS
;;; Commentary: Emacs Startup File --- initialization for EMACS

;;; Code:

(package-initialize)

(blink-cursor-mode 0)
(column-number-mode 1)
(electric-indent-mode 1)
(electric-pair-mode 1)
(scroll-bar-mode 0)
(show-paren-mode 1)
(tool-bar-mode 0)
(global-auto-revert-mode 1)

(add-hook 'prog-mode-hook (lambda () (linum-mode 1) (flymake-mode 1)))
(add-hook 'text-mode-hook
	  (lambda ()
	    (auto-fill-mode 1)
	    (flyspell-mode 1)))
(add-hook 'org-mode-hook
	  (lambda ()
	    (local-unset-key (kbd "C-c ["))
	    (local-unset-key (kbd "C-c ]"))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-width 80)
 '(avy-style 'words)
 '(c-basic-offset 4)
 '(c-offsets-alist '((innamespace . 0)))
 '(confirm-kill-emacs 'yes-or-no-p)
 '(eldoc-echo-area-use-multiline-p nil)
 '(highlight-indent-guides-method 'character)
 '(ido-enable-flex-matching t)
 '(inhibit-startup-screen t)
 '(load-prefer-newer t)
 '(org-agenda-files nil)
 '(org-hide-leading-stars t)
 '(org-latex-classes
   '(("beamer" "\\documentclass[presentation]{beamer}"
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
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")))
 '(package-selected-packages
   '(tuareg company-lean lean-mode org-ref lua-mode haskell-mode highlight-indent-guides paredit crux company-prescient selectrum-prescient selectrum diff-hl undo-tree easy-kill which-key projectile company cargo rust-mode eglot clang-format toml-mode multiple-cursors ace-window avy markdown-mode magit expand-region rainbow-delimiters auctex use-package solarized-theme))
 '(python-shell-interpreter "ipython3")
 '(python-shell-interpreter-args "--simple-prompt -i")
 '(search-whitespace-regexp "[ 	
]+")
 '(solarized-scale-org-headlines nil)
 '(solarized-scale-outline-headlines nil)
 '(solarized-use-variable-pitch nil)
 '(sp-base-key-bindings 'paredit)
 '(view-read-only t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package ace-window :bind ("M-o" . ace-window))

(use-package avy
  :bind*
  ("C-'" . avy-goto-char-timer)
  ("C-:" . avy-goto-char)
  ("M-g g" . avy-goto-line)
  ("M-g e" . avy-goto-word-0)
  ("M-g w" . avy-goto-word-1)
  ("M-g SPC". avy-goto-whitespace-end))

(use-package cargo :hook ((toml-mode rust-mode) . cargo-minor-mode))

(use-package cc-mode)

(use-package clang-format
  :commands clang-format-buffer clang-format-region
  :bind (:map c-mode-base-map ("C-c C-f" . clang-format-buffer)))

(use-package company
  :config (global-company-mode t))

(use-package company-lean)

(use-package crux :bind ([remap open-line] . crux-smart-open-line-above))

(use-package diff-hl :config (global-diff-hl-mode))

(use-package easy-kill
  :ensure t
  :bind ([remap kill-ring-save] . easy-kill)
  ([remap mark-sexp] . easy-mark))

(use-package eglot
  :config (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
  ;; (add-to-list 'eglot-server-programs '(rust-mode eglot-rls "rust-analyzer"))
  :hook ((rust-mode c-mode c++-mode python-mode) . eglot-ensure))

(use-package expand-region
  :bind (("C-=" . er/expand-region)))

(use-package haskell-mode :defer t)

(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode))

(use-package lean-mode)

(use-package lua-mode)

(use-package magit
  :bind ("C-x M-g" . magit-dispatch)
  ("C-x g" . magit-status))

(use-package markdown-mode :defer t)

(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
	 ("C-<" . mc/mark-previous-like-this)
	 ("C-+" . mc/mark-more-like-this-extended)
	 ("C-S-c C-S-c" . mc/edit-lines)))

(use-package paredit
  :hook ((lisp-mode emacs-lisp-mode ielm-mode) . paredit-mode))

(use-package prescient :config (selectrum-prescient-mode t) (company-prescient-mode t))

(use-package projectile
  :config (projectile-global-mode 1)
  :bind-keymap ("C-c p" . projectile-command-map))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package reftex :hook (TeX-mode . reftex-mode))

(use-package rust-mode :defer t)

(use-package selectrum :config (selectrum-mode t))

(use-package solarized-theme
  :config (load-theme 'solarized-light t))

(use-package tex :defer t)

(use-package toml-mode)

(use-package tuareg :defer t)

(use-package undo-tree :config (global-undo-tree-mode))

(use-package which-key :config (which-key-mode))

(defun kill-region-or-backward-kill-word (beg end)
  "Kill region or delete previous word.

If variable `transient-mark-mode' is activated, kill the region; otherwise
kill backward until encountering the beginning of a word."
  (interactive (list (point) (mark)))
  (cond ((and transient-mark-mode mark-active) (kill-region beg end))
	(t (backward-kill-word 1))))

(defun back-to-indentation-then-beginning-of-line ()
  "Move to the first non-whitespace character, then to column 0."
  (interactive)
  (if (eq last-command this-command)
      (move-beginning-of-line nil)
    (back-to-indentation)))

(defun recompile-all-packages ()
  "Force the compilation of all user packages."
  (byte-recompile-directory package-user-dir nil 'force))

(global-set-key (kbd "C-a") 'back-to-indentation-then-beginning-of-line)
(global-set-key (kbd "M-m") 'move-beginning-of-line)
(global-set-key (kbd "C-w") 'kill-region-or-backward-kill-word)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-x C-b") 'ibuffer)
 ;; M-SPC requires disabling this shortcut in the window manager
(global-set-key (kbd "M-SPC") 'cycle-spacing)
(global-set-key (kbd "M-u") 'upcase-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)
(global-set-key (kbd "M-c") 'capitalize-dwim)
(global-set-key (kbd "M-z") 'zap-up-to-char)

(unless noninteractive
  (server-start))

(setq isearch-regexp-lax-whitespace t)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
