{
  config,
  lib,
  ...
}: {
  options.mine.services.openssh.enable = lib.mkEnableOption "openssh";

  config = lib.mkIf config.mine.services.openssh.enable {
    services.openssh.enable = true;
  };
}
