{ pkgs }:

with pkgs; [
  # nix stuff
  nixfmt

  alacritty
  fish
  # terminal colors
  grc
  starship
  tmux

  jetbrains-mono

  git
  direnv

  fzy
  fzf
  fasd

  ffmpeg

  bottom
  ripgrep
  jq
  jless

  # languages
  python311

  # kubernetes
  kubectl
  kubectx
  stern
  # broken atm
  # azure-cli
  google-cloud-sdk
  vault
  lastpass-cli

  # GIS
  # gdal

  # databases
  # postgresql

  # editor stuff
  vscode

]
