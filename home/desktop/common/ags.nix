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
    extraPackages = with pkgs; [gtksourceview webkitgtk_6_0 accountsservice];
  };

  xdg.desktopEntries."org.gnome.Settings" = {
    name = "Settings";
    comment = "Gnome Control Center";
    icon = "org.gnome.Settings";
    exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome-control-center}/bin/gnome-control-center";
    categories = ["X-Preferences"];
    terminal = false;
  };

  home.packages = with pkgs; [gnome-control-center];

  systemd.user.services.asztal = {
    Unit = {
      Description = "Ags Shell";
      After = "graphical-session.target";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
    Service = {
      Type = "exec";
      # ExecCondition = "ExecCondition=${pkgs.systemd}/lib/systemd/systemd-xdg-autostart-condition \"Hyprland\" \"\" ";
      ExecStart = "${asztal}/bin/asztal -b hypr";
      ExecStop = "${asztal}/bin/asztal -q";
      Restart = "on-failure";
      Slice = "background-graphical.slice";
    };
  };
}
