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

  systemd.user.services.asztal = {
    Unit = {
      Description = "Ags Shell";
    };
    Install = {
      WantedBy = ["hyprland-session.target"];
    };
    Service = {
      ExecStart = "${asztal}/bin/asztal";
      ExecStop = "${asztal}/bin/asztal -q";
    };
  };
}
