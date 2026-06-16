#!/usr/bin/env bash
# bootstrap.sh — set up a fresh macOS machine from this repo.
#
#   git clone https://github.com/rflpazini/setup-mac.git && cd setup-mac && ./bootstrap.sh
#
# Idempotent: safe to re-run. Existing real dotfiles are backed up before linking.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$REPO_DIR/dotfiles"
STOW_PACKAGES=(git zsh shell)

log() { printf "\n\033[1;36m==>\033[0m %s\n" "$1"; }

# ── 1. Xcode Command Line Tools ──────────────────────────────────────────────
if ! xcode-select -p >/dev/null 2>&1; then
	log "Installing Xcode Command Line Tools"
	xcode-select --install
	read -rp "Press Enter once Xcode CLT has finished installing..."
fi

# ── 2. Homebrew (arch-aware) ─────────────────────────────────────────────────
if ! command -v brew >/dev/null 2>&1; then
	log "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if [[ -x /opt/homebrew/bin/brew ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
	eval "$(/usr/local/bin/brew shellenv)"
fi

# ── 3. Packages ──────────────────────────────────────────────────────────────
log "Installing packages from Brewfile"
brew bundle --file="$REPO_DIR/Brewfile"

# ── 4. oh-my-zsh ─────────────────────────────────────────────────────────────
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
	log "Installing oh-my-zsh"
	RUNZSH=no KEEP_ZSHRC=yes \
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ── 5. Secrets file (created from template, never overwritten) ────────────────
mkdir -p "$HOME/.config/shell"
if [[ ! -f "$HOME/.config/shell/secrets.zsh" ]]; then
	log "Creating ~/.config/shell/secrets.zsh from template (fill it in)"
	cp "$DOTFILES_DIR/shell/.config/shell/secrets.zsh.example" "$HOME/.config/shell/secrets.zsh"
fi

# ── 6. Dotfiles via stow (back up real files first) ──────────────────────────
log "Linking dotfiles with stow"
backup_dir="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
for f in .zshrc .gitconfig; do
	if [[ -e "$HOME/$f" && ! -L "$HOME/$f" ]]; then
		mkdir -p "$backup_dir"
		mv "$HOME/$f" "$backup_dir/"
		echo "  backed up ~/$f -> $backup_dir/$f"
	fi
done
for pkg in "${STOW_PACKAGES[@]}"; do
	stow --dir="$DOTFILES_DIR" --target="$HOME" --restow "$pkg"
done

# ── 7. macOS defaults ────────────────────────────────────────────────────────
log "Applying macOS defaults"
bash "$REPO_DIR/macos/defaults.sh"

log "Done. Restart your shell:  exec zsh"
