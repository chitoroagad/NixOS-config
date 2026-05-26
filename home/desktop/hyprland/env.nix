{...}: {
  home.sessionVariables = {
    GDK_BACKEND = "wayland,x11,*";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    GTK_USE_PORTAL = "1";
  };

  # Compositor-specific: GPU device selection, only relevant inside Hyprland session
  home.file.".config/uwsm/env-hyprland".text = ''
    export AQ_DRM_DEVICES="/dev/dri/card2:/dev/dri/card1"
  '';
}
