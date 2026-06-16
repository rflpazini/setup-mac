# aliases.zsh — shell aliases.

# ── General ──────────────────────────────────────────────────────────────────
alias reload="source ~/.zshrc"
alias datenow='echo $(date "+%y.%m.%d-%H%M")'
alias ip="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d' ' -f2"

# ── Navigation ───────────────────────────────────────────────────────────────
alias personal="cd ~/Documents/Development/personal"
alias pluto="cd ~/Documents/Development/pluto"
alias arvo="cd ~/Documents/Development/arvo"

# ── Kubernetes ───────────────────────────────────────────────────────────────
alias k=kubectl
# zsh-native completion for the `k` alias (after kubectl completion is loaded)
compdef k=kubectl 2>/dev/null

# ── Claude Code ──────────────────────────────────────────────────────────────
alias claudex='claude --dangerously-skip-permissions'
alias claudehere='claude --dangerously-skip-permissions .'
alias dump='cd "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/obsidian-mind" && claude --dangerously-skip-permissions --model claude-sonnet-4-6 --thinking enabled -p'
alias brain='cd "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/obsidian-mind" && claude --dangerously-skip-permissions --model claude-sonnet-4-6 --thinking enabled'
