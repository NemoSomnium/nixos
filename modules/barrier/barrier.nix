# barrier.nix
{ config, lib, pkgs, ... }:

let
  barrierOld = pkgs.barrier.overrideAttrs (oldAttrs: rec {
    version = "2.3.4";
    src = pkgs.fetchFromGitHub {
      owner = "debauchee";
      repo = "barrier";
      rev = "v${version}";
      sha256 = "1xz0xfdscjkil3n703pzysinybh3vvxmi506zvy84l3g8cwa513m";
    };
    # Disable building tests
    cmakeFlags = oldAttrs.cmakeFlags or [] ++ [
      "-DBARRIER_BUILD_TESTS=OFF"
    ];
    # Remove test-related build inputs if any
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [
      pkgs.removeReferencesTo
    ];
    buildInputs = (oldAttrs.buildInputs or []) ++ [
      pkgs.xorg.libX11
      pkgs.xorg.libXtst
      pkgs.xorg.libXrandr
      pkgs.xorg.libXinerama
      pkgs.xorg.libXi
      pkgs.avahi
      pkgs.curl
      pkgs.openssl
    ];
    # Remove test-related phases if any
    postInstall = (oldAttrs.postInstall or "") + ''
      remove-references-to -t ${pkgs.stdenv.cc.cc} $out/bin/barrier
    '';
    # Remove test directories
    preConfigure = ''
      rm -rf src/test
    '';
  });
in
{
  options.programs.barrier = {
    enable = lib.mkEnableOption "Barrier";
  };

  config = lib.mkIf config.programs.barrier.enable {
    home-manager.users.noams.home.packages = [ barrierOld ];
  };
}

