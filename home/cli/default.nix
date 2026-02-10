{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./fish.nix
    ./ghostty.nix
    ./git.nix
    ./nvim
    ./tmux.nix
    ./yazi.nix
    ./zsh.nix
    ./starship.nix
    ./torrent-script.nix
  ];

  programs.distrobox.enable = true;
  programs.bat.enable = true;
  programs.nh.enable = true;
  programs.nix-index.enable = true;
  programs.zoxide.enable = true;

  programs.btop = {
    enable = true;
    package = pkgs.btop.override {rocmSupport = true;};
  };

  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
  };

  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--height 40%"
    ];
  };

  programs.ghostty = {
    enable = true;
    # package = inputs.ghostty.packages.${pkgs.system}.ghostty;
    installBatSyntax = true;
    installVimSyntax = true;
  };

  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
  };
}
