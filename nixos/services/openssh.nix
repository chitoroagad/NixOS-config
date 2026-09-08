{
  config,
  lib,
  ...
}: {
  options.mine.services.openssh.enable = lib.mkEnableOption "openssh" // {default = true;};

  config = lib.mkIf config.mine.services.openssh.enable {
    services.openssh.enable = true;
  };
}
