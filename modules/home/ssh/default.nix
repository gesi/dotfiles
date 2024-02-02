{
  programs.ssh = {
    enabled = true;
    extraConfig = builtins.readFile ./config;
  };
}
