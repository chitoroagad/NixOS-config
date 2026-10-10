{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.mine.system.networking;
  netPkgs =
    if cfg.stable
    then pkgs.stable
    else pkgs;
in {
  options.mine.system.networking = {
    enable = lib.mkEnableOption "networking";
    stable = lib.mkEnableOption "the networking stack from nixpkgs-stable (pkgs.stable)";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      networking.networkmanager.enable = true;
      networking.networkmanager.plugins = with netPkgs; [networkmanager-openvpn networkmanager-openconnect];

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      # networking.firewall.enable = false;
    }

    (lib.mkIf cfg.stable {
      networking.networkmanager.package = pkgs.stable.networkmanager;
      networking.modemmanager.package = pkgs.stable.modemmanager;
      networking.firewall.package =
        if config.networking.nftables.enable
        then pkgs.stable.nftables
        else pkgs.stable.iptables;

      # The wpa_supplicant module has no package option.
      nixpkgs.overlays = [(final: _prev: {wpa_supplicant = final.stable.wpa_supplicant;})];
    })
  ]);
}
