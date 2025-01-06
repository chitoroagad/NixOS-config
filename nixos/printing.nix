{pkgs, ...}: {
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [gutenprint gutenprintBin fxlinuxprint brlaser];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
