{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    ./ags.nix
    ./cursor.nix
    ./kitty.nix
    ./font.nix
    ./playerctl.nix
    # ./mako.nix
    # ./wofi.nix
    # ./waybar.nix
    ./gtk.nix
    ./qt.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./swww
    ./wlsunset.nix
    # ./wlogout.nix

    ./extraBluetooth.nix
  ];

  home.packages = with pkgs; [
    libnotify
    wl-clipboard
    grim
    slurp
    xdg-utils
    brightnessctl
    qbittorrent
  ];

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = ["gtk"];
        hyprland.default = ["hyprland" "gtk"];
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
      ];
    };

    configFile."mimeapps.list".force = true;
    mimeApps = {
      enable = true;
      associations.added = {
        "video/mp4" = "vlc.desktop";
        "video/mpeg" = "vlc.desktop";
        "video/x-msvideo" = "vlc.desktop";
      };
    };
  };
}
