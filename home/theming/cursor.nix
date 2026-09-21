{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.theming.cursor.enable = lib.mkEnableOption "cursor";

  config = lib.mkIf config.mine.theming.cursor.enable {
    catppuccin.cursors.enable = false;
    home.pointerCursor = {
      enable = true;
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 32;
      gtk.enable = true;
    };
  };
}
