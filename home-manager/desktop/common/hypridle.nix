{...}: {
  services.hypridle = {
    enable = true;
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
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on"; # screen on when activity is detected
        }

        {
          timeout = 1000;
          on-timeout = "systemctl suspend"; # suspend pc after 30min
        }
      ];
    };
  };
}
