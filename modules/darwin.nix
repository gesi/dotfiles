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
      enable = true;
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
        top_padding = 10;
        bottom_padding = 10;
        left_padding = 10;
        right_padding = 10;
        window_gap = 10;
      };

      extraConfig = ''
        yabai -m rule --add app='System Preferences' manage=off
        yabai -m rule --add app='Activity Monitor' manage=off
        yabai -m rule --add app='alacritty' manage=on
      '';
    };

    skhd = {
      enable = true;
      package = pkgs.skhd;
      skhdConfig = ''
        # open terminal
        cmd - return : alacritty

        # spaces
        alt - tab : yabai -m space --focus recent
        alt - 1   : yabai -m space --focus 1
        alt - 2   : yabai -m space --focus 2
        alt - 3   : yabai -m space --focus 3
        alt - 4   : yabai -m space --focus 4
        alt - 5   : yabai -m space --focus 5
        alt - 6   : yabai -m space --focus 6
        alt - 7   : yabai -m space --focus 7
        alt - 8   : yabai -m space --focus 8
      '';
    };
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

    activationScripts.postActivation.text = ''
      # Set the default shell as fish for the user.
      sudo chsh -s ${lib.getBin pkgs.fish}/bin/fish ${name}
    '';

    defaults = {
      NSGlobalDomain = {
        # Disable press-and-hold for keys in favor of key repeat
        ApplePressAndHoldEnabled = false;

        # Set a blazingly fast keyboard repeat rate
        KeyRepeat = 1;
        InitialKeyRepeat = 10;

        AppleShowAllExtensions = true;

      };

      dock = {
        autohide = true;
        showhidden = true;
        launchanim = false;

        tilesize = 36;
      };

      finder = {
        QuitMenuItem = true;
        ShowStatusBar = true;
        ShowPathbar = true;

        _FXShowPosixPathInTitle = true;
        # currently not in nix-darwin
        # _FXSortFoldersFirst = true;

        # When performing a search, search the current folder by default
        FXDefaultSearchScope = "SCcf";

        # Disable the warning when changing a file extension
        FXEnableExtensionChangeWarning = false;

        # Use list view in all Finder windows by default
        # Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
        FXPreferredViewStyle = "Nlsv";

        # Disable the warning before emptying the Trash
        # Currently not working in nix-darwin
        # WarnOnEmptyTrash = false;
      };
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

    taps = [ ];

    brews = [
      "mas"

      # Install azure-cli with homebrew since pyopenssl is broken in nix
      "azure-cli"

      # PostgreSQL for the same reason as azure-cli
      "postgresql"

      "volta"
    ];

    casks = [
      # password manager
      "1password"
      # 1password cli is available in nix, but biometric unlock won't work
      # when the binary is located on the /nix volume
      "1password-cli"

      # not available in nix for m1
      "spotify"

      # chats
      "slack"
      "discord"

      # browsers
      "google-chrome"
      "firefox"

      # gfx
      "adobe-creative-cloud"
    ];

    masApps = { };
  };

}
