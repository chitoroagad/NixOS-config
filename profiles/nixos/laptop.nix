{
  config,
  lib,
  ...
}: {
  options.mine.profiles.laptop.enable = lib.mkEnableOption "laptop hardware";

  config = lib.mkIf config.mine.profiles.laptop.enable {
    mine.hardware = {
      bluetooth.enable = lib.mkDefault true;
      fingerprint.enable = lib.mkDefault true;
      fwupd.enable = lib.mkDefault true;
      power.enable = lib.mkDefault true;
      upower.enable = lib.mkDefault true;
    };
  };
}
