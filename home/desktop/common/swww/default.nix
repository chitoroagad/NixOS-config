{
  pkgs,
  inputs,
  lib,
  ...
}: let
  swww = pkgs.swww;
in {
  home.packages = [swww];
  systemd.user.services.swww = {
    Unit = {
      Description = "swww wallpaper daemon";
      After = "graphical-session.target";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
    Service = {
      Type = "exec";
      ExecCondition = "${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"Hyprland\" \"\"";
      ExecStart = "${lib.getExe' swww "swww-daemon"}";
      ExecStop = "${lib.getExe swww} kill";
      Restart = "on-failure";
      TimeoutStopSec = "5s";
      Slice = "background-graphical.slice";
    };
  };
}
