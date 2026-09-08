{
  config,
  lib,
  ...
}: {
  options.mine.hardware.fwupd.enable = lib.mkEnableOption "fwupd";

  config = lib.mkIf config.mine.hardware.fwupd.enable {
    services.fwupd = {
      enable = true;
      # extraRemotes = ["lvfs-testing"];
    };
  };
}
