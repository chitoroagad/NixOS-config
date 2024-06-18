{pkgs, ...}: {
  # # Start polkit-kde as a systemd service
  # systemd = {
  #   user.services.polkit-kde-agent = {
  #     description = "polkit-kde-agent-1";
  #     wantedBy = ["graphical-session.target"];
  #     wants = ["graphical-session.target"];
  #     after = ["graphical-session.target"];
  #     serviceConfig = {
  #       Type = "simple";
  #       ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
  #       Restart = "on-failure";
  #       RestartSec = 1;
  #       TimeoutStopSec = 10;
  #     };
  #   };
  # };

  # auth-agent
  systemd = {
    user.services.polkit-kde-authentication-agent-1 = {
      description = "polkit-kde-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # enable keyring
  services.gnome.gnome-keyring.enable = true;

  # enable and configure polkit
  security.polkit = {
    enable = true;

    # automount drives
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (
          subject.isInGroup("wheel")
          && (/^org\.freedesktop\.udisks\./.test(action.id)
          ))
            { return polkit.Result.YES; }
      });
    '';
  };
}
