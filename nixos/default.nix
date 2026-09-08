# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  imports = [
    ./hardware-configuration.nix

    ./amdgpu.nix
    ./appimage.nix
    ./automount.nix
    ./bluetooth.nix
    ./boot.nix
    ./cachix.nix
    ./darius.nix
    ./docker.nix
    ./extra-udev.nix
    ./filesystem-index.nix
    ./fingerprint.nix
    ./fonts.nix
    ./fwupd.nix
    ./gc.nix
    ./hyprland.nix
    ./keyboard.nix
    ./locale.nix
    ./man.nix
    ./networking.nix
    ./nix-ld.nix
    ./nix.nix
    ./nixpkgs.nix
    ./ollama.nix
    ./opengl.nix
    ./openssh.nix
    ./polkit.nix
    ./portals.nix
    ./printing.nix
    ./root.nix
    ./seat.nix
    ./security.nix
    ./shells.nix
    ./sound.nix
    ./steam.nix
    ./theme.nix
    ./timesyncd.nix
    ./tlp.nix
    ./tmux.nix
    ./upower.nix
    ./virtualisation.nix
  ];

  networking.hostName = "LeMachine";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
