{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./neovim.nix
    ./zsh.nix
    # ./starship.nix
  ];

  home.packages = with pkgs; [
    gcc
    fd
  ];
}
