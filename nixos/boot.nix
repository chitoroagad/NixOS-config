{pkgs, ...}: {
  boot = {
    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 0;

    # LUKS
    initrd.luks.devices."luks-1ff10d2e-5580-4c23-9efe-60fc2771934b".device = "/dev/disk/by-uuid/1ff10d2e-5580-4c23-9efe-60fc2771934b";

    # Newer kernel
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "quiet"
    ];

    # Plymouth
    plymouth = {
      enable = true;
      # Catppuccin theme enabled in desktop.nix
    };

    # Quiet boot
    consoleLogLevel = 0;
    initrd.verbose = false;

    # Use systemd for initramfs rather than udev
    initrd.systemd.enable = true;
  };
}
