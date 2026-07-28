# Owen's Dotfiles

Welcome! This is my personal `.dotfiles` repository where I keep all my dotfiles and configuration.
Feel free to browse around, take inspiration, or use anything you find helpful.

## Structure

Configs are organized into [GNU Stow](https://www.gnu.org/software/stow/) packages, grouped by
platform and by role:

```
dev             - shell and dev tooling shared across every machine
dev-macos       - macOS-specific dev tooling
desktop-macos   - macOS desktop/WM configuration
dev-linux       - Linux-specific dev tooling
desktop-linux   - Linux desktop/WM configuration
```

(`macos/.setup.sh` is a one-off macOS provisioning script, not a stow package.)

## Theming

Everything shares one custom color scheme: **[Modus Soft](dev/.config/theming/MODUS-SOFT.md)**,
a variant of the [Modus themes](https://protesilaos.com/emacs/modus-themes) with
the backgrounds lifted one tick off pure black/white. The central role-based
color system lives in [`dev/.config/theming`](dev/.config/theming).

Each package mirrors the layout of `$HOME`, so stowing a package symlinks its contents straight
into place. A few configs worth calling out:

- [`nvim`](dev/.config/nvim) - my primary text editor config
- [`ghostty`](dev/.config/ghostty) - my terminal emulator config
- [`tmux`](dev/.config/tmux) - my terminal multiplexer config
- [`aerospace`](desktop-macos/.config/aerospace) - my tiling window manager config (macOS only)
- [`Installers`](dev-macos/Installers) - macOS install scripts, stowed to `~/Installers`

## Getting Started

This repo is meant to be cloned and stowed, not copy-pasted. Install [GNU Stow](https://www.gnu.org/software/stow/)
(`brew install stow` or your distro's package manager), clone this repo, then symlink the
packages relevant to your machine from the repo root:

```sh
git clone https://github.com/odonckers/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# on macOS
stow -t ~ dev dev-macos desktop-macos

# on Linux
stow -t ~ dev dev-linux desktop-linux
```

Stow only creates symlinks, so nothing is copied and nothing is overwritten silently -
if a target file already exists, stow will refuse and tell you. Adopt or remove the
conflicting file, then re-run.

Once `dev` is stowed, a `syncdots` shell function is available from any directory. It always
targets `~/.dotfiles` and re-runs the correct `stow` command for the current OS, so future
pulls can be re-synced with a single command:

```sh
syncdots
```

**Note:**
These are my personal configurations, so they're tailored to my workflow.
I recommend reviewing and understanding what each config does before applying it to your system,
and stowing only the packages that make sense for your platform.

## Philosophy

I believe in keeping configurations clean, well-commented, and modular.
If something here helps you improve your own setup, that makes me happy!
Don't hesitate to modify anything to fit your needs.

## Contributing

While this is a personal configuration repository, I'm always open to suggestions!
If you spot a bug, have an optimization idea, or want to share a cool trick,
feel free to open an issue or submit a pull request.

## License

These configurations are shared freely. Use them however you'd like!

---

Happy configuring! 🎉
