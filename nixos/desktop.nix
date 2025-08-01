{
  pkgs,
  inputs,
  ...
}: {
  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      # portalPackage = pkgs.xdg-desktop-portal-hyprland;
      withUWSM = true;
    };

    uwsm.enable = true;
    xwayland.enable = true;
    hyprlock = {
      enable = true;
      package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
    };
    zsh.enable = true;
    fish = {
      enable = true;
      useBabelfish = true;
    };
    fish.vendor = {
      completions.enable = true;
      config.enable = true;
      functions.enable = true;
    };
  };

  # users.defaultUserShell = pkgs.zsh;
  users.defaultUserShell = pkgs.fish;

  # For uwsm
  services.dbus.implementation = "broker";
    xdg.autostart.enable = true;

  # Colorscheme
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "sapphire";
  catppuccin.tty.enable = true;

  programs.nm-applet.enable = true;

  # fix mime list problem
  home-manager = {
    backupFileExtension = "home-manager-backup";
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
