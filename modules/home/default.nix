# home manager
{ config, lib, pkgs, ... }: {
  imports = [ ./git ./nvim ./fish ./vscode ];

  home = {
    stateVersion = "23.05";
    packages = pkgs.callPackage ./packages.nix { };
  };

}
