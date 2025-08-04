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
  };
  # catppuccin.gtk.icon.enable = false;
  # catppuccin.gtk.enable = true;
  # catppuccin.gtk.accent = "sapphire";

  # services.xsettingsd = {
  #   enable = true;
  #   settings = {
  #     "Net/ThemeName" = "Catppuccin-mocha";
  #     "Net/IconThemeName" = "${gtk.iconTheme.name}";
  #   };
  # };
}
