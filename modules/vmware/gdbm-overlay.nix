{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      gdbm = super.gdbm.overrideAttrs (oldAttrs: rec {
        configureFlags = lib.optionalAttrs (oldAttrs ? configureFlags) (oldAttrs.configureFlags or []) ++ [
          "--disable-static"
          "--enable-libgdbm-compat"
        ];

        # Remove the problematic --docdir flag
        preConfigure = lib.optionalString (oldAttrs ? preConfigure) (oldAttrs.preConfigure or "") + ''
          sed -i '/--docdir/d' configure
        '';
      });
    })
  ];
}

