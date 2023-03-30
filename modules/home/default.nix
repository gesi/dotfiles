# home manager
{ config, lib, pkgs, ... }: {
  imports = [ ./git ./nvim ./fish ./vscode ./direnv ];

  home = {
    stateVersion = "23.05";
    packages = pkgs.callPackage ./packages.nix { };
  };

}
