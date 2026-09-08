{pkgs, ...}: {
  home.packages = with pkgs; [
    slack
    discord
    webcord
    zoom-us
  ];
}
