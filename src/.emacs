(define-prefix-command 'llin-command-map)
(define-key llin-command-map (kbd "SPC") 'execute-extended-command)
(define-key llin-command-map (kbd "TAB") 'evil-buffer)
(define-key llin-command-map (kbd "f  ") '("file"))
(define-key llin-command-map (kbd "f b") 'switch-to-buffer)
(define-key llin-command-map (kbd "f f") 'find-file)
(define-key llin-command-map (kbd "f i") 'imenu)
(define-key llin-command-map (kbd "f j") 'dired-jump)
(define-key llin-command-map (kbd "g  ") '("git"))
(define-key llin-command-map (kbd "g b") 'magit-blame-addition)
(define-key llin-command-map (kbd "g d") 'magit-diff-buffer-file)
(define-key llin-command-map (kbd "g l") 'magit-log-buffer-file)
(define-key llin-command-map (kbd "g s") 'magit-status)
(define-key llin-command-map (kbd "p  ") '("project"))
(define-key llin-command-map (kbd "p a") 'projectile-find-other-file)
(define-key llin-command-map (kbd "p b") 'projectile-switch-to-buffer)
(define-key llin-command-map (kbd "p c") 'projectile-compile-project)
(define-key llin-command-map (kbd "p f") 'projectile-find-file)
(define-key llin-command-map (kbd "p p") 'projectile-switch-project)
(define-key llin-command-map (kbd "r  ") 'ivy-resume)
(define-key llin-command-map (kbd "s  ") 'counsel-ag)
(define-key llin-command-map (kbd "t  ") '("toggle"))
(define-key llin-command-map (kbd "t n") 'display-line-numbers-mode)
(define-key llin-command-map (kbd "t t") 'treemacs)
(define-key llin-command-map (kbd "t w") 'toggle-truncate-lines)
(define-key llin-command-map (kbd "u  ") 'universal-argument)

(setq gc-cons-threshold-orig gc-cons-threshold)
(setq gc-cons-threshold (* 20 1024 1024))
(defun llin-emacs-started ()
  (message "Emacs ready in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time (time-subtract after-init-time before-init-time)))
           gcs-done)
  ;; Restore the original GC threshold.
  (setq gc-cons-threshold gc-cons-threshold-orig))
(add-hook 'emacs-startup-hook #'llin-emacs-started)

;; Simplify the UI.
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(setq ring-bell-function #'ignore)
(menu-bar-mode -1)
(when (display-graphic-p)
  (scroll-bar-mode -1)
  (tool-bar-mode -1))

;; Don't create files automatically.
(setq create-lockfiles nil)  ; .#lock
(setq auto-save-default nil) ; #save#
(setq make-backup-files nil) ; backup~

;; Keep point at the same screen position.
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Scrolling.html
(setq scroll-conservatively 101)
(setq scroll-preserve-screen-position t)

;; Display column number in the mode line.
(column-number-mode +1)

;; Delete useless whitespace.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun llin-adjust-prog-mode ()
  (display-line-numbers-mode +1)
  (electric-pair-local-mode +1))
(add-hook 'prog-mode-hook #'llin-adjust-prog-mode)

(defun llin-adjust-emacs-lisp-mode ()
  (setq indent-tabs-mode nil)
  (modify-syntax-entry ?- "w"))
(add-hook 'emacs-lisp-mode-hook #'llin-adjust-emacs-lisp-mode)

(defun llin-adjust-c++-mode ()
  (c-set-style "linux")
  (c-set-offset 'inher-intro 0)
  (c-set-offset 'inline-open 0)
  (c-set-offset 'innamespace 0)
  (c-set-offset 'member-init-intro 0)
  (modify-syntax-entry ?_ "w"))
(add-hook 'c++-mode-hook #'llin-adjust-c++-mode)

(defun llin-adjust-java-mode ()
  (setq indent-tabs-mode nil))
(add-hook 'java-mode-hook #'llin-adjust-java-mode)

(defun llin-get-current-line ()
  (interactive)
  (let* ((file (file-name-nondirectory buffer-file-name))
         (line (number-to-string (line-number-at-pos))))
    (message (kill-new (concat file ":" line)))))

;; Load customization, e.g. font setting.
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'no-error)

;; Add the melpa archive.
(when (< emacs-major-version 27)
  (package-initialize))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; Install use-package.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)
(setq use-package-compute-statistics t)

(use-package base16-theme
  :init
  ;; This option is only relevant when emacs runs in terminal.
  ;; color-16..color-21 should be set up properly by `base16-shell'.
  ;; https://github.com/chriskempson/base16-shell
  (setq base16-theme-256-color-source "base16-shell")
  :config
  (load-theme 'base16-ocean t))

;; The mode line was cluttered with minor modes.
(use-package minions
  :config
  (minions-mode))

;; Important variabls:
;; - `evil-mode-map-alist': figure out keymap priority.
(use-package evil
  :init
  (setq evil-disable-insert-state-bindings t)
  (setq evil-search-module 'evil-search)
  (setq evil-want-C-i-jump nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-want-keybinding nil)
  :config
  (evil-define-key 'motion 'global (kbd "SPC") 'llin-command-map)
  (evil-define-key 'normal 'global (kbd "M-.") nil)
  (evil-ex-define-cmd "ls" 'ibuffer)
  (evil-mode))

(use-package ivy
  :defer 0.1
  :init
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-use-virtual-buffers t)
  :config
  (ivy-mode))

(use-package evil-collection
  :after evil
  :init
  (setq evil-collection-key-blacklist '("SPC"))
  :config
  (evil-collection-init))

(use-package counsel
  :after ivy
  :init
  (global-set-key (kbd "C-s") 'swiper-isearch-thing-at-point)
  :config
  (counsel-mode))

(use-package ivy-hydra
  :defer t)

(use-package projectile
  :defer t
  :init
  (setq projectile-completion-system 'ivy)
  (setq projectile-switch-project-action 'projectile-dired)
  :config
  (projectile-mode))

(use-package magit
  :defer t)

(use-package evil-magit
  :after (evil magit))

(use-package treemacs
  :defer t
  :init
  (setq treemacs-no-png-images t))

(use-package treemacs-evil
  :after (evil treemacs))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :config
  (add-to-list 'exec-path-from-shell-variables "LANG")
  (exec-path-from-shell-initialize))

(use-package company
  :defer t
  :init
  (setq company-backends '(company-capf company-files (company-dabbrev-code company-keywords) company-dabbrev))
  (add-hook 'prog-mode-hook #'company-mode))

(use-package lsp-mode
  :defer t
  :init
  (setq lsp-clients-clangd-args '("-j=4" "-background-index"))
  (setq lsp-enable-snippet nil)
  (add-hook 'go-mode-hook #'lsp)
  (add-hook 'c++-mode-hook #'lsp)
  (add-hook 'java-mode-hook #'lsp))

(use-package lsp-java
  :defer t)

(use-package parinfer
  :defer t
  :init
  (setq parinfer-extensions '(defaults evil)))

(use-package go-mode
  :defer t)

(use-package rust-mode
  :defer t)

(use-package clojure-mode
  :defer t)

(use-package markdown-mode
  :defer t)
