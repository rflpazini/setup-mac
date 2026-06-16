# setup-mac

My macOS bootstrap — a clean **Python + Go** development environment for a fresh machine.

One command on a clean Mac gets me to a working environment: Homebrew, a curated
set of CLI tools and apps, my shell config, and sane macOS defaults.

## Quick start

```bash
git clone https://github.com/rflpazini/setup-mac.git
cd setup-mac
./bootstrap.sh
exec zsh
```

`bootstrap.sh` is idempotent — re-run it any time. It backs up existing dotfiles
to `~/.dotfiles-backup/<timestamp>/` before linking.

## What it does

`bootstrap.sh` runs these steps in order:

1. **Xcode Command Line Tools** — installs if missing.
2. **Homebrew** — installs if missing (arch-aware: `/opt/homebrew` on Apple
   Silicon, `/usr/local` on Intel).
3. **Packages** — `brew bundle` from [`Brewfile`](Brewfile).
4. **oh-my-zsh** — installs without touching the zshrc this repo manages.
5. **Secrets file** — creates `~/.config/shell/secrets.zsh` from the template.
6. **Dotfiles** — symlinks them into `$HOME` with GNU `stow`.
7. **macOS defaults** — applies [`macos/defaults.sh`](macos/defaults.sh).

## Layout

```
setup-mac/
├── bootstrap.sh          # entry point
├── Brewfile              # curated formulae + casks
├── macos/defaults.sh     # system preferences
├── files/wallpaper/      # desktop wallpaper
└── dotfiles/             # GNU stow packages
    ├── git/.gitconfig
    ├── zsh/.zshrc
    └── shell/.config/shell/
        ├── env.zsh             # non-secret env vars
        ├── functions.zsh       # shell functions
        ├── aliases.zsh         # aliases
        └── secrets.zsh.example # template for the gitignored secrets file
```

### Dotfiles (stow)

Each directory under `dotfiles/` is a [stow](https://www.gnu.org/software/stow/)
package; its contents mirror `$HOME`. `stow git` links `dotfiles/git/.gitconfig`
to `~/.gitconfig`, and so on.

Re-link after editing:

```bash
stow --dir=dotfiles --target="$HOME" --restow git zsh shell
```

### Secrets

Secrets **never** live in tracked files. `~/.config/shell/secrets.zsh` is
gitignored and sourced by `.zshrc` if present. Copy the template and fill it in:

```bash
cp ~/.config/shell/secrets.zsh.example ~/.config/shell/secrets.zsh
```

### Packages

[`Brewfile`](Brewfile) is a deliberately lean, curated list — not a full machine
snapshot. Edit it, then:

```bash
brew bundle                       # install everything in the Brewfile
brew bundle cleanup               # show what's installed but not in the Brewfile
```

## Customising

- **Add a tool/app** — add a `brew "..."` / `cask "..."` line to `Brewfile`.
- **Add an alias/function** — edit the files under `dotfiles/shell/.config/shell/`.
- **Change macOS behaviour** — edit `macos/defaults.sh` (some changes need a logout).
- **Work git identity** — uncomment the `includeIf` block in `dotfiles/git/.gitconfig`.

---

> "Why program by hand in five days what you can spend five years of your life automating?"
> — Dr Terence Parr
