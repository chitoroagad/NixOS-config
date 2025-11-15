{pkgs, ...}: {
  programs.steam = {
    enable = true;
    package = pkgs.steam;
    extest.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
    gamescopeSession.args = ["adaptive-sync" "steam"];
  };
  hardware.xpadneo.enable = true;

  hardware.graphics = {
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [gamemode];
}
