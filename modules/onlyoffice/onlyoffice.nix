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
    config = {
      fonts = {
        path = [
          "/usr/share/fonts"
          "/usr/share/fonts/culmus"
        ];
        name = [
          "David"
          "FrankRuehl"
          "Miriam"
          "Narkisim"
        ];
      };
    };
  };
}

