{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}: {
  options.mine.apps.gaming.enable = lib.mkEnableOption "gaming";

  config = lib.mkIf config.mine.apps.gaming.enable {
    programs.lutris = {
      enable = true;
      protonPackages = [pkgs.proton-ge-bin];
    };
  };
}
