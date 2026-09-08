{
  config,
  lib,
  ...
}: {
  options.mine.desktop.dms.enable = lib.mkEnableOption "dms" // {default = true;};

  config = lib.mkIf config.mine.desktop.dms.enable {
    programs.dank-material-shell = {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
      enableSystemMonitoring = true;
      enableVPN = false;
      enableDynamicTheming = false;
      enableAudioWavelength = false;
      enableCalendarEvents = false;
      enableClipboardPaste = true;
    };
  };
}
