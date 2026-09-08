{
  config,
  lib,
  ...
}: {
  options.mine.desktop.portals.enable = lib.mkEnableOption "portals" // {default = true;};

  config = lib.mkIf config.mine.desktop.portals.enable {
    # correct permissions for xdg-open
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
  };
}
