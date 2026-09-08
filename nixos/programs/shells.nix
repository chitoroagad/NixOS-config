{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.programs.shells.enable = lib.mkEnableOption "shells" // {default = true;};

  config = lib.mkIf config.mine.programs.shells.enable {
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
  };
}
