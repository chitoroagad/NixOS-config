{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.programs.steam.enable = lib.mkEnableOption "steam" // {default = true;};

  config = lib.mkIf config.mine.programs.steam.enable {
    programs.steam = {
      enable = true;
      package = pkgs.steam;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
      gamescopeSession.args = ["adaptive-sync" "steam"];
    };
    programs.gamemode.enable = true;
    hardware.xpadneo.enable = true;

    hardware.graphics = {
      enable32Bit = true;
    };

    environment.systemPackages = with pkgs; [gamemode];
  };
}
