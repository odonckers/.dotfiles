#!/usr/bin/env zsh

brew-backup() {
  brew bundle dump --global --force
}

brew-restore() {
  brew bundle install --global
}

brew-update() {
  brew update
  brew bundle upgrade --global
}
