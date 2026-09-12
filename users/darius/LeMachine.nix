# darius on LeMachine.
# `system` is a NixOS module, `home` is a home-manager module. flake.nix feeds
# each to the matching configuration.
{
  system = {
    mine.profiles = {
      dev.enable = true;
      gaming.enable = true;
    };

    mine.services = {
      automount.enable = true;
      locate.enable = true;
      ollama.enable = true;
      openssh.enable = true;
      timesyncd.enable = true;
    };

    mine.desktop = {
      fonts.enable = true;
      hyprland.enable = true;
      portals.enable = true;
      sound.enable = true;
      theme.enable = true;
    };

    mine.programs = {
      appimage.enable = true;
      shells.enable = true;
    };
  };

  home = {
    mine.profiles = {
      desktop.enable = true;
      dev.enable = true;
      gaming.enable = true;
    };

    mine.apps = {
      browsers.enable = true;
      chat.enable = true;
      media.enable = true;
      office.enable = true;
      proton.enable = true;
    };

    mine.cli = {
      fish.enable = true;
      starship.enable = true;
      torrent-script.enable = true;
      zsh.enable = true;
    };

    mine.desktop = {
      dms.island.enable = false;
      extraBluetooth.enable = true;
    };
  };
}
