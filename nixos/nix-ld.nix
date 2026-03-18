{
  pkgs,
  options,
  ...
}: {
  programs.nix-ld = {
    enable = true;
    libraries =
      options.programs.nix-ld.libraries.default
      ++ [
        pkgs.glib
        pkgs.mesa
      ];
  };
}
