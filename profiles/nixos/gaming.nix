{
  config,
  lib,
  ...
}: {
  options.mine.profiles.gaming.enable = lib.mkEnableOption "gaming";

  config = lib.mkIf config.mine.profiles.gaming.enable {
    mine.programs.steam.enable = lib.mkDefault true;
    mine.hardware.graphics.enable = lib.mkDefault true;
  };
}
