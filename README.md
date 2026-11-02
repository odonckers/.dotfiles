# Owen's Dotfiles

My shared shell, development, and desktop setup for macOS and Linux. The main
way into the repository is `dots`, a small command for keeping the installed
dotfiles linked.

## Start with `dots`

Run this after pulling changes or adding a config:

```sh
dots sync
```

It selects the packages for the current operating system and refreshes the
links into your home directory. Reload the shell if the command asks you to.

Preview the restow and report conflicts without changing anything:

```sh
dots check
```

## Appearance

There is no shared theme layer. Ghostty, tmux, Neovim, and the other tools use
their own default colors and follow the system light/dark setting where they
support it. Fonts are set directly in each terminal's config.

## Repository tour

The repository is arranged as GNU Stow packages. Each package mirrors the paths
it owns beneath the home directory.

| Package | What you will find |
| --- | --- |
| [`dev`](dev) | Shared shell setup, `dots`, editors, terminals, tmux, and command-line tools |
| [`dev-macos`](dev-macos) | macOS development settings, Homebrew, and installers |
| [`desktop-macos`](desktop-macos) | Karabiner and other macOS desktop behavior |
| [`dev-linux`](dev-linux) | Linux-specific shell and terminal settings |
| [`desktop-linux`](desktop-linux) | Sway, Waybar, Wofi, and the Linux desktop environment |

A few useful stops on the tour:

- [`dev/.local/bin/dots`](dev/.local/bin/dots) is the command used to manage the setup.
- [`dev/.config`](dev/.config) contains the shared application configurations.
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
