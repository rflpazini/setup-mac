# env.zsh — non-secret environment variables.
# Secrets live in ~/.config/shell/secrets.zsh (gitignored). See secrets.zsh.example.

# ── Locale ───────────────────────────────────────────────────────────────────
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ── Go ───────────────────────────────────────────────────────────────────────
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export GOSUMDB=off
export GOPRIVATE="github.com/Pluto-Tv*,github.com/rflpazini*"
export GIT_TERMINAL_PROMPT=1

# ── Claude Code ──────────────────────────────────────────────────────────────
export CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1

# ── Antigravity (added if present) ───────────────────────────────────────────
[[ -d "$HOME/.antigravity/antigravity/bin" ]] && export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# ── pipx ─────────────────────────────────────────────────────────────────────
export PATH="$PATH:$HOME/.local/bin"
