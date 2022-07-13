{ config, pkgs, lib, inputs, ... }: {
  nixpkgs = {
    overlays = with inputs; [
      nur.overlay
      (final: prev: {
        yabai = let
          version = "4.0.1";
          buildSymlinks = prev.runCommand "build-symlinks" { } ''
            mkdir -p $out/bin
            ln -s /usr/bin/xcrun /usr/bin/xcodebuild /usr/bin/tiffutil /usr/bin/qlmanage $out/bin
          '';
        in prev.yabai.overrideAttrs (old: {
          inherit version;
          src = inputs.yabai;

          buildInputs = with prev.darwin.apple_sdk.frameworks; [
            Carbon
            Cocoa
            ScriptingBridge
            prev.xxd
            SkyLight
          ];

          nativeBuildInputs = [ buildSymlinks ];
        });
      })
    ];
  };
}
