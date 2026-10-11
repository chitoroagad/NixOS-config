{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.mine.programs.steam;
in {
  options.mine.programs.steam = {
    enable = lib.mkEnableOption "steam";
    dgpu = lib.mkEnableOption "PRIME offload of gamemoderun games to the dGPU";
  };

  config = lib.mkIf cfg.enable {
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

    # gamemoderun execs the game through $GAMEMODERUNEXEC. DRI_PRIME=1 is "not
    # the boot GPU" for both GL and Vulkan. Steam games need `gamemoderun
    # %command%` in their launch options; Lutris adds it on its own.
    environment.sessionVariables = lib.mkIf cfg.dgpu {
      GAMEMODERUNEXEC = "env DRI_PRIME=1";
    };

    hardware.graphics = {
      enable32Bit = true;
    };

    environment.systemPackages = with pkgs; [gamemode];
  };
}
