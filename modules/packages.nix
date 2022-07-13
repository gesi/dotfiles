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

  git
  direnv

  fzy
  fzf
  fasd

  imagemagick
  ffmpeg

  bottom
  ripgrep
  jq

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
