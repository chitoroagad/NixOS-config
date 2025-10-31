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
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };
  };
}
