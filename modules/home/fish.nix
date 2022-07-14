{
  enable = true;

  shellInit = ''
    # Silence greeting
    set fish_greeting ""

    set -gx PATH $HOME/dotfiles/bin $PATH

    abbr -a gco   git checkout
    abbr -a gc    git commit
    abbr -a gs    git status
    abbr -a gpl   git pull
    abbr -a gp    git push
    abbr -a gst   git stash

    abbr -a ll    ls -l
    abbr -a lla   ls -la

    abbr -a k     kubectl
    abbr -a ktx   kubectx 
    abbr -a kns   kubens

    # starship prompt
    starship init fish | source

    # homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # volta
    set -gx VOLTA_HOME $HOME/.volta
    set -gx PATH $VOLTA_HOME/bin $PATH
  '';

  shellAliases = { wpw = "op item get jobb --fields label=password | pbcopy"; };
}
