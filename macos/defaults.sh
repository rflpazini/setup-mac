#!/usr/bin/env bash
# macos/defaults.sh — opinionated macOS system preferences.
# Safe to run repeatedly. Some settings need a logout/restart to take effect.
#
# References:
#   https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Best-effort: a single `defaults write` that errors on a given macOS version
# must NOT abort the run, so we deliberately do NOT use `set -e` here.
set -uo pipefail

echo "==> Applying macOS defaults"

# Close System Settings so it doesn't override what we change.
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true

# ── Keyboard ──────────────────────────────────────────────────────────────────
defaults write NSGlobalDomain InitialKeyRepeat -int 15   # fast initial repeat
defaults write NSGlobalDomain KeyRepeat -int 2           # fast repeat rate
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false  # key repeat over accents
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3 # full keyboard access (Tab in dialogs)

# ── Trackpad ──────────────────────────────────────────────────────────────────
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Two-finger tap = right click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# ── Finder ────────────────────────────────────────────────────────────────────
defaults write com.apple.finder AppleShowAllFiles -bool true            # show hidden files
defaults write NSGlobalDomain AppleShowAllExtensions -bool true         # show all extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"    # list view
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"    # search current folder
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# ── Dock ──────────────────────────────────────────────────────────────────────
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0          # no show delay
defaults write com.apple.dock autohide-time-modifier -float 0  # no animation
defaults write com.apple.dock orientation -string left
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock show-recents -bool false

# ── Menu bar ──────────────────────────────────────────────────────────────────
defaults write com.apple.menuextra.battery ShowPercent -string "YES" 2>/dev/null || true
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm:ss"
defaults write com.apple.menuextra.clock FlashDateSeparators -bool true

# ── Panels & saving ───────────────────────────────────────────────────────────
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false  # save locally by default
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# ── Screenshots ───────────────────────────────────────────────────────────────
mkdir -p "${HOME}/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Pictures/Screenshots"
defaults write com.apple.screencapture type -string "png"

# ── Hot corners (0:none 2:Mission Control 3:App windows 4:Desktop 5:Screensaver) ─
defaults write com.apple.dock wvous-tl-corner -int 2   # top-left → Mission Control
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 4   # top-right → Desktop
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-bl-corner -int 3   # bottom-left → App windows
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 0   # bottom-right → none
defaults write com.apple.dock wvous-br-modifier -int 0

# ── Wallpaper (from this repo) ────────────────────────────────────────────────
WALLPAPER="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/files/wallpaper/wallpaper.png"
if [[ -f "$WALLPAPER" ]]; then
	osascript -e "tell application \"System Events\" to set picture of every desktop to (\"$WALLPAPER\" as POSIX file as alias)" 2>/dev/null || true
fi

# ── Optional / aggressive (uncomment if you want them) ────────────────────────
# sudo systemsetup -setcomputersleep Never      # never sleep
# defaults -currentHost write com.apple.screensaver idleTime 0  # disable screensaver

# ── Apply ─────────────────────────────────────────────────────────────────────
for app in Finder Dock SystemUIServer; do
	killall "$app" >/dev/null 2>&1 || true
done

echo "==> macOS defaults applied. Some changes require a logout to take full effect."
