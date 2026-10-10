# ppd because its better than tlp on framework 16 atm
{
  config,
  lib,
  ...
}: let
  cfg = config.mine.hardware.power;
  ppctl = "${config.services.power-profiles-daemon.package}/bin/powerprofilesctl";
in {
  options.mine.hardware.power = {
    enable = lib.mkEnableOption "power";
    amdgpuActions = lib.mkEnableOption "PPD's amdgpu panel-power (ABM) and DPM actions";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      services.power-profiles-daemon.enable = true;
    }

    # PPD ships these actions disabled and keeps the toggle in its state file;
    # re-assert them every time the daemon starts.
    (lib.mkIf cfg.amdgpuActions {
      systemd.services.power-profiles-daemon.serviceConfig.ExecStartPost = [
        "${ppctl} configure-action amdgpu_panel_power --enable"
        "${ppctl} configure-action amdgpu_dpm --enable"
      ];
    })
  ]);
}
