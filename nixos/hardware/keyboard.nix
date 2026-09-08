{
  config,
  lib,
  ...
}: {
  options.mine.hardware.keyboard.enable = lib.mkEnableOption "keyboard" // {default = true;};

  config = lib.mkIf config.mine.hardware.keyboard.enable {
    hardware.keyboard.qmk.enable = true;
  };
}
