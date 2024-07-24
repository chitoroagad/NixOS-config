{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    pkgs.qmk_hid
  ];

  services.hypridle = {
    enable = true;
    package = inputs.hypridle.packages.${pkgs.system}.hypridle;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 5"; # Set monitor backlight to min
          on-resume = "brightnessctl -r"; # restore backlight
        }

        {
          timeout = 300;
          on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
        }

        {
          timeout = 330;
          on-timeout = ''
            hyprctl dispatch dpms off \
            qmk_hid --vid 32ac --pid 0012 via --backlight-breathing true # keyboard backlight \
            qmk_hid --vid 32ac --pid 0014 via --backlight-breathing true # numpad backlight   \
          ''; # screen off when timeout has passed
          on-resume = ''
            hyprctl dispatch dpms on
            qmk_hid --vid 32ac --pid 0012 via --backlight-breathing false # keyboard backlight \
            qmk_hid --vid 32ac --pid 0014 via --backlight-breathing false # numpad backlight   \
          ''; # screen on when activity is detected
        }

        {
          timeout = 1000;
          on-timeout = "systemctl suspend"; # suspend pc after 30min
        }
      ];
    };
  };
}
