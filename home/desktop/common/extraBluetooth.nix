{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.desktop.extraBluetooth.enable = lib.mkEnableOption "extraBluetooth";

  config = lib.mkIf config.mine.desktop.extraBluetooth.enable {
    services = {
      mpris-proxy.enable = true;
      mpd-mpris.enable = true;
    };
  };
}
