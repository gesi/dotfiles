# home manager
{ config, lib, pkgs, ... }: {
  imports = [ ./git ./nvim ./fish ./vscode ];

  home = {
    stateVersion = "22.05";
    packages = pkgs.callPackage ./packages.nix { };
  };

}
