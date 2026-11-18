# Console autologin for LUKS-encrypted systems: the passphrase typed at boot
# to unlock the disk also logs the user in and unlocks the gnome "login"
# keyring, so one password covers disk, session and secrets.
# Only safe with full-disk encryption: without LUKS this is plain autologin.
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.mine.system.luks-autologin;
  unixEarlyOrder = config.security.pam.services.login.rules.auth.unix-early.order;
in {
  options.mine.system.luks-autologin = {
    enable = lib.mkEnableOption ''
      console autologin that reuses the LUKS passphrase typed at boot to
      authenticate the login and unlock the gnome "login" keyring.
      Requires a LUKS root, and the keyring password must match the LUKS
      passphrase (the login password can differ)'';
    user = lib.mkOption {
      type = lib.types.str;
      description = "User to log in automatically on the console after LUKS unlock.";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = config.boot.initrd.luks.devices != {};
        message = "mine.system.luks-autologin needs a LUKS device in boot.initrd.luks.devices: it logs in with the LUKS passphrase.";
      }
    ];

    services.getty.autologinUser = cfg.user;
    # Without this, autologin runs `login -f`, which skips the PAM auth stack,
    # so pam_systemd_loadkey never unlocks the keyring. The LUKS passphrase
    # then authenticates the login with no prompt.
    services.getty.loginOptions = "-- \\u";
    # The cached passphrase sits in root's user keyring. The default
    # KeyringMode=private gives getty a session keyring without it, so
    # pam_systemd_loadkey finds nothing. "shared" links root's user keyring in.
    systemd.services."getty@".serviceConfig.KeyringMode = "shared";

    # The systemd initrd caches the LUKS passphrase in root's kernel keyring
    # for 2.5 min. pam_systemd_loadkey hands it to the auth stack as authtok,
    # and pam_gnome_keyring unlocks the "login" keyring with it.
    # The cached passphrase proves the disk was unlocked at this boot, so it
    # authenticates the login without a pam_unix check: the login password
    # can differ from it. Only root can put a key into root's keyring.
    # With no cached passphrase (after 2.5 min, or on another tty), the jump
    # skips the next two rules and login asks for the password as usual.
    security.pam.services.login = {
      rules.auth = {
        systemd_loadkey = {
          order = unixEarlyOrder - 3;
          # "2" counts the two rules below; keep them directly after this one.
          control = "[success=ok default=2]";
          modulePath = "${config.systemd.package}/lib/security/pam_systemd_loadkey.so";
        };
        gnome_keyring-luks = {
          order = unixEarlyOrder - 2;
          control = "optional";
          modulePath = "${pkgs.gnome-keyring}/lib/security/pam_gnome_keyring.so";
        };
        permit-luks = {
          order = unixEarlyOrder - 1;
          control = "sufficient";
          modulePath = "${config.security.pam.package}/lib/security/pam_permit.so";
        };
      };
      # A fingerprint gives no password, so the keyring would stay locked.
      fprintAuth = false;
    };
  };
}
