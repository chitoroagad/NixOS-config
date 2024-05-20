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
    systemd.user.services.waybar = { Unit.StartLimitBurst = 30; };
    programs.waybar = {
        enable = true;
        primary = {
            layer = "top";
            passthrough = false;
            spacing = 3;
            margin-left = 10;
            margin-right = 10;
            margin-top = 10;
            margin-bottom = 0;
            modules-left = [
                "hyprland/workspaces",
                "cpu",
                "memory",
                "custom/media",
                "temperature",
                "tray"
            ];
            modules-centre = [ "clock" ];
            modules-right = [
                "backlight",
                "wireplumber",
                "battery",
                "custom/power"
            ];
            temperature = {
                format = " {temperatureC}°C"
            };
            wireplumber = {
                on-click = "helvum";
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
                    on-scroll-up = "brightnessctl set 1%+";
                    on-scroll-down = "brightnessctl set 1%-";
                };
                battery = {
                    states = {
                        good = 95;
                        warning = 30;
                        critical = 20;
                    };
                    format = "{icon}  {capacity}%";
                    format-charging = " {capacity}%";
                    format-plugged = " {capacity}%";
                    format-alt = "{time} {icon}";
                    format-icons = [
                        "";
                        "";
                        "";
                        "";
                        "";
                    ];
                };
                tray = {
                    icon-size = 18;
                    spacing = 10;
                };
                clock = {
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
                    format = "{icon}{}";
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
                "custom/power": {
                    format = " ";
                    on-click = "wlogout";
                };
        };
    };
}
