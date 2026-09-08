{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.theming.fonts.enable = lib.mkEnableOption "fonts" // {default = true;};

  config = lib.mkIf config.mine.theming.fonts.enable {
    fontProfiles = {
      enable = true;
      monospace = {
        family = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
        # package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
      };
      regular = {
        family = "Fira Sans";
        package = pkgs.fira;
      };
    };
  };
}
