# darius on LeMachine.
# `system` is a NixOS module, `home` is a home-manager module. flake.nix feeds
# each to the matching configuration.
{
  system = {
    mine.services = {
      automount.enable = true;
      docker.enable = true;
      locate.enable = true;
      ollama.enable = true;
      openssh.enable = true;
      timesyncd.enable = true;
      tmux.enable = true;
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
      man.enable = true;
      nix-ld.enable = true;
      shells.enable = true;
      steam.enable = true;
      virtualisation.enable = true;
    };
  };

  home = {
    mine.apps = {
      browsers.enable = true;
      chat.enable = true;
      gaming.enable = true;
      media.enable = true;
      office.enable = true;
      proton.enable = true;
    };

    mine.cli = {
      base.enable = true;
      claude.enable = true;
      fish.enable = true;
      git.enable = true;
      nvim.enable = true;
      starship.enable = true;
      tmux.enable = true;
      tools.enable = true;
      torrent-script.enable = true;
      yazi.enable = true;
      zsh.enable = true;
    };

    mine.desktop = {
      base.enable = true;
      dms.enable = true;
      env.enable = true;
      extraBluetooth.enable = true;
      hypridle.enable = true;
      hyprlauncher.enable = true;
      hyprlock.enable = true;
      hyprland.enable = true;
      kitty.enable = true;
      wallpaper.enable = true;
    };

    mine.theming = {
      cursor.enable = true;
      fonts.enable = true;
      gtk.enable = true;
      qt.enable = true;
    };
  };
}
