#!/usr/bin/env bash

echo "💻 Setting up macOS..."
echo "⚠️ This will require a reboot after completion."
echo ""

# ---- Configure Keyboard ------------

# Repeat character while key held (https://macos-defaults.com/keyboard/applepressandholdenabled.html#set-to-false)
defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool "false"

# Set key repeat speed (https://apple.stackexchange.com/questions/10467/how-to-increase-keyboard-key-repeat-rate-on-os-x)
defaults write -g InitialKeyRepeat -float 13.0 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -float 1.8         # normal minimum is 2 (30 ms)

# Set fn key usage to emoji & symbols (https://macos-defaults.com/keyboard/applefnusagetype.html)
defaults write com.apple.HIToolbox AppleFnUsageType -int "2"

# Enable window dragging via ctrl + cmd (https://www.geekbitzone.com/posts/2022/macos/hacks/ui-window-shortcuts/click-drag-windows-anywhere/)
defaults write -g NSWindowShouldDragOnGesture -bool true

# ---- Configure Mouse ---------------

echo "🐭 Configuring mouse..."

# Set mouse speed (https://macos-defaults.com/mouse/scaling.html)
defaults write NSGlobalDomain com.apple.mouse.scaling -float "1"

# ---- Configure Windows -------------

defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

# ---- Configure Dock ----------------

echo "☑️ Configuring dock..."

# Set tilesize (https://macos-defaults.com/dock/tilesize.html)
defaults write com.apple.dock "tilesize" -int "48"

# Set magnified size (no ref)
defaults write com.apple.dock "largesize" -int "48"

# Enable magnification (no ref)
defaults write com.apple.dock magnification -bool false

# Set minimize effect (https://macos-defaults.com/dock/mineffect.html)
defaults write com.apple.dock "mineffect" -string "scale"

# Speed up autohide animation time (https://macos-defaults.com/dock/autohide-time-modifier.html)
defaults write com.apple.dock "autohide-time-modifier" -float "0.5"

# Disable autohide delay (https://macos-defaults.com/dock/autohide-delay.html)
defaults write com.apple.dock "autohide-delay" -float "0"

# Group expose windows by app (https://nikitabobko.github.io/AeroSpace/guide#a-note-on-mission-control)
defaults write com.apple.dock expose-group-apps -bool true

killall Dock
