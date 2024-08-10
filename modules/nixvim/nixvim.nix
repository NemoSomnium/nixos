{ pkgs, config, ... }:

{
  programs.nixvim = {
    enable = true;

    plugins = {
      coc = {
        enable = true;
        settings = {
          extensions = [ "coc-pyright" ];  # Python LSP support
        };
      };
      ale = {
        enable = true;
        settings = {
          fixers = {
            python = ["black"];  # Auto-formatting with Black
          };
          linters = {
            python = ["pylint"];  # Linting with Pylint
          };
        };
      };
      telescope = {
        enable = true;  # Fuzzy finder
      };
      nerdtree = {
        enable = true;  # File tree explorer
      };
      lualine = {
        enable = true;
        settings = {
          theme = "catppuccin";  # Optional: set the lualine theme
        };
      };
    };

    settings = {
      clipboard = "unnamedplus";  # Enables clipboard integration with system clipboard
    };
  };
}

