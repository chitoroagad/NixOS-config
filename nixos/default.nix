# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  imports = [
    ./hardware-configuration.nix
    ./darius.nix

    ./hardware/bluetooth.nix
    ./hardware/fingerprint.nix
    ./hardware/fwupd.nix
    ./hardware/graphics.nix
    ./hardware/keyboard.nix
    ./hardware/power.nix
    ./hardware/printing.nix
    ./hardware/rocm.nix
    ./hardware/udev.nix
    ./hardware/upower.nix

    ./system/boot.nix
    ./system/cachix.nix
    ./system/gc.nix
    ./system/locale.nix
    ./system/networking.nix
    ./system/nix.nix
    ./system/nixpkgs.nix
    ./system/packages.nix
    ./system/polkit.nix
    ./system/seat.nix
    ./system/security.nix

    ./services/automount.nix
    ./services/docker.nix
    ./services/locate.nix
    ./services/ollama.nix
    ./services/openssh.nix
    ./services/timesyncd.nix
    ./services/tmux.nix

    ./desktop/fonts.nix
    ./desktop/hyprland.nix
    ./desktop/portals.nix
    ./desktop/sound.nix
    ./desktop/theme.nix

    ./programs/appimage.nix
    ./programs/man.nix
    ./programs/nix-ld.nix
    ./programs/shells.nix
    ./programs/steam.nix
    ./programs/virtualisation.nix
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
