{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.apps.media.enable = lib.mkEnableOption "media" // {default = true;};

  config = lib.mkIf config.mine.apps.media.enable {
    home.packages = with pkgs; [
      stable.spotify
      vlc
      pavucontrol
      obs-studio
      gimp
    ];
  };
}
