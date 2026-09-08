{
  config,
  lib,
  pkgs,
  ...
}: let
  wallpaper = pkgs.wbg;
  exe = "${lib.getExe pkgs.wbg} --stretch";
  image = ./mountain_sun_purple.jpg;
in {
  options.mine.desktop.wallpaper.enable = lib.mkEnableOption "wallpaper";

  config = lib.mkIf config.mine.desktop.wallpaper.enable {
    home.packages = [wallpaper];
    systemd.user.services.wallpaper = {
      Unit = {
        Description = "wallpaper daemon";
        After = "graphical-session.target";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
      Service = {
        Type = "exec";
        ExecStart = "${exe} ${image}";
        Restart = "on-failure";
        TimeoutStopSec = "5s";
        Slice = "background-graphical.slice";
      };
    };
  };
}
