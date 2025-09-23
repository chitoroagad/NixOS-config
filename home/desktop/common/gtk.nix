{
  config,
  pkgs,
  lib,
  ...
}: {
  gtk = {
    enable = true;
    font = {
      name = config.fontProfiles.regular.family;
      size = 12;
    };

    iconTheme = lib.mkDefault {
      name = "Papirus";
      package = pkgs.stable.papirus-icon-theme;
    };

    theme = {
      name = "Catppuccin-GTK-Dark";
      package = pkgs.magnetic-catppuccin-gtk;
    };
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = "Catppuccin-mocha";
      "Net/IconThemeName" = "${config.gtk.iconTheme.name}";
    };
  };
}
