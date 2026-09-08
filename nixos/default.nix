# Every NixOS component module. Each declares mine.<group>.<name>.enable;
# hosts and users decide which are on.
{
  imports = [
    ../profiles/nixos
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
}
