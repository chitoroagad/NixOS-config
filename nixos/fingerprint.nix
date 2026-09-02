{
  services.fprintd.enable = true;

  security.pam.services = {
    sudo.fprintAuth = true;
    hyprlock.fprintAuth = true;
  };
}
