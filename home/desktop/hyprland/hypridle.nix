{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.desktop.hypridle.enable = lib.mkEnableOption "hypridle" // {default = true;};

  config = lib.mkIf config.mine.desktop.hypridle.enable {
    home.packages = [
      pkgs.qmk_hid
    ];

    services.hypridle = {
      enable = true;
      package = pkgs.hypridle;
      settings = let
        brightnessctl = lib.getExe pkgs.brightnessctl;
      in {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock --grace 3";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'"; # to avoid having to press a key twice to turn on the display.
        };

        listener = [
          {
            timeout = 150;
            on-timeout = "${brightnessctl} -s set 5"; # Set monitor backlight to min, avoid 0 on OLED
            on-resume = "${brightnessctl} -r"; # restore backlight
          }

          {
            timeout = 300;
            on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
          }

          {
            timeout = 330;
            on-timeout = "hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'"; # screen off when timeout has passed
            on-resume = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })' && brightnessctl -r"; # screen on when activity is detected after timeout has fired.
          }

          {
            timeout = 1000;
            on-timeout = "systemctl suspend"; # suspend pc after 30min
          }
        ];
      };
    };
  };
}
