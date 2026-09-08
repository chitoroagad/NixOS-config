# ppd because its better than tlp on framework 16 atm
{
  config,
  lib,
  ...
}: {
  options.mine.hardware.power.enable = lib.mkEnableOption "power" // {default = true;};

  config = lib.mkIf config.mine.hardware.power.enable {
    services.power-profiles-daemon.enable = true;
  };
}
