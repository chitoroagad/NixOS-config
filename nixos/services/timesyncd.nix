{
  config,
  lib,
  ...
}: {
  options.mine.services.timesyncd.enable = lib.mkEnableOption "timesyncd" // {default = true;};

  config = lib.mkIf config.mine.services.timesyncd.enable {
    services.timesyncd.enable = true;
  };
}
