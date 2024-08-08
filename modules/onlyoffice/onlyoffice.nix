{ config, pkgs, ... }:

let
  # Define specific Hebrew fonts from culmus
  hebrewFonts = pkgs.culmus.overrideAttrs (old: rec {
    fonts = [ "David" "FrankRuehl" "Miriam" "Narkisim" ];
  });
in
{
  environment.systemPackages = with pkgs; [
    hebrewFonts
  ];

  fonts.fonts = [
    hebrewFonts
  ];

  services.onlyoffice = {
    enable = true;
  };
}

