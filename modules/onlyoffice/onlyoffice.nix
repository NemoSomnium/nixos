{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    culmus
  ];

  fonts.fonts = [
    pkgs.culmus
  ];

  services.onlyoffice = {
    enable = true;
  };
}

