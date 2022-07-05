{ config, lib, pkgs, ... }: {

  # home manager

  home = {
    stateVersion = "22.05";

    packages = pkgs.callPackage ./packages.nix { };
  };

  programs = {
    fish = rec {
      enable = true;

      shellInit = ''
        abbr -a gco   git checkout
        abbr -a gc    git commit
        abbr -a gs    git status
        abbr -a gpl   git pull
        abbr -a gp    git push
        abbr -a gst   git stash

        abbr -a ll    ls -l
        abbr -a lla   ls -la

        abbr -a k     kubectl
        abbr -a ktx   kubectx 
        abbr -a kns   kubens

        # homebrew
        eval "$(/opt/homebrew/bin/brew shellenv)"

        # volta
        set -gx VOLTA_HOME $HOME/.volta
        set -gx PATH $VOLTA_HOME/bin $PATH
      '';
    };

    git = {
      enable = true;
      userName = "gesi";
      userEmail = "helgesilset@gmail.com";

      aliases = { st = "status"; };

      extraConfig = { init = { defaultBranch = "main"; }; };
    };

    vscode = {
      enable = true;

      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        eamodio.gitlens

        # nix
        bbenoist.nix
        brettm12345.nixfmt-vscode

        # javascript
        esbenp.prettier-vscode
        svelte.svelte-vscode
        dbaeumer.vscode-eslint

        # other languages/misc
        skyapps.fish-vscode
        mikestead.dotenv
      ];

      userSettings = {
        "terminal.integrated.defaultProfile.osx" = "fish";
        # don't collapse/compact directories
        "explorer.compactFolders" = false;
        "editor.formatOnSave" = true;
        "keyboard.dispatch" = "keyCode";
        "vim.useSystemClipboard" = true;
        # brackets
        "editor.bracketPairColorization.enabled" = true;
        "editor.guides.bracketPairs" = "active";
        "editor.cursorStyle" = "line";
        "editor.lineNumbers" = "on";
        # Tabs
        "editor.tabSize" = 2;
        "editor.useTabStops" = false;
        "eslint.validate" =
          [ "javascript" "javascriptreact" "typescript" "typescriptreact" ];
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "files.associations" = { ".env.preproduction" = "dotenv"; };
        # prettier
        "prettier.singleQuote" = true;
        "prettier.jsxSingleQuote" = true;
        "prettier.semi" = false;

        "svelte.enable-ts-plugin" = true;
        # "workbench.iconTheme": "material-icon-theme",
        "typescript.updateImportsOnFileMove.enabled" = "always";
        "javascript.updateImportsOnFileMove.enabled" = "always";
        "[javascript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[json]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
        "[typescriptreact]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[typescript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[svelte]" = { "editor.defaultFormatter" = "svelte.svelte-vscode"; };

      };
    };
  };

}
