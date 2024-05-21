{config, ...}: {
  services.mako = {
    enable = true;
    # iconPath = "${config.gtk.iconTheme.package}/share/icons/Candy-Icons";
    font = "${config.fontProfiles.regular.family}";
    padding = "10,20";
    defaultTimeout = 10000;
    layer = "overlay";
  };
}
