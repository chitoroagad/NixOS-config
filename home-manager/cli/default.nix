{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./neovim.nix
    ./zsh.nix
    ./fzf.nix
    ./tmux.nix
    ./bat.nix
    ./eza.nix
    ./zoxide.nix
    ./yazi.nix
    ./git.nix
    # ./starship.nix
  ];

  home.packages = with pkgs; [
    gcc
    fd
  ];
}
