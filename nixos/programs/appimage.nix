{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.programs.appimage.enable = lib.mkEnableOption "appimage" // {default = true;};

  config = lib.mkIf config.mine.programs.appimage.enable {
    programs.appimage.enable = true;
    programs.appimage.binfmt = true;
  };
}
