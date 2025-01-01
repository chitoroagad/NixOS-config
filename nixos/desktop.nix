{
  pkgs,
  inputs,
  ...
}: {
  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    xwayland.enable = true;
    hyprlock = {
      enable = true;
      package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
    };
    zsh.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;

  # Colorscheme
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "sapphire";
  catppuccin.tty.enable = true;

  # fix mime list problem
  home-manager = {
    backupFileExtension = "home-manager-backup";
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
