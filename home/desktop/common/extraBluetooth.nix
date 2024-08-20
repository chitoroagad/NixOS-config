{pkgs, ...}: {
  services = {
    mpris-proxy.enable = true;
    mpd-mpris.enable = true;
  };
}
