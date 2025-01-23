{pkgs, ...}: {
  programs.btop = {
    enable = true;
    package = pkgs.stable.btop.override {rocmSupport = true;};
  };
}
