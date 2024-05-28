{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      them = "Catppuccin Mocha";
    };
    themes = {
      catppuccin-mocha = {
        src = pkgs.fetchurl {
          url = "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme";
          hash = "";
        };
        file = "Catppuccin Mocha.tmTheme";
      };
    };
  };
}
