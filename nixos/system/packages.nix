{pkgs, ...}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bash
    curl
    git
    neovim
    nvtopPackages.amd
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
