{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Python Formatter
    python310Packages.black
    
    # Python Linter
    python310Packages.flake8
    
    # Python Debugging
    python310Packages.debugpy
    
    # Python Testing Framework
    python310Packages.pytest
    
    # Neovim Support
    python310Packages.pynvim
    
  ];
}
