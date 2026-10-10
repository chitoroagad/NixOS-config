# Drop the built-in panel to 60 Hz while PPD is in power-saver.
{
  config,
  lib,
  pkgs,
  ...
}: let
  panel = import ./panel.nix;

  follow = pkgs.writeShellApplication {
    name = "hypr-panel-refresh";
    runtimeInputs = [
      config.wayland.windowManager.hyprland.package
      pkgs.glib
      pkgs.jq
      pkgs.power-profiles-daemon
      pkgs.socat
    ];
    text = ''
      apply() {
        if [ "$(powerprofilesctl get)" = power-saver ]; then
          rate=${panel.rate.saver}
        else
          rate=${panel.rate.full}
        fi

        # Compare against the live mode rather than remembered state, so a
        # config reload (which restores the static rate) is picked up too.
        for output in ${lib.concatStringsSep " " panel.outputs}; do
          current=$(hyprctl monitors -j | jq -r --arg o "$output" '.[] | select(.name == $o) | .refreshRate | round')
          if [ -z "$current" ] || [ "$current" = "$rate" ]; then
            continue
          fi

          lua=$(cat <<EOF
      ${panel.monitor "$output" "$rate"}
      EOF
          )
          hyprctl eval "$lua" >/dev/null
        done
      }

      apply

      gdbus monitor --system \
        --dest org.freedesktop.UPower.PowerProfiles \
        --object-path /org/freedesktop/UPower/PowerProfiles |
        while read -r line; do
          case $line in *ActiveProfile*) apply ;; esac
        done &

      socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - |
        while read -r line; do
          case $line in configreloaded*) apply ;; esac
        done &

      # Exit (and get restarted) if either event stream goes away.
      wait -n
    '';
  };
in {
  options.mine.desktop.hyprland.powerSaverRefresh.enable =
    lib.mkEnableOption "dropping the built-in panel to ${panel.rate.saver} Hz in PPD power-saver";

  config = lib.mkIf config.mine.desktop.hyprland.powerSaverRefresh.enable {
    systemd.user.services.hypr-panel-refresh = {
      Unit = {
        Description = "Follow PPD power-saver with the panel refresh rate";
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
      Service = {
        Type = "exec";
        ExecStart = lib.getExe follow;
        Restart = "always";
        RestartSec = "2s";
        Slice = "background-graphical.slice";
      };
    };
  };
}
