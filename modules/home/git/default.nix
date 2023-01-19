{
  programs.git = {

    enable = true;
    userName = "gesi";
    userEmail = "helgesilset@gmail.com";

    aliases = { st = "status"; };

    extraConfig = {
      core = { pager = "delta"; };
      delta = {
        navigate = true;
        light = false;
      };
      merge = { conflictstyle = "diff3"; };
      init = { defaultBranch = "main"; };
      pull = { rebase = true; };
    };
  };
}
