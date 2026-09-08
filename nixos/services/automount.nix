{
  config,
  lib,
  ...
}: {
  options.mine.services.automount.enable = lib.mkEnableOption "automount" // {default = true;};

  config = lib.mkIf config.mine.services.automount.enable {
    services = {
      gvfs.enable = true;
      udisks2.enable = true;
      devmon.enable = true;
    };
  };
}
