{
  pkgs,
  inputs,
  asztal,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];

  programs.ags = {
    enable = true;
    configDir = ./ags;
    extraPackages = with pkgs; [gtksourceview webkitgtk accountsservice];
  };

  xdg.desktopEntries."org.gnome.Settings" = {
    name = "Settings";
    comment = "Gnome Control Center";
    icon = "org.gnome.Settings";
    exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome.gnome-control-center}/bin/gnome-control-center";
    categories = ["X-Preferences"];
    terminal = false;
  };

  home.packages = with pkgs; [bun gnome.gnome-control-center];

  systemd.user.services.asztal = {
    Unit = {
      Description = "Ags Shell";
    };
    Install = {
      WantedBy = ["hyprland-session.target"];
    };
    Service = {
      ExecStart = "${asztal}/bin/asztal -b hypr";
      ExecStop = "${asztal}/bin/asztal -q";
    };
  };
}
