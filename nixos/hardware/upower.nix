{
  config,
  lib,
  ...
}: {
  options.mine.hardware.upower.enable = lib.mkEnableOption "upower";

  config = lib.mkIf config.mine.hardware.upower.enable {
    services.upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 5;
      percentageAction = 2;
      criticalPowerAction = "PowerOff";
    };
  };
}
