{
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };

    uwsm.enable = true;
    xwayland.enable = true;
    hyprlock.enable = true;
  };

  # For uwsm
  services.dbus.implementation = "broker";
  xdg.autostart.enable = true;
}
