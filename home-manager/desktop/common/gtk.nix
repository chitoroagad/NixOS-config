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
      package = pkgs.papirus-icon-theme;
    };

    catppuccin.cursor.enable = false;
    catppuccin.enable = true;
  };

  # services.xsettingsd = {
  #   enable = true;
  #   settings = {
  #     "Net/ThemeName" = "Catppuccin-mocha";
  #     "Net/IconThemeName" = "${gtk.iconTheme.name}";
  #   };
  # };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
}
