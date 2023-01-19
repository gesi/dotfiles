{
  programs.fish = {
    enable = true;
    shellInit = builtins.readFile ./config/config.fish;
  };
}
