{pkgs, ...}: {
  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme = {
      name = "gtk3";
      package = pkgs.qt6.qtbase;
    };
  };
}
