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
      package = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
      enable32Bit = true;
    };
  };
}
