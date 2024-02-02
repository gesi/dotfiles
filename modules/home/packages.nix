{ pkgs }:

with pkgs; [
  # nix stuff
  nixfmt

  kitty

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
  python3

  go
  # rust
  # rustc
  # cargo
  # rustfmt

  # docker replacement
  podman
  # local kube cluster
  kind
  act

  # kubernetes
  kubectl
  kubectx
  stern

  # cloud provider clis
  azure-cli
  kubelogin

  (google-cloud-sdk.withExtraComponents [
    google-cloud-sdk.components.gke-gcloud-auth-plugin
    google-cloud-sdk.components.bq
  ])

  vault
  lastpass-cli

  # GIS
  gdal

  # databases
  # postgresql

  # editor stuff
  vscode

  spotify

  nerdfonts
]
