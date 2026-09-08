{
  config,
  lib,
  pkgs,
  ...
}: let
  uwsm = lib.getExe pkgs.uwsm;
  uwsmPrefix = "${uwsm} app -- ";
in {
  options.mine.desktop.hyprlauncher.enable = lib.mkEnableOption "hyprlauncher" // {default = true;};

  config = lib.mkIf config.mine.desktop.hyprlauncher.enable {
    services.hyprlauncher = {
      enable = true;
      settings = {
        desktop_launch_prefix = uwsmPrefix;
        window_size = "1000.0 400.0";
      };
    };
  };
}
