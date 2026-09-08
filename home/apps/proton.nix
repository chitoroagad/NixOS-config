{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.apps.proton.enable = lib.mkEnableOption "proton" // {default = true;};

  config = lib.mkIf config.mine.apps.proton.enable {
    home.packages = with pkgs; [
      proton-vpn
      proton-pass
    ];
  };
}
