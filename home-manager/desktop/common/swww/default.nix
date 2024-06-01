{
  pkgs,
  inputs,
  lib,
  ...
}: let
  swww = inputs.swww.packages.${pkgs.system}.swww;
in {
  home.packages = [swww];
  systemd.user.services.swww = {
    description = "swww daemon";
    wantedBy = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    serviceConfig = {
      ExecStart = "${lib.getExe swww "swww-daemon"}";
    };
  };
}
