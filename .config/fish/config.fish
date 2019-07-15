# Silence greeting'
set fish_greeting ""

set -gx PATH \
  $PATH \
  $HOME/bin \
  $HOME/.yarn/bin

if test (uname) = "Darwin"
  source ~/.config/fish/darwin.fish
end

set -l kube_configs ~/.kube/configs
if test -d $kube_configs
  echo (string join ':' (ls -d $kube_configs/*)) | read -a -x KUBECONFIG
end

set -l utils ~/.config/fish/utils
if test -d $utils
  for f in $utils/*.fish
    source $f
  end
end

nvm

