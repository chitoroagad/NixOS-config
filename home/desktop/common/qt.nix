{pkgs, ...}: {
  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme = {
      name = "kvantum";
      package = pkgs.qt6.qtbase;
    };
  };
  catppuccin.kvantum.enable = true;
}
