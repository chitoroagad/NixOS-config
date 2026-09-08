{
  pkgs,
  lib,
  ...
}: let
  uwsm = lib.getExe pkgs.uwsm;
  uwsmPrefix = "${uwsm} app -- ";
in {
  services.hyprlauncher = {
    enable = true;
    settings = {
      desktop_launch_prefix = uwsmPrefix;
      window_size = "1000.0 400.0";
    };
  };
}
