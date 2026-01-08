{
  pkgs,
  lib,
  ...
}: let
  wallpaper = pkgs.wbg;
  exe = "${lib.getExe pkgs.wbg} --stretch";
  image = ./aesthetic_deer.png;
in {
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
}
