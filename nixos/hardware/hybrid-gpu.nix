# Stable names for the two GPUs: cardN follows probe order (simpledrm grabs
# card0 early and shifts the rest), and the by-path links contain colons, which
# AQ_DRM_DEVICES uses as its separator.
{
  config,
  lib,
  ...
}: {
  options.mine.hardware.hybridGpu.enable = lib.mkEnableOption "/dev/dri/igpu and /dev/dri/dgpu symlinks";

  config = lib.mkIf config.mine.hardware.hybridGpu.enable {
    # boot_vga marks the GPU the firmware lit the console with, the iGPU on a laptop.
    services.udev.extraRules = ''
      SUBSYSTEM=="drm", KERNEL=="card*", ENV{DEVTYPE}=="drm_minor", ATTRS{boot_vga}=="1", SYMLINK+="dri/igpu"
      SUBSYSTEM=="drm", KERNEL=="card*", ENV{DEVTYPE}=="drm_minor", ATTRS{boot_vga}=="0", SYMLINK+="dri/dgpu"
    '';
  };
}
