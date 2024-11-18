# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:
let
  nixpkgs-master = inputs.nixpkgs-master.legacyPackages.${pkgs.system};
  nixpkgs-unfree-master = inputs.nixpkgs-unfree-master.legacyPackages.${pkgs.system};
  packagesFromMaster = with nixpkgs-master; [
  # Packages from master branch go here
  ];
  packagesFromUnfreeMaster = with nixpkgs-unfree-master; [
  # Packages from unfree master branch go here
  ];
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "framework"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Asia/Jerusalem";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IL";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IL";
    LC_IDENTIFICATION = "en_IL";
    LC_MEASUREMENT = "en_IL";
    LC_MONETARY = "en_IL";
    LC_NAME = "en_IL";
    LC_NUMERIC = "en_IL";
    LC_PAPER = "en_IL";
    LC_TELEPHONE = "en_IL";
    LC_TIME = "en_IL";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Configure fprintd for fingerprint
  services.fprintd.enable = true;
  
  # Enable framework power-profiles-daemon
  services.power-profiles-daemon.enable = true;
  
  # Enable fwupd for firmware updates
  services.fwupd.enable = true;
  
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Emacs daemon service
  services.emacs = {
  enable = true;
  };

  # Enable unsupported pkgs
  nixpkgs.config.allowUnsupportedSystem = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.noams = {
    isNormalUser = true;
    description = "Noam Sar-El";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
    shell = pkgs.zsh;
  };
  
  # Enabling ZSH
  programs.zsh.enable = true;

  # Enable stylix
  stylix.enable = true;
  
  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "noams" = import ./home.nix;
    };
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Enable PacketTracer
  programs.packettracer.enable = true;

  # Enable Hyprland

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  programs.hyprland = {
    enable = true;
    package = inputs.nixpkgs-master.legacyPackages.${pkgs.system}.hyprland;
    portalPackage = inputs.nixpkgs-master.legacyPackages.${pkgs.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    xdgOpenUsePortal = false;
    # extraPortals = [
    #   inputs.nixpkgs-master.legacyPackages."${pkgs.system}".xdg-desktop-portal-hyprland
    #   inputs.nixpkgs-master.legacyPackages."${pkgs.system}".xdg-desktop-portal-gtk
    # ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    alacritty    
    kitty
    cachix
    nh
    nix-output-monitor
    nvd
    # Hyprland pkgs
    hyprpaper
    qt5.qtwayland
    qt6.qtwayland
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtsvg
    xfce.thunar
    zip
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    # swayidle
    adwaita-icon-theme
    glib
    gsettings-desktop-schemas
    nwg-look
    # swaylock-effects
    wlogout
    wl-clipboard
    wofi
    waybar
    # mako
    dunst
    libnotify
    swww
    rofi-wayland
    networkmanagerapplet
    pamixer
    papirus-folders
    papirus-icon-theme
    hyprshot
    catppuccin-gtk
    wlr-randr
    acpid
    killall
    hyprlock
    hypridle
  ] ++ packagesFromMaster ++ packagesFromUnfreeMaster;

  # Extra hyprland settings
  services.acpid = {
    enable = true;

    lidEventCommands = ''
      export WAYLAND_DISPLAY=wayland-1  # Correct display based on your system
      export XDG_RUNTIME_DIR=/run/user/1000  # Replace with the actual value if different

      lid_state=$(/run/current-system/sw/bin/cat /proc/acpi/button/lid/LID0/state | /run/current-system/sw/bin/awk '{print $2}')
      echo $(date) - Raw lid state: $lid_state >> /tmp/lid-state.log

      if [[ "$lid_state" == "closed" ]]; then
          /run/current-system/sw/bin/wlr-randr --output eDP-1 --off >> /tmp/lid-state.log 2>&1
          echo $(date) - Lid closed, turning off screen >> /tmp/lid-state.log
      elif [[ "$lid_state" == "open" ]]; then
          /run/current-system/sw/bin/wlr-randr --output eDP-1 --on >> /tmp/lid-state.log 2>&1
          echo $(date) - Lid opened, turning on screen >> /tmp/lid-state.log
      else
          echo $(date) - Lid state unknown: $lid_state >> /tmp/lid-state.log
      fi
    '';

  #   # Commands to execute when the lid is closed or opened
  #   lidEventCommands = ''
  #     # Using absolute path for awk
  #     lid_state=$(/run/current-system/sw/bin/cat /proc/acpi/button/lid/LID0/state | /run/current-system/sw/bin/awk '{print $2}')
  #     echo $(date) - Raw lid state: $lid_state >> /tmp/lid-state.log

  #     if [[ "$lid_state" == "closed" ]]; then
  #         /run/current-system/sw/bin/wlr-randr --output eDP-1 --off
  #         echo $(date) - Lid closed, turning off screen >> /tmp/lid-state.log
  #     elif [[ "$lid_state" == "open" ]]; then
  #         /run/current-system/sw/bin/wlr-randr --output eDP-1 --on
  #         echo $(date) - Lid opened, turning on screen >> /tmp/lid-state.log
  #     else
  #         echo $(date) - Lid state unknown: $lid_state >> /tmp/lid-state.log
  #     fi
  #   '';
  };
  # Enable dconf and set up the user profile with font, icon theme, and GTK theme
  programs.dconf = {
    enable = true;
    profiles = {
      # Define a "user" profile for dconf
      user = {
        databases = [
          {
            # Define GNOME-specific settings
            settings = {
              "org/gnome/desktop/interface" = {
                font-name = "JetBrainsMonoNL Nerd Font Regular 12";
                gtk-theme = "Catppuccin-Mocha";
                icon-theme = "Papirus-Dark";
              };
            };
          }
        ];
      };
    };
  };
  nixpkgs.config.permittedInsecurePackages = [
    # "electron-29.4.6"
  ];

  # Enable ozone for electron apps on waylans
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
