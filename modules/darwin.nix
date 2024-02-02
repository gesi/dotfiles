{ config, pkgs, lib, inputs, ... }:

let
  user = builtins.getEnv "USER";
  name = if builtins.elem user [ "" "root" ] then "helge.silset" else user;
in {

  # nix-darwin configuration

  users.users.${name} = {
    home = "/Users/${name}";
    shell = pkgs.fish;
  };

  home-manager = {
    useGlobalPkgs = true;
    users.${name} = { imports = [ ./home ]; };
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

    settings = {
      # sysctl -n hw.ncpuA

      max-jobs = 10;
      cores = 10;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

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
        # Unload the macOS WindowManager process
        launchctl unload -F /System/Library/LaunchAgents/com.apple.WindowManager.plist > /dev/null 2>&1 &

        yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
        sudo yabai --load-sa

        # off
        yabai -m rule --add app="Creative Cloud" manage=off
        yabai -m rule --add app="^Install macOS" manage=off
        yabai -m rule --add app="^(Calculator|Software Update|Dictionary|VLC|System Preferences|Photo Booth|Archive Utility|Python|App Store|Alfred|Activity Monitor)$" manage=off
        yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
        yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$" manage=off
        yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off
      '';
    };

    skhd = {
      enable = true;
      package = pkgs.skhd;
      skhdConfig = ''
        # open terminal
        cmd - return : kitty --single-instance


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

  programs = { fish.enable = true; };

  environment.shells = with pkgs; [ fish ];

  system = {
    stateVersion = 4;

    activationScripts.postActivation.text = ''
      # Set the default shell as fish for the user.
      sudo chsh -s ${lib.getBin pkgs.fish}/bin/fish ${name}

      # Set desktop background
      # /Users/${name}/dotfiles/bin/set_desktop_background

      # Update macos defaults not supported by `system.defaults`
      /Users/${name}/dotfiles/bin/macos_defaults
    '';

    defaults = {
      NSGlobalDomain = {
        # Disable press-and-hold for keys in favor of key repeat
        ApplePressAndHoldEnabled = false;

        # Machine gun keys
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

    onActivation = {
      cleanup = "uninstall";
      upgrade = true;
    };

    taps = [
      "homebrew/services"
      "Azure/kubelogin"
      "nrkno/hylla"

      #{ name = ""; clone_target = "git uri"; force_auto_update = true; }
    ];

    brews = [
      "ghostscript"

      "mas"

      "openssl"

      "akamai"

      # PostgreSQL for the same reason as azure-cli
      {
        name = "postgresql@15";
        restart_service = true;
        start_service = true;
        # link = true;
        conflicts_with = [ "postgresql" ];
      }

      "volta"

      "brightness"

      "gnumeric"

      "nrk8s"
    ];

    casks = [
      # password manager
      "1password"
      # 1password cli is available in nix, but biometric unlock won't work
      # when the binary is located on the /nix volume
      "1password-cli"

      # chats
      "slack"
      "discord"
      "microsoft-teams"

      # browsers
      #"google-chrome"
      "firefox"

      # gfx
      # "adobe-creative-cloud"
      "blender"

      # "microsoft-office"

      "qgis"

      "figma"
    ];

    masApps = {
      QuickShade = 931571202;
      Xcode = 497799835;
    };
  };

}
