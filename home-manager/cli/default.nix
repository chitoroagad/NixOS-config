{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./neovim.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    gcc
    fd
  ];
}
