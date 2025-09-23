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
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };
}
