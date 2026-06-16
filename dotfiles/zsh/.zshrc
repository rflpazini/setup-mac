# ~/.zshrc — managed by setup-mac (https://github.com/rflpazini/setup-mac)

# ── Homebrew (arch-aware: Apple Silicon → /opt/homebrew, Intel → /usr/local) ──
if [[ -x /opt/homebrew/bin/brew ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
	eval "$(/usr/local/bin/brew shellenv)"
fi

# ── oh-my-zsh ─────────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
plugins=(git)
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# ── Prompt: spaceship ─────────────────────────────────────────────────────────
[[ -f "$HOMEBREW_PREFIX/opt/spaceship/spaceship.zsh" ]] && \
	source "$HOMEBREW_PREFIX/opt/spaceship/spaceship.zsh"

# ── Modular config (env, functions, aliases, secrets) ─────────────────────────
for _f in env functions aliases secrets; do
	[[ -f "$HOME/.config/shell/$_f.zsh" ]] && source "$HOME/.config/shell/$_f.zsh"
done
unset _f

# ── Node (nvm) ────────────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ]] && source "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
[[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ]] && \
	source "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"

# ── Google Cloud SDK ──────────────────────────────────────────────────────────
[[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]] && source "$HOME/google-cloud-sdk/path.zsh.inc"
[[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]] && source "$HOME/google-cloud-sdk/completion.zsh.inc"

# ── Docker CLI completions ────────────────────────────────────────────────────
[[ -d "$HOME/.docker/completions" ]] && fpath=("$HOME/.docker/completions" $fpath)

# ── Completions ───────────────────────────────────────────────────────────────
autoload -Uz compinit && compinit
[[ ${commands[kubectl]} ]] && source <(kubectl completion zsh)

# ── Syntax highlighting (keep near the end) ───────────────────────────────────
[[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && \
	source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
