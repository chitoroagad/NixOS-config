{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./dms.nix
    ./extraBluetooth.nix
    ./kitty.nix
  ];

  options.mine.desktop.base.enable = lib.mkEnableOption "desktop base" // {default = true;};

  config = lib.mkIf config.mine.desktop.base.enable {
    home.packages = with pkgs; [
      libnotify
      wl-clipboard
      grim
      slurp
      xdg-utils
      brightnessctl
      qbittorrent
      # way-shell.packages.${pkgs.system}.default
    ];

    dconf.enable = true;
    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    services.cliphist.enable = true;

    xdg = {
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-hyprland
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
  };
}
