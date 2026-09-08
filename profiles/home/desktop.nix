{
  config,
  lib,
  ...
}: {
  options.mine.profiles.desktop.enable = lib.mkEnableOption "the hyprland desktop";

  config = lib.mkIf config.mine.profiles.desktop.enable {
    mine.desktop = {
      base.enable = lib.mkDefault true;
      dms.enable = lib.mkDefault true;
      env.enable = lib.mkDefault true;
      hypridle.enable = lib.mkDefault true;
      hyprland.enable = lib.mkDefault true;
      hyprlauncher.enable = lib.mkDefault true;
      hyprlock.enable = lib.mkDefault true;
      kitty.enable = lib.mkDefault true;
      wallpaper.enable = lib.mkDefault true;
    };

    mine.theming = {
      cursor.enable = lib.mkDefault true;
      fonts.enable = lib.mkDefault true;
      gtk.enable = lib.mkDefault true;
      qt.enable = lib.mkDefault true;
    };
  };
}
