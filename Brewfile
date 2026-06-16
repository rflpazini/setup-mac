# Brewfile — clean Python + Go development environment for a fresh macOS machine.
# Apply with:  brew bundle --file=Brewfile
# Audit with:  brew bundle cleanup --file=Brewfile   (lists installed-but-not-here)

# ─── CLI: core ───────────────────────────────────────────────────────────────
brew "git"
brew "gh"                 # GitHub CLI
brew "glab"               # GitLab CLI
brew "stow"               # dotfile symlink manager (used by bootstrap.sh)
brew "jq"
brew "yq"
brew "httpie"

# ─── Go ──────────────────────────────────────────────────────────────────────
brew "go"
brew "golangci-lint"      # meta-linter
brew "delve"              # debugger (dlv)

# ─── Python ──────────────────────────────────────────────────────────────────
brew "python@3.13"
brew "uv"                 # fast package/project manager
brew "ruff"               # fast linter/formatter
brew "pipx"               # isolated Python CLI apps

# ─── Node (kept for frontend tooling) ────────────────────────────────────────
brew "nvm"

# ─── Cloud / infra / k8s ─────────────────────────────────────────────────────
brew "awscli"
brew "terraform"
brew "helm"
brew "kubectx"            # kubectx + kubens
brew "minikube"
brew "tailscale"

# ─── Data ────────────────────────────────────────────────────────────────────
brew "mongosh"
brew "postgresql@14"      # provides psql / libpq

# ─── Security & quality ──────────────────────────────────────────────────────
brew "gitleaks"
brew "trivy"
brew "pre-commit"

# ─── Shell ───────────────────────────────────────────────────────────────────
brew "spaceship"          # zsh prompt
brew "zsh-syntax-highlighting"
brew "rtk"                # Rust Token Killer — LLM token proxy

# ─── GUI apps (casks) ────────────────────────────────────────────────────────
cask "arc"                # browser
cask "ghostty"            # terminal
cask "visual-studio-code"
cask "cursor"             # AI editor
cask "docker"             # Docker Desktop (container runtime)
cask "raycast"            # launcher
cask "1password"
cask "slack"

# ─── Optional — uncomment per machine ────────────────────────────────────────
# brew "cmake"
# brew "k6"               # load testing
# cask "postman"
# cask "notion"
