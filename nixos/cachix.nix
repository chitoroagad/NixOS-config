{
  # Enabel cachix to not compile hyprland
  nix.settings = {
    substituters = [];
    trusted-public-keys = [];
  };
}
