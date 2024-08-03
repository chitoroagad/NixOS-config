{config, ...}: {
  services.mako = {
    enable = true;
    font = "${config.fontProfiles.regular.family}";
    padding = "10,20";
    defaultTimeout = 1000;
    layer = "overlay";
  };
}
