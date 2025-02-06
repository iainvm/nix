# Nix

All my systems with Nix

## Layout

The layout for this repo goes as follows

```sh
# Development
devShells/
    configuration.nix   # stores the nix shell config used for managing this repo

# Home Manager Configs
homeModules/     # Many home manager modules wrapped with options for user level packages
homeConfigurations/     # Configs for each user, allows user to use `home-manager switch` without root to update their config
    "${user}@${host}"/
        dotfiles        # Usually mapped into `~/.config`
        home.nix

# System Configs
nixosModules/           # Many nix modules wrapped with options for system level packages
nixosConfigurations/
    hostname/
        configuration.nix           # stores the system configurations this repo is used to manage
        hardware-configuration.nix
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
