{pkgs,...}:{
  programs.distrobox = {
    enable = true;
    package = pkgs.stable.distrobox;
  };
}
