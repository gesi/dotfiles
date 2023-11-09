{ pkgs }:

with pkgs; [
  # nix stuff
  nixfmt

  fish
  # terminal colors
  grc
  starship
  tmux

  tree

  jetbrains-mono

  git
  git-crypt
  git-lfs
  direnv

  fzy
  fzf
  fasd

  ffmpeg
  imagemagick

  # JSON is life
  jq
  jo
  jless

  pup
  # ministat
  # goaccess

  # replace boomer apps
  # delta
  bottom
  ripgrep
  eza
  bat
  fd
  sd

  rsync

  # neovim

  # better psql
  pgcli

  # languages
  # python
  python311
  poetry

  go
  # rust
  # rustc
  # cargo
  # rustfmt

  # kubernetes
  kubectl
  kubectx
  stern
  # broken atm
  # azure-cli

  (google-cloud-sdk.withExtraComponents [
    google-cloud-sdk.components.gke-gcloud-auth-plugin
    google-cloud-sdk.components.bq
  ])

  vault
  # lastpass-cli

  # GIS
  # gdal

  # databases
  # postgresql

  # editor stuff
  vscode

  nerdfonts
]
