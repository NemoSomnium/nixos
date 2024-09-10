{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs.gnomeExtensions; [
    #pano
    clipboard-indicator
    cronomix
    paperwm
    # Add other extensions as needed
  ];

  # Enable GNOME Shell extensions management
  services.gnome.gnome-browser-connector.enable = true;

  # Enable dconf
  programs.dconf.enable = true;

  # Configure GNOME Shell extensions
  home-manager.users.noams = { ... }: {
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          #"pano@elhan.io"
	  "clipboard-indicator@tudmotu.com"
          "cronomix@zagortenay333"
	  "apps-menu@gnome-shell-extensions.gcampax.github.com"
	  "drive-menu@gnome-shell-extensions.gcampax.github.com"
	  "places-menu@gnome-shell-extensions.gcampax.github.com"
	  "system-monitor@gnome-shell-extensions.gcampax.github.com"
    # "paperwm@paperwm.github.com"
	  # Add more extension UUIDs as needed
        ];
      };
    };
  };
}

