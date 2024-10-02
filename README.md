# Nix

All my systems with Nix

## First Execution

Assuming a clean install:
```sh
# Install git
nix-shell -p git 

# Generate SSH Key to download this repo

# Add SSH key to GitHub

# Clone Repo
git clone git@github.com:iainvm/nix.git ~/dev/github.com/iainvm/nix
cd ~/dev/github.com/iainvm/nix

# Temporarily enable flakes
export NIX_CONFIG="experimental-features = nix-command flakes"

# Use direnv to get all the usual tools
nix-shell -p direnv
direnv enable

# Build the config
task build
```
