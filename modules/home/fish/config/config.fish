
#    ▄████████  ▄█     ▄████████    ▄█    █▄    
#   ███    ███ ███    ███    ███   ███    ███   
#   ███    █▀  ███▌   ███    █▀    ███    ███   
#  ▄███▄▄▄     ███▌   ███         ▄███▄▄▄▄███▄▄ 
# ▀▀███▀▀▀     ███▌ ▀███████████ ▀▀███▀▀▀▀███▀  
#   ███        ███           ███   ███    ███   
#   ███        ███     ▄█    ███   ███    ███   
#   ███        █▀    ▄████████▀    ███    █▀    


# Silence greeting
set fish_greeting ""

fish_vi_key_bindings

set -gx PATH $HOME/dotfiles/bin $PATH

# git
abbr -a gco git checkout
abbr -a gc git commit
abbr -a gs git status
abbr -a gpl git pull
abbr -a gp git push
abbr -a gst git stash

abbr -a cat bat

abbr -a ll ls -l
abbr -a lla ls -la

# aliases
alias wpw "op read op://personal/jobb/password --no-newline | pbcopy"
alias jless "jless --mode line"
alias grep rg
alias ls exa
alias pbclear "echo -n '' | pbcopy"
alias pn pnpm

# kubernetes
kubectl completion fish | source

abbr -a k kubectl
abbr -a ktx kubectx
abbr -a kns kubens

# starship prompt
starship init fish | source

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# volta
set -gx VOLTA_HOME $HOME/.volta
set -gx PATH $VOLTA_HOME/bin $PATH
set -gx VOLTA_FEATURE_PNPM 1

set -gx USE_GKE_GCLOUD_AUTH_PLUGIN True

# podman api forwarding
set -gx DOCKER_HOST "unix:///$HOME/.local/share/containers/podman/machine/podman.sock"

# pg
fish_add_path /opt/homebrew/opt/postgresql@15/bin

# direnv
direnv hook fish | source
set -g direnv_fish_mode eval_on_arrow


for f in $HOME/dotfiles/fish/**/*.fish
    source $f
end
