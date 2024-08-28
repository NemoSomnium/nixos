{ config, lib, pkgs, ... }:

{
  config = {
    home-manager.users.noams = { pkgs, ... }: {
      home.file = {
        ".config/autostart/1password.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Name=1Password
        Exec=sh -c "sleep 10 && 1password &"
        Icon=1password
        Terminal=false
        X-GNOME-Autostart-enabled=true
       '';
      };
    };
  };
}
