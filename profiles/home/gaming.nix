{
  config,
  lib,
  ...
}: {
  options.mine.profiles.gaming.enable = lib.mkEnableOption "gaming";

  config = lib.mkIf config.mine.profiles.gaming.enable {
    mine.apps.gaming.enable = lib.mkDefault true;
  };
}
