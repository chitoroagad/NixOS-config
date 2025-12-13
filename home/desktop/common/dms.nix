{
  programs.dankMaterialShell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = false;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
  };
}
