;; Disable startup message
(setq inhibit-startup-message t)

;; Disable UI chrome
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 10)

;; Built-in dark theme
(load-theme 'modus-vivendi t)

;; Enable line numbers
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type t)

;; Set font
(set-face-attribute 'default nil
                    :family "JetBrainsMono Nerd Font"
                    :height 120
                    :weight 'regular)
(set-face-attribute 'fixed-pitch nil
                    :family "JetBrainsMono Nerd Font")

;; Initialize package sources
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil vterm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package vterm
  :ensure t)
