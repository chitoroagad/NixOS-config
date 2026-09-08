{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.apps.chat.enable = lib.mkEnableOption "chat";

  config = lib.mkIf config.mine.apps.chat.enable {
    home.packages = with pkgs; [
      slack
      discord
      webcord
      zoom-us
    ];
  };
}
