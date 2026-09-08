{
  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "weekly";
    randomizedDelaySec = "14m";
    options = "--delete-older-than 14d";
  };
}
