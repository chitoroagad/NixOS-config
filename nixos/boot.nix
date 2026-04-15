{
  pkgs,
  # inputs,
  ...
}: let
  # helpers = pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" {};
  # custom-kernel = helpers.kernelModuleLLVMOverride (pkgs.linuxPackagesFor (pkgs.cachyosKernels.linux-cachyos-latest-lto-zen4.override {
  #   pname = "linux-cachy-custom";
  #   audofdo = true;
  #   cpusched = "bmq";
  #   bbr3 = true;
  #   acpiCall = true;
  # }));
  custom-kernel = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-zen4;
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
    kernelPackages = custom-kernel;
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
