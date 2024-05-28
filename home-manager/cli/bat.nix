{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
    };
    # themes = {
    #   catppuccin-mocha = {
    #     src = pkgs.fetchurl {
    #       url = "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme";
    #       hash = "sha256-UDJ6FlLzwjtLXgyar4Ld3w7x3/zbbBfYLttiNDe4FGY=";
    #     };
    #     file = "Catppuccin Mocha.tmTheme";
    #   };
    # };
  };
}
