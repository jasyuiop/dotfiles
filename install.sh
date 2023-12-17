#!/bin/bash

# Define the GitHub repository URL and target location
repo_url="git@github.com:jasyuiop/dotfiles.git"
cfg_dir="$HOME/.cfg"
backup_dir="$HOME/.config-backup"

# Clone the configuration from GitHub and set it as a bare Git repository
git clone --bare "$repo_url" "$cfg_dir"

# Define the dotfiles function
function dotfiles {
	/usr/bin/git --git-dir="$cfg_dir/" --work-tree="$HOME" "$@"
}

# Create the .config-backup directory
mkdir -p "$backup_dir"

# Check if the checkout was successful
if dotfiles checkout; then
	echo "Checked out config."
else
	echo "Backing up pre-existing dot files."

	# Move dot files to the .config-backup directory
	dotfiles checkout 2>&1 | awk '/^\s+\./ {print $1}' | xargs -I{} mv {} "$backup_dir/{}"
fi

# Run the dotfiles checkout command again and set status.showUntrackedFiles to no
dotfiles checkout
dotfiles config status.showUntrackedFiles no
