{pkgs, ...}: {
  home.packages = with pkgs; [
    stable.spotify
    vlc
    pavucontrol
    obs-studio
    gimp
  ];
}
