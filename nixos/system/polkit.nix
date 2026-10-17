{
  config,
  lib,
  ...
}: {
  options.mine.system.polkit.enable = lib.mkEnableOption "polkit";

  config = lib.mkIf config.mine.system.polkit.enable {
    # enable keyring
    services.gnome.gnome-keyring.enable = true;
    # The secrets live in the passwordless "Default" keyring. PAM only manages
    # a "login" keyring, and creates one from whatever password is typed first,
    # typos at the lock screen included. go-keyring clients (supabase) prefer
    # "login" when it exists, so a locked one makes them prompt.
    security.pam.services.login.enableGnomeKeyring = lib.mkForce false;
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
