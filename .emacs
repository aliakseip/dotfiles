(setq custom-file "~/.emacs.custom.el")
(load-theme 'gruber-darker t)
;; (add-to-list 'default-frame-alist '(background-color . "honeydew"))

(global-display-line-numbers-mode 1)
(add-hook 'dired-mode-hook (lambda () (display-line-numbers-mode -1)))
(ido-mode 1)
(ido-everywhere 1)
(column-number-mode 1)
(show-paren-mode 1)
(setq inhibit-startup-message t)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(setq-default inhibit-splash-screen t
              make-backup-files nil
              tab-width 4
              indent-tabs-mode nil
              compilation-scroll-output t
              visible-bell (equal system-type 'windows-nt))
(require 'whitespace)
(setq whitespace-style (delq 'lines-tail whitespace-style))
(setq whitespace-style (delq 'lines whitespace-style))
(add-hook 'python-mode-hook 'whitespace-mode)
(add-hook 'emacs-lisp-mode-hook 'whitespace-mode)
(add-hook 'go-mode-hook 'whitespace-mode)
(add-hook 'simpc-mode-hook 'whitespace-mode)
(setq-default truncate-lines t)
(setq make-backup-files nil)
(setq auto-save-default nil)

;; (add-to-list 'load-path "/Users/apashkouski/personal/simpc-mode/")
(load "~/.emacs.rc/simpc-mode/simpc-mode.el")
(require 'simpc-mode)

(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
(load-file custom-file)
