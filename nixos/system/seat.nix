{
  config,
  lib,
  ...
}: {
  options.mine.system.seat.enable = lib.mkEnableOption "seat" // {default = true;};

  config = lib.mkIf config.mine.system.seat.enable {
    services.seatd.enable = true;
  };
}
