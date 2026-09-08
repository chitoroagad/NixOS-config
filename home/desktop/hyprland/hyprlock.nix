{pkgs, ...}: let
  # Catppuccin Mocha, sapphire accent — matches the global colorscheme.
  # Bare hex so it can be dropped into both hyprlang rgba() and pango markup.
  c = {
    crust = "11111b";
    surface0 = "313244";
    overlay1 = "7f849c";
    subtext0 = "a6adc8";
    text = "cdd6f4";
    accent = "74c7ec";
    red = "f38ba8";
  };

  font = "JetBrainsMono NF";
  fontMedium = "JetBrainsMono NF Medium";
  fontBold = "JetBrainsMono NF ExtraBold";

  battery = pkgs.writeShellScript "hyprlock-battery" ''
    bat=/sys/class/power_supply/BAT1
    [ -r "$bat/capacity" ] || exit 0

    cap=$(cat "$bat/capacity")
    if [ "$(cat "$bat/status")" = Charging ]; then
      icon="󰂄"
    else
      case $((cap / 10)) in
        10 | 9) icon="󰁹" ;;
        8) icon="󰂂" ;;
        7) icon="󰂁" ;;
        6) icon="󰂀" ;;
        5) icon="󰁿" ;;
        4) icon="󰁾" ;;
        3) icon="󰁽" ;;
        2) icon="󰁼" ;;
        1) icon="󰁻" ;;
        *) icon="󰂃" ;;
      esac
    fi

    printf '%s  %s%%' "$icon" "$cap"
  '';
in {
  catppuccin.hyprlock.enable = false;
  programs.hyprlock = {
    enable = true;
    package = pkgs.hyprlock;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
        text_trim = true;
        fail_timeout = 2500;
      };

      # The grace period is passed as `--grace` by the callers (hypridle,
      # the Hyprland keybind); it is not a config option.

      auth = {
        pam.enabled = true;
        fingerprint = {
          enabled = true;
          ready_message = "󰈷  Scan your fingerprint";
          present_message = "󰈷  Scanning…";
          retry_delay = 250;
        };
      };

      animations.enabled = true;

      background = {
        monitor = "";
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
        noise = 0.0117;
        contrast = 0.9;
        brightness = 0.62;
        vibrancy = 0.17;
        vibrancy_darkness = 0.05;
      };

      label = [
        # TIME
        {
          monitor = "";
          text = "$TIME";
          color = "rgba(${c.text}ff)";
          font_size = 92;
          font_family = fontBold;
          position = "0, 210";
          halign = "center";
          valign = "center";
          shadow_passes = 3;
          shadow_size = 6;
          shadow_boost = 0.4;
          shadow_color = "rgba(${c.crust}cc)";
        }

        # DATE
        {
          monitor = "";
          text = ''cmd[update:60000] date +"%A, %-d %B"'';
          color = "rgba(${c.subtext0}ff)";
          font_size = 17;
          font_family = fontMedium;
          position = "0, 122";
          halign = "center";
          valign = "center";
          shadow_passes = 2;
          shadow_size = 3;
          shadow_color = "rgba(${c.crust}aa)";
        }

        # FINGERPRINT STATUS
        {
          monitor = "";
          text = "$FPRINTPROMPT";
          color = "rgba(${c.subtext0}ff)";
          font_size = 14;
          font_family = fontMedium;
          position = "0, -70";
          halign = "center";
          valign = "center";
          shadow_passes = 2;
          shadow_size = 3;
          shadow_color = "rgba(${c.crust}aa)";
        }

        # BATTERY
        {
          monitor = "";
          text = "cmd[update:30000] ${battery}";
          color = "rgba(${c.subtext0}ff)";
          font_size = 14;
          font_family = fontMedium;
          position = "36, 30";
          halign = "left";
          valign = "bottom";
          shadow_passes = 2;
          shadow_size = 3;
          shadow_color = "rgba(${c.crust}aa)";
        }
      ];

      input-field = {
        monitor = "";
        size = "340, 56";
        rounding = 28;
        outline_thickness = 2;
        dots_size = 0.26;
        dots_spacing = 0.3;
        dots_center = true;
        dots_rounding = -1;
        outer_color = "rgba(${c.surface0}cc)";
        inner_color = "rgba(${c.crust}b3)";
        font_color = "rgba(${c.text}ff)";
        font_family = font;
        check_color = "rgba(${c.accent}ff)";
        fail_color = "rgba(${c.red}ff)";
        capslock_color = "rgba(${c.accent}ff)";
        fade_on_empty = false;
        placeholder_text = ''<span foreground="##${c.overlay1}">󰌾  Hi, $USER</span>'';
        fail_text = ''<span foreground="##${c.red}">$FAIL ($ATTEMPTS)</span>'';
        hide_input = false;
        position = "0, 0";
        halign = "center";
        valign = "center";
        shadow_passes = 3;
        shadow_size = 6;
        shadow_boost = 0.4;
        shadow_color = "rgba(${c.crust}cc)";
      };
    };
  };
}
