#!/bin/zsh

# Show files with all extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Use the Fn key as a standard function key
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# Key repeat speed
defaults write NSGlobalDomain KeyRepeat -int 2

# Timing to start key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 11

# Disable auto-capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Do not create .DS_Store files on USB or network storage
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable waiting time before the Dock is displayed
defaults write com.apple.dock autohide-delay -float 0

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Display the status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Display the path bar
defaults write com.apple.finder ShowPathbar -bool true

# Enable key repeat for VSCode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# Apply soon
for app in "Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done