;; Disable startup message
(setq inhibit-startup-message t)

;; Disable UI chrome
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 10)

;; Shared appearance from ~/.config/dotfiles/config.json.
(require 'json)

(defun dots-appearance--mode (appearance)
  "Return the effective dark/light mode for APPEARANCE."
  (let ((configured (gethash "mode" appearance)))
    (cond
     ((member configured '("dark" "light")) configured)
     ((and (string= configured "system")
           (eq system-type 'darwin))
      (if (zerop (call-process "defaults" nil nil nil
                               "read" "-g" "AppleInterfaceStyle"))
          "dark"
        "light"))
     ((string= configured "system")
      (gethash "fallbackMode" appearance))
     (t (error "Unknown dots appearance mode: %s" configured)))))

(let* ((config-home (or (getenv "XDG_CONFIG_HOME")
                        (expand-file-name ".config" "~")))
       (config-file (expand-file-name "dotfiles/config.json" config-home))
       (config (json-parse-file config-file
                                :object-type 'hash-table
                                :array-type 'list
                                :null-object nil
                                :false-object nil))
       (appearance (gethash "appearance" config))
       (theme-name (gethash "theme" appearance))
       (theme (gethash theme-name (gethash "themes" appearance)))
       (mode (dots-appearance--mode appearance))
       (target (gethash "emacs" (gethash "targets" theme)))
       (theme-symbol (intern (gethash mode target))))
  (when (gethash "soft" target)
    (let* ((overrides (gethash mode (gethash "overrides" theme)))
           (palette `((bg-main ,(gethash "bgMain" overrides))
                      (bg-dim ,(gethash "bgDim" overrides))
                      (bg-active ,(gethash "bgActive" overrides))
                      (bg-inactive ,(gethash "bgInactive" overrides)))))
      (if (string= mode "dark")
          (setq modus-vivendi-palette-overrides palette)
        (setq modus-operandi-palette-overrides palette))))
  (load-theme theme-symbol t))

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
