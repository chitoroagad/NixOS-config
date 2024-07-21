{
  pkgs,
  inputs,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
    settings = {
      general = {
        grace = 3;
        no_fade_in = false;
        hide_cursor = true;
      };

      background = {
        monitor = "";
        path = "screenshot";
        blur_passes = 4;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      input-field = {
        monitor = "";
        size = "250, 60";
        outline_thickness = 2;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(0, 0, 0, 0.5)";
        font_color = "rgb(200, 200, 200)";
        fade_on_empty = false;
        placeholder_text = ''
          <i><span foreground="##cdd6f4">󰌆 </span></i>
        '';
        hide_input = false;
        position = "0, -120";
        halign = "center";
        valign = "center";
      };

      # TIME
      label = {
        monitor = "";
        text = ''
          cmd[update:1000] echo "$(date +"%H:%M")"
        '';
        color = "rgba(205, 214, 244, 1)";
        font_size = 120;
        font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
        position = "0, -300";
        halign = "center";
        valign = "top";
      };
    };
  };
}
