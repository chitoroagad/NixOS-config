{
  config,
  lib,
  ...
}: {
  options.mine.desktop.sound.enable = lib.mkEnableOption "sound" // {default = true;};

  config = lib.mkIf config.mine.desktop.sound.enable {
    # Enable sound
    security.rtkit.enable = true;
    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
    };
  };
}
