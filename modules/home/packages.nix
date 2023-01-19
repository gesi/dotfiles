{ pkgs }:

with pkgs; [
  # nix stuff
  nixfmt

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

  # JSON is life
  jq
  jo
  jless

  pup
  ministat
  goaccess

  # replace boomer apps
  # delta
  bottom
  ripgrep
  exa
  bat
  fd
  sd

  # neovim

  # better psql
  pgcli

  # languages
  # python
  python311
  # rust
  rustc
  cargo
  rustfmt

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
