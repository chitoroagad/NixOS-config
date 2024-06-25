{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./bat.nix
    ./btop.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./neovim.nix
    ./tmux.nix
    ./yazi.nix
    ./zoxide.nix
    ./zsh.nix
    # ./starship.nix
  ];

  home.packages = with pkgs; [
    gcc
    fd
  ];
}
