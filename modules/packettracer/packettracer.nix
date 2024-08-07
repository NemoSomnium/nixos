{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.packettracer;
  packetTracerWrapper = pkgs.callPackage ./packettracer-wrapper.nix {};
in {
  options.programs.packettracer = {
    enable = mkEnableOption "Cisco Packet Tracer";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ciscoPacketTracer8
      packetTracerWrapper
      qt5.qtbase
      qt5.qtscript
      qt5.qtwebsockets
      qt5.qtmultimedia
      qt5.qtsvg
      libGL
    ];

    environment.sessionVariables = {
      QT_PLUGIN_PATH = "${pkgs.qt5.qtbase}/${pkgs.qt5.qtbase.qtPluginPrefix}";
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH";
    };

    environment.shellInit = ''
      export PT8HOME=${pkgs.ciscoPacketTracer8}/opt/pt
    '';
  };
}

