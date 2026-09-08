{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  options.mine.hardware.graphics.enable = lib.mkEnableOption "graphics" // {default = true;};

  config = lib.mkIf config.mine.hardware.graphics.enable {
    hardware = {
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          libva-vdpau-driver
          libvdpau-va-gl
        ];
      };
    };
  };
}
