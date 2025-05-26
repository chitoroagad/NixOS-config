{
  pkgs,
  inputs,
  lib,
  ...
}: let
  # swww = inputs.swww.packages.${pkgs.system}.swww;
  swww = pkgs.swww;
in {
  home.packages = [swww];
  systemd.user.services.swww = {
    Unit = {
      Description = "swww wallpaper daemon";
    };
    Install = {
      WantedBy = ["hyprland-session.target"];
    };
    Service = {
      ExecStart = "${lib.getExe' swww "swww-daemon"}";
      ExecStop = "${lib.getExe swww} kill";
      TimeoutStopSec = "5s";
    };
  };
}
