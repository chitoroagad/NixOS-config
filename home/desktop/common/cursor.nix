{
  pkgs,
  pkgs-stable,
  ...
}: {
  catppuccin.pointerCursor.enable = false;
  home.pointerCursor = {
    name = "phinger-cursors-light";
    # package = pkgs-stable.${pkgs.system}.phinger-cursors;
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
  };
}
