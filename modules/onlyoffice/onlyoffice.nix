{ config, pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (pkgs.culmus.override { fonts = [ "David" "FrankRuehl" "Miriam" "Narkisim" ]; })
    ];
  };

  services.onlyoffice = {
    enable = true;
  };
}

