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
  git-crypt
  direnv

  fzy
  fzf
  fasd

  ffmpeg

  jq
  jless

  # replace boomer apps
  # delta
  bottom
  ripgrep
  exa
  bat
  fd
  sd

  # better psql
  # pgcli

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

  nerdfonts

]
