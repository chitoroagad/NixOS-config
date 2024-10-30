{pkgs, ...}: {
  qt = {
    enable = true;
    style.name = "kvantum";
    style.catppuccin.enable = true;
    platformTheme = {
      name = "kvantum";
      package = pkgs.qt6.qtbase;
    };
  };
}
