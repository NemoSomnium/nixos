{ pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    python3Packages = pkgs.python3Packages.override {
      overrides = python-self: python-super: {
        aiohttp = python-super.aiohttp.overrideAttrs (oldAttrs: {
          doCheck = false;
        });
      };
    };
  };
}

