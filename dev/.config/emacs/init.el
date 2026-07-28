;; Disable startup message
(setq inhibit-startup-message t)

;; Disable UI chrome
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 10)

;; Modus Soft: lift the pure black/white backgrounds one 5% tick (13/255 = 0x0D)
;; off the extremes; adjacent background greys move by the same amount to keep
;; the ramp spaced. Backgrounds only -- text and accents untouched. Must be set
;; before load-theme. See dev/.config/theming/MODUS-SOFT.md for the derivation.
(setq modus-vivendi-palette-overrides
      '((bg-main "#0d0d0d")
        (bg-dim "#2b2b2b")
        (bg-active "#3d3d3d")
        (bg-inactive "#353535")))
(setq modus-operandi-palette-overrides
      '((bg-main "#f2f2f2")
        (bg-dim "#e5e5e5")
        (bg-active "#d3d3d3")
        (bg-inactive "#dcdcdc")))

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
