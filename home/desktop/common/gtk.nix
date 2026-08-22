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

    theme = {
      name = "catppuccin-mocha-blue-compact-black";
      package = pkgs.catppuccin-gtk.override {
        accents = ["blue"];
        size = "compact";
        tweaks = ["black"];
        variant = "mocha";
      };
    };

    gtk4.theme = config.gtk.theme;
  };

  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = "Catppuccin-mocha";
      "Net/IconThemeName" = "${config.gtk.iconTheme.name}";
    };
  };
}
