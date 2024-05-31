{pkgs, ...}: {
  programs.hyprland.enable = true;
  programs = {
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
