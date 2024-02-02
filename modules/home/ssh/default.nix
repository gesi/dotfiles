{
  programs.ssh = {
    enable = true;
    extraConfig = builtins.readFile ./config;
  };
}
