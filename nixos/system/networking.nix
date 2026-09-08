{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.system.networking.enable = lib.mkEnableOption "networking";

  config = lib.mkIf config.mine.system.networking.enable {
    networking.networkmanager.enable = true;
    networking.networkmanager.plugins = with pkgs; [networkmanager-openvpn networkmanager-openconnect];

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };
}
