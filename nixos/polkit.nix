{pkgs, ...}: {
  # auth-agent
  services.hyprpolkitagent.enable = true;

  # enable keyring
  services.gnome.gnome-keyring.enable = true;
  services.gnome.glib-networking.enable = true;

  programs.gnupg.agent.enable = true;

  # enable and configure polkit
  security.polkit = {
    enable = true;

    # automount drives
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (
          subject.isInGroup("wheel")
          && (/^org\.freedesktop\.udisks\./.test(action.id)
          ))
            { return polkit.Result.YES; }
      });
    '';
  };
}
