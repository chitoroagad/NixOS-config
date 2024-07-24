{pkgs, ...}: {
  # Enable Opengl and Radeon Open Compute (ROCm)
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
        amdvlk # Use AMD Vulkan drivers as needed
        vaapiVdpau
        libvdpau-va-gl
      ];
      # driSupport = true;
      # driSupport32Bit = true;
    };
  };
}
