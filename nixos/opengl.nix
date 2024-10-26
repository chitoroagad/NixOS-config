{pkgs, ...}: {
  # Enable Opengl and Radeon Open Compute (ROCm)
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };

    amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
      amdvlk.enable = true;
    };
  };
}
