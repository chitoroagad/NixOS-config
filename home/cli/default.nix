{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./claude.nix
    ./fish.nix
    ./git.nix
    ./nvim
    ./tmux.nix
    ./yazi.nix
    ./zsh.nix
    ./starship.nix
    ./tools.nix
    ./torrent-script.nix
  ];

  options.mine.cli.base.enable = lib.mkEnableOption "cli base tools";

  config = lib.mkIf config.mine.cli.base.enable {
    programs.distrobox.enable = true;
    programs.bat.enable = true;
    programs.nh.enable = true;
    programs.nix-index.enable = true;
    programs.zoxide.enable = true;
    # catppuccin module still writes tui.json, which OpenCode 2 ignores
    catppuccin.opencode.enable = false;
    programs.opencode = {
      enable = true;
      context = ./AGENTS.md;
      cli.theme = {
        name = "catppuccin";
        mode = "dark";
      };
    };

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

    programs.direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
  };
}
