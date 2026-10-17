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
  };
}
