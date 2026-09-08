{
  config,
  lib,
  ...
}: {
  options.mine.services.timesyncd.enable = lib.mkEnableOption "timesyncd";

  config = lib.mkIf config.mine.services.timesyncd.enable {
    services.timesyncd.enable = true;
  };
}
