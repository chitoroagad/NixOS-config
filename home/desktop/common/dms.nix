{pkgs,...}:{
  programs.dank-material-shell = {
    enable = true;
    quickshell.package = pkgs.quickshell;
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
