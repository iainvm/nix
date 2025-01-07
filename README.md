# Nix

All my systems with Nix

## Layout

The layout for this repo goes as follows

```sh
# Development
devShells/
    configuration.nix  # stores the nix shell config used for managing this repo

# Custom Modules
nixosModules/        # Many nix modules wrapped with options for system level packages
homeManagerModules/  # Many home manager modules wrapped with options for user level packages

# System Configs
nixosConfigurations/
    hostname/
        configuration.nix           # stores the system configurations this repo is used to manage
        hardware-configuration.nix
        users/
            username/
                dotfiles/           # Dotfiles (usually just mapped into `~/.config`)
                configuration.nix   # Home Manager configuration for the user
```

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
