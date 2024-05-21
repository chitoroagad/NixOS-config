{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    gcc
    fd
  ];
}
