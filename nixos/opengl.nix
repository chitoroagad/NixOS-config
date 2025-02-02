{
  pkgs,
  inputs,
  ...
}: {
  # Enable Opengl and Radeon Open Compute (ROCm)
  hardware = {
    graphics = {
      enable = true;
      # use hyprland version of mesa
      package = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa.drivers;
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
