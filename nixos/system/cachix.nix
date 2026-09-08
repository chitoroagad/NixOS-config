{
  config,
  lib,
  ...
}: {
  options.mine.system.cachix.enable = lib.mkEnableOption "cachix" // {default = true;};

  config = lib.mkIf config.mine.system.cachix.enable {
    nix.settings = {
      substituters = [];
      trusted-public-keys = [];
    };
  };
}
