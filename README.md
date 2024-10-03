# Nix

All my systems with Nix

## First Execution

Assuming a clean install:
```sh
# Generate SSH Key, add SSH key to GitHub
# Install git
nix-shell -p git

# Clone Repo
git clone git@github.com:iainvm/nix.git ~/dev/github.com/iainvm/nix
cd ~/dev/github.com/iainvm/nix

# Temporarily enable flakes
export NIX_CONFIG="experimental-features = nix-command flakes"

# Develop config
nix develop
```
