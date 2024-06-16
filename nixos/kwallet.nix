{...}: {
  security.pam.services.kwallet = {
    name = "kwallet";
    kwallet.enable = true;
  };
}
