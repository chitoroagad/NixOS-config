{pkgs, ...}: {
  programs = {
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
}
