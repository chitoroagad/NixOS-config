{pkgs, ...}: {
  home.packages = with pkgs; [
    fastfetch

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

    # sys tools
    pciutils
    usbutils
    nmap
  ];
}
