{
  pkgs,
  inputs,
  ...
}: {
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
