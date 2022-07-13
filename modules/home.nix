{ config, lib, pkgs, ... }: {

  # home manager

  home = {
    stateVersion = "22.05";

    packages = pkgs.callPackage ./packages.nix { };
  };

  programs = {
    fish = import ./home/fish.nix;

    vscode = import ./home/vscode.nix pkgs;

    git = {
      enable = true;
      userName = "gesi";
      userEmail = "helgesilset@gmail.com";

      aliases = { st = "status"; };

      extraConfig = {
        init = { defaultBranch = "main"; };
        pull = { rebase = true; };
      };
    };

  };

}
