{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];

  programs.ags = {
    enable = true;
    extraPackages = with pkgs; [gtksourceview webkitgtk accountsservice];
  };
}
