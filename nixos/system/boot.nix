{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.system.boot.enable = lib.mkEnableOption "boot";

  config = lib.mkIf config.mine.system.boot.enable {
    boot = {
      # Bootloader.
      # loader.systemd-boot.enable = true;
      loader = {
        timeout = 5;
        efi.canTouchEfiVariables = true;
        # efi.efiSysMountPoint = "/boot/EFI";

        grub = {
          enable = true;
          enableCryptodisk = true;
          device = "nodev";
          efiSupport = true;
          useOSProber = true;
        };
      };

      kernelPackages = pkgs.linuxPackages_latest;
      # kernelPackages = custom-kernel;
      kernelParams = [
        "quiet"
      ];

      # Plymouth
      plymouth = {
        enable = true;
      };

      # Quiet boot
      consoleLogLevel = 0;
      initrd.verbose = false;

      # Use systemd for initramfs rather than udev
      initrd.systemd.enable = true;
    };
  };
}
