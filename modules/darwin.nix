{ config, pkgs, lib, inputs, ... }:

let
  user = builtins.getEnv "USER";
  name = if builtins.elem user [ "" "root" ] then "helge" else user;
in {

  # nix-darwin configuration

  users.users.${name} = {
    home = "/Users/${name}";
    shell = pkgs.fish;
  };

  home-manager = {
    useGlobalPkgs = true;
    users.${name} = { imports = [ ./home.nix ]; };
  };

  nix = {
    package = pkgs.nixUnstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      system = aarch64-darwin
      experimental-features = nix-command flakes
      build-users-group = nixbld
    '';
    useDaemon = true;

    # sysctl -n hw.ncpu
    maxJobs = 10;
    buildCores = 10;
  };

  services = {
    nix-daemon.enable = true;
    activate-system.enable = true;

    yabai = {
      enable = false;
      package = pkgs.yabai;
      enableScriptingAddition = true;
      config = {
        # focus_follows_mouse          = "autoraise";
        mouse_follows_focus = "off";
        window_placement = "second_child";
        window_opacity = "off";
        window_opacity_duration = "0.0";
        window_border = "off";
        # window_border_placement      = "inset";
        # window_border_width          = 2;
        # window_border_radius         = 3;
        active_window_border_topmost = "off";
        window_topmost = "on";
        window_shadow = "float";
        # active_window_border_color   = "0xff5c7e81";
        # normal_window_border_color   = "0xff505050";
        # insert_window_border_color   = "0xffd75f5f";
        active_window_opacity = "1.0";
        normal_window_opacity = "1.0";
        split_ratio = "0.50";
        auto_balance = "on";
        mouse_modifier = "fn";
        mouse_action1 = "move";
        mouse_action2 = "resize";
        layout = "bsp";
        top_padding = 36;
        bottom_padding = 10;
        left_padding = 10;
        right_padding = 10;
        window_gap = 10;
      };

      extraConfig = ''
        # rules
        yabai -m rule --add app='System Preferences' manage=off

        # Any other arbitrary config here
      '';
    };

    skhd = { enable = true; };
  };

  nixpkgs = {
    config = {
      # Suck it stallman
      allowUnfree = true;
      allowBroken = false;
      allowInsecure = false;
      allowUnsupportedSystem = false;
    };

    overlays = [ ];
  };

  programs = {
    fish.enable = true;

  };

  environment.shells = with pkgs; [ fish ];

  system = {
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        # Disable press-and-hold for keys in favor of key repeat
        ApplePressAndHoldEnabled = false;

        # Set a blazingly fast keyboard repeat rate
        KeyRepeat = 1;
        InitialKeyRepeat = 10;
      };

      dock = {
        autohide = true;
        showhidden = true;
        launchanim = false;
      };

      finder = { };
    };

    keyboard = {
      enableKeyMapping = true;
      # Very important
      remapCapsLockToEscape = true;

      userKeyMapping = [ ];

    };

  };

  homebrew = {
    enable = true;

    brews = [
      "mas"

      # Install azure-cli with homebrew since pyopenssl is broken in nix
      "azure-cli"

      "volta"
    ];

    casks = [
      # password manager
      "1password"
      "1password-cli"

      # chats
      "slack"
      "discord"

      # browsers
      "google-chrome"
      "firefox"

    ];

    masApps = { };
  };

}
