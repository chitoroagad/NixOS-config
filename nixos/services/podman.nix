{
  config,
  lib,
  ...
}: {
  options.mine.services.podman.enable = lib.mkEnableOption "podman";

  config = lib.mkIf config.mine.services.podman.enable {
    # The podman CLI is daemonless. The module only enables podman.socket
    # (system and user), so the API service starts on first use, like docker.
    virtualisation.podman = {
      enable = true;
      # A `docker` alias and /run/docker.sock, only without real docker:
      # both conflict with it.
      dockerCompat = lib.mkDefault (!config.virtualisation.docker.enable);
      dockerSocket.enable = lib.mkDefault (!config.virtualisation.docker.enable);
    };

    # systemd starts user@.service with OOMScoreAdjust=100, which also becomes
    # the unprivileged floor (oom_score_adj_min) for the whole user session.
    # Docker API clients (supabase CLI) always request OomScoreAdj=0; podman
    # clamps that for the container itself but not for `exec`, so every exec
    # and health check dies with "crun: write to /proc/self/oom_score_adj:
    # Permission denied". Dropping the floor to 0 makes that write legal.
    # Takes effect when user@ restarts (re-login or reboot).
    systemd.services."user@" = {
      overrideStrategy = "asDropin";
      serviceConfig.OOMScoreAdjust = 0;
    };
  };
}
