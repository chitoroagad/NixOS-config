{
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
}
