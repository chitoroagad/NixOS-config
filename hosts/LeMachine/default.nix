# LeMachine — Framework 16, AMD 7040 series.
# Machine-scoped settings and hardware toggles. Anything that belongs to a
# person rather than the machine lives in users/<name>/LeMachine.nix.
{
  imports = [./hardware.nix];

  networking.hostName = "LeMachine";

  mine.hardware = {
    bluetooth.enable = true;
    fingerprint.enable = true;
    fwupd.enable = true;
    graphics.enable = true;
    keyboard.enable = true;
    power.enable = true;
    printing.enable = true;
    rocm.enable = true;
    udev.enable = true;
    upower.enable = true;
  };

  mine.system = {
    boot.enable = true;
    cachix.enable = true;
    gc.enable = true;
    locale.enable = true;
    networking.enable = true;
    nix.enable = true;
    nixpkgs.enable = true;
    packages.enable = true;
    polkit.enable = true;
    seat.enable = true;
    security.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
