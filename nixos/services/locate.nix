{
  config,
  lib,
  ...
}: {
  options.mine.services.locate.enable = lib.mkEnableOption "locate" // {default = true;};

  config = lib.mkIf config.mine.services.locate.enable {
    services.locate = {
      enable = true;
      # package = pkgs.plocate;
    };
  };
}
