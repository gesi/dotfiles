{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions;
      [
        # vim r.i.n
        # vscodevim.vim
        asvetliakov.vscode-neovim

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
        ms-azuretools.vscode-docker
        rust-lang.rust-analyzer

      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
        name = "jq-syntax-highlighting";
        publisher = "jq-syntax-highlighting";
        version = "0.0.2";
        sha256 = "0q91mr6a6935wnka5iga97lv78g19dlj2rz6qg3ki6w3kdlvw2h7";
      }];

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
      # typescript
      "typescript.tsdk" = "node_modules/typescript/lib";

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
      "[css]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[svelte]" = { "editor.defaultFormatter" = "svelte.svelte-vscode"; };
      "[html]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
      # neovim
      "extensions.experimental.affinity" = { "asvetliakov.vscode-neovim" = 1; };
      "vscode-neovim.neovimExecutablePaths.darwin" =
        "/Users/helge/.nix-profile/bin/nvim";
    };
  };
}
