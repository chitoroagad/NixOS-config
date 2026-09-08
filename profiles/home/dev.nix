{
  config,
  lib,
  ...
}: {
  options.mine.profiles.dev.enable = lib.mkEnableOption "development";

  config = lib.mkIf config.mine.profiles.dev.enable {
    mine.cli = {
      base.enable = lib.mkDefault true;
      claude.enable = lib.mkDefault true;
      git.enable = lib.mkDefault true;
      nvim.enable = lib.mkDefault true;
      tmux.enable = lib.mkDefault true;
      tools.enable = lib.mkDefault true;
      yazi.enable = lib.mkDefault true;
    };
  };
}
