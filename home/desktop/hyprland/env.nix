{config, ...}: {
  home.file.".config/uwsm/env".text = ''
      export  GDK_BACKEND="wayland,x11,*"
      export  SDL_VIDEODRIVER="wayland"
      export  CLUTTER_BACKEND="wayland"

      export  QT_AUTO_SCREEN_SCALE_FACTOR="1"
      export  QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export  QT_QPA_PLATFORM="wayland;xcb"
    '';

  home.file.".config/uwsm/env-hyprland".text = ''
      export AQ_DRM_DEVICES="/dev/dri/card2:/dev/dri/card1"
    '';

}


