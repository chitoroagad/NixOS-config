{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.desktop.fonts.enable = lib.mkEnableOption "fonts" // {default = true;};

  config = lib.mkIf config.mine.desktop.fonts.enable {
    fonts = {
      enableDefaultPackages = true;
      enableGhostscriptFonts = true;
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        fira
      ];
      fontconfig = {
        defaultFonts = {
          monospace = ["JetBrainsMono Nerd Font"];
        };
      };
    };
  };
}
