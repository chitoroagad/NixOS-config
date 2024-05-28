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
    # ./starship.nix
  ];

  home.packages = with pkgs; [
    gcc
    fd
  ];
}
