{
  pkgs,
  inputs,
  ...
}: {
  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };

    zsh.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;

  # Colorscheme
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "sapphire";
  console.catppuccin.enable = true;

  # fix mime list problem
  home-manager.backupFileExtension = "home-manager-backup";
}
