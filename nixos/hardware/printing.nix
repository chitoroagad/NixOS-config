{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.hardware.printing.enable = lib.mkEnableOption "printing" // {default = true;};

  config = lib.mkIf config.mine.hardware.printing.enable {
    services.printing.enable = true;
    services.printing.drivers = with pkgs; [gutenprint gutenprintBin fxlinuxprint brlaser];
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
