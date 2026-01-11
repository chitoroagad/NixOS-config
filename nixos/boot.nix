{
  pkgs,
  inputs,
  ...
}: let
  helpers = pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" {};
  cachy-kernel-lto-bmq-zen4 = helpers.kernelModuleLLVMOverride (
    pkgs.linuxPackagesFor (
      pkgs.cachyosKernels.linux-cachyos-latest-lto-zen4.override {
        pname = "cachy-kernel-lto-bmq-zen4";
        cpusched = "bmq";
      }
    )
  );
in {
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

    # kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = cachy-kernel-lto-bmq-zen4;
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
}
