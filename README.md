```
# Install nix
sh <(curl -L https://nixos.org/nix/install)

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

nix-shell -p git
git clone https://github.com/gesi/dotfiles.git
cd dotfiles

HOST=''

# --extra-experimental-features only needed for the first run
# may need to remove/backup some config files (/etc/shells, fish.config, vscode settings, etc)
nix build ~/dotfiles\#darwinConfigurations.$HOST.system \
    --extra-experimental-features nix-command \
    --extra-experimental-features flakes


darwin-rebuild switch --flake ~/dotfiles#$HOST

# install latest nodejs
volta install node
```
