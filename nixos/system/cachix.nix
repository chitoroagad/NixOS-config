{
  config,
  lib,
  ...
}: {
  options.mine.system.cachix.enable = lib.mkEnableOption "cachix";

  config = lib.mkIf config.mine.system.cachix.enable {
    nix.settings = {
      substituters = [];
      trusted-public-keys = [];
    };
  };
}
