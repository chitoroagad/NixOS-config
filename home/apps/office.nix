{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.apps.office.enable = lib.mkEnableOption "office" // {default = true;};

  config = lib.mkIf config.mine.apps.office.enable {
    home.packages = with pkgs; [
      stable.libreoffice
    ];
  };
}
