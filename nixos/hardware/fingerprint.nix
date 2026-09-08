{
  services.fprintd.enable = true;

  security.pam.services = {
    sudo.fprintAuth = true;

    # hyprlock talks to fprintd over dbus itself (auth.fingerprint.enabled),
    # so pam_fprintd must stay out of its stack — both would race to claim
    # the reader.
    hyprlock.fprintAuth = false;
  };
}
