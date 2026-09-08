{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.theming.qt.enable = lib.mkEnableOption "qt";

  config = lib.mkIf config.mine.theming.qt.enable {
    qt = {
      enable = true;
      style.name = "kvantum";
      platformTheme = {
        name = "kvantum";
        package = pkgs.qt6.qtbase;
      };
    };
    catppuccin.kvantum.enable = true;
  };
}
