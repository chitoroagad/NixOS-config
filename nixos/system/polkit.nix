{
  config,
  lib,
  ...
}: {
  options.mine.system.polkit.enable = lib.mkEnableOption "polkit";

  config = lib.mkIf config.mine.system.polkit.enable {
    # enable keyring
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;
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
  };
}
