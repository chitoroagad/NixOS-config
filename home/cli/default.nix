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
    ./ghostty.nix
    ./git.nix
    ./nh.nix
    ./nix-direnv.nix
    ./nvim
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
