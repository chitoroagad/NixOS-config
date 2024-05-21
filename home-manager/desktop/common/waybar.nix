{
  outputs,
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  commonDeps = with pkgs; [coreutils gnugrep systemd];
  mkScript = {
    name ? "script",
    deps ? [],
    script ? "",
  }:
    lib.getExe (pkgs.writeShellApplication {
      inherit name;
      text = script;
      runtimeInputs = commonDeps ++ deps;
    });

  # Specialized for JSON outputs
  mkScriptJson = {
    name ? "script",
    deps ? [],
    pre ? "",
    text ? "",
    tooltip ? "",
    alt ? "",
    class ? "",
    percentage ? "",
  }:
    mkScript {
      deps = [pkgs.jq] ++ deps;
      script = ''
            ${pre}
        jq -cn \
            --arg text "${text}" \
            --arg tooltip "${tooltip}" \
            --arg alt "${alt}" \
            --arg class "${class}" \
            --arg percentage "${percentage}" \
            '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
      '';
    };
in {
  systemd.user.services.waybar = {Unit.StartLimitBurst = 30;};
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      primary = {
        layer = "top";
        passthrough = false;
        spacing = 3;
        margin-left = 5;
        margin-right = 5;
        margin-top = 5;
        margin-bottom = 0;
        modules-left = [
          "hyprland/workspaces"
          "cpu"
          "memory"
          "custom/media"
          "temperature"
          "tray"
        ];
        modules-centre = ["simpleclock"];
        modules-right = [
          "backlight"
          "wireplumber"
          "battery"
          "custom/power"
        ];
        temperature = {
          format = " {temperatureC}°C";
        };
        wireplumber = {
          on-click = mkScript {
            deps = [pkgs.helvum];
            script = "helvum";
          };
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
          max-volume = 150;
          scroll-step = 0.7;
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        network = {
          format-wifi = " ";
          format-ethernet = "󰈀";
          format-disconnected = "󰖪";
          onclick = "nm-connection-editor";
          tooltip_format = "{essid} {ipaddr} UP:{bandwidthUpBits}mbps DOWN:{bandwidthDownBits}mbps {signalStrength}";
        };
        backlight = {
          tooltip = false;
          format = " {}%";
          interval = 5;
          on-scroll-up = mkScript {
            deps = [pkgs.brightnessctl];
            script = "brightnessctl set 1%+";
          };
          on-scroll-down = mkScript {
            deps = [pkgs.brightnessctl];
            script = "brightnessctl set 1%-";
          };
        };
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        tray = {
          icon-size = 18;
          spacing = 10;
        };
        simpleclock = {
          format = "{:%H:%M  }";
        };
        cpu = {
          interval = 5;
          format = " {usage}%";
          max-length = 100;
        };
        memory = {
          interval = 30;
          format = " {}%";
          max-length = 10;
        };
        "custom/media" = {
          interval = 2;
          return-type = "json";
          exec = mkScriptJson {
            deps = [pkgs.playerctl];
            pre = ''
              player="$(playerctl status -f "{{playerName}}" 2>/dev/null || echo "No player active" | cut -d '.' -f1)"
              count="$(playerctl -l 2>/dev/null | wc -l)"
              if ((count > 1)); then
                  more=" +$((count - 1))"
              else
                  more=""
                      fi
            '';
            alt = "$player";
            tooltip = "$player ($count available)";
            text = "$more";
          };
          format = "{icon} {}";
          format-icons = {
            "No player active" = " ";
            "Celluloid" = "󰎁 ";
            "spotify" = "󰓇 ";
            "ncspot" = "󰓇 ";
            "qutebrowser" = "󰖟 ";
            "firefox" = " ";
            "discord" = " 󰙯 ";
            "sublimemusic" = " ";
            "kdeconnect" = "󰄡 ";
            "chromium" = " ";
          };
        };
        "custom/power" = {
          format = " ";
          on-click = "wlogout";
        };
      };
    };
    style = ''
                  * {
      border: none;
              border-radius: 20px;
              font-family: ${config.fontProfiles.monospace.family};
              font-size: 15px;
              min-height: 10px;
      background: #161320;
                  padding-left: 5px;
                  padding-right: 5px;
                  }

      #waybar {
          margin-left: 10px;
          margin-right: 10px;
      }

      window#waybar {
      background: transparent;
      }

      window#waybar.hidden {
      opacity: 0.2;
      }

      #window {
          border-radius: 20px;
          margin-left: 10px;
          margin-right: 10px;
      transition: none;
      color: transparent;
      background: transparent;
      }

      #tags {
          margin-left: 12px;
          font-size: 4px;
          margin-bottom: 0px;
          border-radius: 20px;
      color: #161320;
      transition: none;
      }

      #tags button {
      transition: none;
      color: #b5e8e0;
      background: transparent;
                  font-size: 16px;
                  border-radius: 2px;
      }

      #tags button.occupied {
      transition: none;
      color: #f28fad;
      background: transparent;
                  font-size: 10px;
      }

      #tags button.focused {
      color: #abe9b3;
             border-top: 2px solid #abe9b3;
             border-bottom: 2px solid #abe9b3;
      }

      #tags button:hover {
      transition: none;
                  box-shadow: inherit;
                  text-shadow: inherit;
      color: #fae3b0;
             border-color: #e8a2af;
      color: #e8a2af;
      }

      #tags button.focused:hover {
      color: #e8a2af;
      }

      #network {
          margin-left: 8px;
          margin-bottom: 0px;
          border-radius: 20px;
      transition: none;
      color: #bd93f9;
      }

      #wireplumber {
          margin-left: 8px;
          margin-bottom: 0px;
          border-radius: 20px;
      transition: none;
      color: #fae3b0;
      }

      #battery {
          margin-left: 8px;
          margin-bottom: 0px;
          border-radius: 20px;
      transition: none;
      color: #b5e8e0;
      }

      #battery.charging,
      #battery.plugged {
      color: #b5e8e0;
      }

      #battery.critical:not(.charging) {
          background-color: #b5e8e0;
      color: #161320;
             animation-name: blink;
             animation-duration: 0.5s;
             animation-timing-function: linear;
             animation-iteration-count: infinite;
             animation-direction: alternate;
      }

      @keyframes blink {
          to {
              background-color: #bf616a;
      color: #b5e8e0;
          }
      }

      #backlight {
          margin-left: 8px;
          margin-bottom: 0px;
          border-radius: 20px;
      transition: none;
      color: #f8bd96;
      }

      #bluetooth {
          margin-left: 8px;
          margin-bottom: 0px;
          border-radius: 20px;
      transition: none;
      color: #f8bd96;
      }

      #clock {
          margin-left: 8px;
          margin-bottom: 0px;
          border-radius: 20px;
      transition: none;
      color: #abe9b3;
             /*background: #1A1826;*/
      }

      #memory {
          margin-left: 8px;
          margin-bottom: 0px;
          border-radius: 20px;
      transition: none;
      color: #ddb6f2;
      }

      #cpu {
          margin-left: 8px;
          margin-bottom: 0px;
          border-radius: 20px;
      transition: none;
      color: #96cdfb;
      }

      #tray {
          margin-left: 8px;
          margin-bottom: 0px;
          border-radius: 20px;
      transition: none;
      color: #161320;
      }

      #temperature {
          margin-left: 8px;
          margin-bottom: 0px;
          border-radius: 20px;
      transition: none;
      color: #f2cdcd;
      }

      #custom-power {
          font-size: 20px;
          margin-left: 8px;
          margin-right: 8px;
          margin-bottom: 0px;
          border-radius: 20px;
      transition: none;
      color: #f28fad;
      }

      #custom-wallpaper {
          margin-left: 8px;
          margin-bottom: 0px;
          border-radius: 20px;
      transition: none;
      color: #c9cbff;
      }

      #custom-media {
          margin-left: 8px;
          margin-bottom: 0px;
          border-radius: 20px;
      transition: none;
      color: #f2cdcd;
      }

      #workspaces {
          margin-left: 8px;
          margin-bottom: 0px;
          border-radius: 20px;
      transition: none;
      }

      #workspaces button {
      color: #b5e8e0;
             border-radius: 20px;
      }

      #workspaces button:hover {
      background: rgba(0, 0, 0, 0.2);
      }

      #workspaces button.active {
      background: #fffdd0;
      }

      #workspaces button.urgent {
          background-color: #f28fad;
      }
    '';
  };
}
