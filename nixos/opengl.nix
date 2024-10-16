{pkgs, ...}: {
  # Enable Opengl and Radeon Open Compute (ROCm)
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
        # amdvlk # Use AMD Vulkan drivers as needed
        vaapiVdpau
        libvdpau-va-gl
      ];
    };

    amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
      # amdvlk.enable = true;
    };
  };
}
