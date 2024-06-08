{
  pkgs,
  lib,
  ...
}: let
  # Radeon 7700S
  gpuIDs = [
    "1002:7480" # Graphics
    "1002:ab30" # Audio
  ];
in {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };
    spiceUSBRedirection.enable = true;
    podman.enable = true;
  };

  programs.virt-manager.enable = true;

  boot.kernelParams = ["amd_iommu=on"] ++ [("vfio-pic.ids=" + lib.concatStringsSep "," gpuIDs)];
  boot.initrd.kernelModules = [
    "vfio_pci"
    "vfio"
  ];
}
