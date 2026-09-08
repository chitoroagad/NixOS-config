{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.apps.browsers.enable = lib.mkEnableOption "browsers";

  config = lib.mkIf config.mine.apps.browsers.enable {
    home.packages = with pkgs; [
      brave
      google-chrome
      firefox
    ];
  };
}
