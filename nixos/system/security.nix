{
  config,
  lib,
  ...
}: {
  options.mine.system.security.enable = lib.mkEnableOption "security" // {default = true;};

  config = lib.mkIf config.mine.system.security.enable {
    # security.sudo.enable = false;
    security.sudo-rs.enable = true;
  };
}
