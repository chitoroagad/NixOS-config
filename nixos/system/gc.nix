{
  config,
  lib,
  ...
}: {
  options.mine.system.gc.enable = lib.mkEnableOption "gc";

  config = lib.mkIf config.mine.system.gc.enable {
    nix.gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      randomizedDelaySec = "14m";
      options = "--delete-older-than 14d";
    };
  };
}
