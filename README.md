# Owen's Dotfiles

My shared shell, development, and desktop setup for macOS and Linux. The main
way into the repository is `dots`, a small command for keeping the installed
dotfiles and their appearance in sync.

## Start with `dots`

Run this after pulling changes or editing a config:

```sh
dots sync
```

It selects the packages for the current operating system, refreshes the links
into your home directory, renders the shared appearance settings, and updates a
running tmux session. Reload the shell if the command asks you to.

Validate the configuration and rendered appearance without restowing:

```sh
dots check
```

For the complete command menu:

```sh
dots help
```

## Appearance

Theme, light or dark mode, shared colors, and application preferences live
together in [`dev/.config/dotfiles/config.json`](dev/.config/dotfiles/config.json).
Ghostty, Kitty, Neovim, Emacs, tmux, Yazi, shell tools, and several desktop apps
read from that shared appearance.

See what is active:

```sh
dots appearance
```

The everyday appearance commands are:

```sh
dots appearance themes
dots appearance set <theme>
dots appearance mode system
dots appearance mode dark
dots appearance mode light
```

Use `system` to follow the operating system where supported. After editing the
JSON directly, apply it without restowing everything:

```sh
dots appearance apply
```

For a quick inspection, read any value beneath the `appearance` key:

```sh
dots appearance get applications.nvim.transparent
dots appearance effective-mode
```

## Repository tour

The repository is arranged as GNU Stow packages. Each package mirrors the paths
it owns beneath the home directory.

| Package | What you will find |
| --- | --- |
| [`dev`](dev) | Shared shell setup, `dots`, editors, terminals, tmux, and command-line tools |
| [`dev-macos`](dev-macos) | macOS development settings, launch agents, and installers |
| [`desktop-macos`](desktop-macos) | AeroSpace, Karabiner, borders, and other macOS desktop behavior |
| [`dev-linux`](dev-linux) | Linux-specific shell and terminal settings |
| [`desktop-linux`](desktop-linux) | Sway, Waybar, Wofi, and the Linux desktop environment |

A few useful stops on the tour:

- [`dev/.local/bin/dots`](dev/.local/bin/dots) is the command used to manage the setup.
- [`dev/.config`](dev/.config) contains the shared application configurations.
- [`desktop-macos/.config/aerospace`](desktop-macos/.config/aerospace) contains the macOS window-management setup.
- [`desktop-linux/.config`](desktop-linux/.config) contains the Linux desktop setup.
- [`dev-macos/Installers`](dev-macos/Installers) contains optional macOS setup scripts.

## First install

Install [GNU Stow](https://www.gnu.org/software/stow/), clone the repository,
then link the packages for the machine once:

```sh
git clone https://github.com/odonckers/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# macOS
stow -t ~ dev dev-macos desktop-macos

# Linux
stow -t ~ dev dev-linux desktop-linux
```

After that first install, use `dots sync` instead of choosing the packages by
hand. These are personal configurations, so review the parts you plan to use
and adapt them to your machine.
