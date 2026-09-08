{
  config,
  lib,
  ...
}: {
  options.mine.services.docker.enable = lib.mkEnableOption "docker";

  config = lib.mkIf config.mine.services.docker.enable {
    virtualisation.docker.enable = true;
  };
}
