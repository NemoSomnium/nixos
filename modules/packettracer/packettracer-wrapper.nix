{ pkgs }:

let
  packetTracerPath = "${pkgs.ciscoPacketTracer8}/opt/pt";
in
pkgs.writeShellScriptBin "packettracer" ''
  export PT8HOME=${packetTracerPath}
  export LD_LIBRARY_PATH=$PT8HOME/lib:$LD_LIBRARY_PATH
  export QT_PLUGIN_PATH=${pkgs.qt5.qtbase.outPath}/${pkgs.qt5.qtbase.qtPluginPrefix}:$QT_PLUGIN_PATH
  exec $PT8HOME/bin/PacketTracer "$@"
''

