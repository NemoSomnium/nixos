{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Python Formatter
    black
    
    # Python Linter
    flake8
    
    # Python Debugging
    python3Packages.debugpy
    
    # Python Testing Framework
    pytest
    
    # Neovim Support
    python3Packages.neovim
    
    # Treesitter for syntax highlighting
    nvim-treesitter
  ];
}

