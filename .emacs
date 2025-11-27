(setq custom-file "~/.emacs.custom.el")
(load-theme 'gruber-darker t)
;; (add-to-list 'default-frame-alist '(background-color . "honeydew"))

(defun display-line-numbers()
  (interactive)
  (global-display-line-numbers-mode 1)
  (column-number-mode 1)
  (add-hook 'dired-mode-hook (lambda () (display-line-numbers-mode -1))))
(display-line-numbers)

(ido-mode 1)
(ido-everywhere 1)
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

(defun set-up-whitespace-handling()
  (require 'whitespace)
  (setq whitespace-style (delq 'lines-tail whitespace-style))
  (setq whitespace-style (delq 'lines whitespace-style)))
(add-hook 'python-mode-hook 'set-up-whitespace-handling)
(add-hook 'emacs-lisp-mode-hook 'set-up-whitespace-handling)
(add-hook 'go-mode-hook 'set-up-whitespace-handling)
(add-hook 'simpc-mode-hook 'set-up-whitespace-handling)

(setq-default truncate-lines t)
(setq make-backup-files nil)
(setq auto-save-default nil)

(load "~/.emacs.rc/simpc-mode.el")
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

(load-file custom-file)
