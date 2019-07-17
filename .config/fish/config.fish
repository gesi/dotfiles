# Silence greeting
set fish_greeting ""

set -gx PATH \
  $PATH \
  $HOME/bin \
  $HOME/.yarn/bin

if test (uname) = "Darwin"
  source ~/.config/fish/darwin.fish
  nvm
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

# Abbreviations

## Git
abbr -a gco  git checkout
abbr -a gc   git commit
abbr -a gs   git status
abbr -a gpl  git pull
abbr -a gp   git push
abbr -a gst  git stash

abbr -a ll   ls -l
abbr -a lla  ls -la 
