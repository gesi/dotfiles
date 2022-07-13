{
  description = "My Nix Environment";

  inputs = {
    # Use latest/nixpkgs and/or NUR
    nixpkgs.url = "github:nixos/nixpkgs/master";
    nur.url = "github:nix-community/nur";

    # nix-darwin
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # home-manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # yabai
    yabai = {
      url = "github:koekeishiya/yabai";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, ... }:
    let
      inherit (darwin.lib) darwinSystem;

      mkDarwinConfig = { system ? "aarch64-darwin", nixpkgs ? inputs.nixpkgs
        , baseModules ? [
          home-manager.darwinModules.home-manager
          ./modules/darwin.nix
        ], extraModules ? [ ] }:
        darwinSystem {
          inherit system;
          modules = baseModules ++ extraModules;
          specialArgs = { inherit inputs nixpkgs; };
        };
    in {
      darwinConfigurations = {
        nrk = mkDarwinConfig { extraModules = [ ./overlays/yabai.nix ]; };
      };
    };
}
