{
  config,
  lib,
  ...
}: {
  options.mine.services.docker.enable = lib.mkEnableOption "docker";

  config = lib.mkIf config.mine.services.docker.enable {
    virtualisation.docker = {
      enable = true;
      # docker.socket stays enabled, so the daemon starts on first use
      # instead of idling in the background from boot.
      enableOnBoot = false;
    };
  };
}
