{ config, pkgs, ... }:

{
  # Enable Stylix
  stylix.enable = true;

  # Set the base16 color scheme using the Catppuccin Mocha theme
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  
  # Use a custom wallpaper
  stylix.image = /home/noams/Pictures/wall.png;
  stylix.polarity = "dark";  # Force dark theme

  # Set JetBrains Mono Nerd Font as the default monospace font
  stylix.fonts = {
    monospace = {
      package = pkgs.jetbrains-mono;
      name = "JetBrainsMonoNL Nerd Font";
    };
    serif = {
      package = pkgs.jetbrains-mono;
      name = "JetBrainsMonoNL Nerd Font";
    };
    sansSerif = {
      package = pkgs.jetbrains-mono;
      name = "JetBrainsMonoNL Nerd Font";
    };
  };

  stylix.cursor.size = 24;

  # stylix.autoEnable = true;
}
