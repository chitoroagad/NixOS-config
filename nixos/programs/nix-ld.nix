{
  config,
  lib,
  options,
  pkgs,
  ...
}: {
  options.mine.programs.nix-ld.enable = lib.mkEnableOption "nix-ld" // {default = true;};

  config = lib.mkIf config.mine.programs.nix-ld.enable {
    programs.nix-ld = {
      enable = true;
      libraries =
        options.programs.nix-ld.libraries.default
        ++ [
          pkgs.glib
          pkgs.mesa
        ];
    };
  };
}
