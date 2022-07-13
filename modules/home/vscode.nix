{ pkgs, ... }:

{
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
    "[javascript]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
    "[json]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
    "[typescriptreact]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[typescript]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
    "[svelte]" = { "editor.defaultFormatter" = "svelte.svelte-vscode"; };

  };
}
