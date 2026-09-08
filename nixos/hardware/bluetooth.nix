{
  config,
  lib,
  ...
}: {
  options.mine.hardware.bluetooth.enable = lib.mkEnableOption "bluetooth";

  config = lib.mkIf config.mine.hardware.bluetooth.enable {
    # Enable bluetooth
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.pipewire.wireplumber.extraConfig = {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = ["hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag"];
      };
    };
  };
}
