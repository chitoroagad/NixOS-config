{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.cli.tools.enable = lib.mkEnableOption "tools";

  config = lib.mkIf config.mine.cli.tools.enable {
    home.packages = with pkgs; [
      fastfetch
      python3

      # archives
      zip
      unzip
      rar
      xz

      # utils
      ripgrep
      jq
      eza
      fzf
      file

      # misc
      which
      trash-cli
      tldr
      cachix
      gh
      tree-sitter
      pi-coding-agent
      nodejs # provides npm for `pi install npm:...`

      # sys tools
      pciutils
      usbutils
    ];
  };
}
