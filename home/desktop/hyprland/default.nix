{
  lib,
  config,
  pkgs,
  asztal,
  ...
}: {
  imports = [
    ./binds.nix
    ./env.nix
  ];

  home.packages = with pkgs; [
    hyprpicker
    grimblast
    swappy
  ];

  xdg.portal = let
    hyprland = config.wayland.windowManager.hyprland.package;
  in {
    enable = true;
    extraPortals = [
      # Extra portals for desktop sharing
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];

    configPackages = [hyprland];
  };

  services.network-manager-applet.enable = true;

  wayland.windowManager.hyprland = let
    browser = lib.getExe pkgs.brave;
    term = lib.getExe config.programs.kitty.package;
    proton-vpn = lib.getExe pkgs.protonvpn-gui;
    nm-applet = lib.getExe pkgs.networkmanagerapplet;
  in {
    enable = true;

    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;

    systemd = {
      enable = false;
      variables = ["--all"];
    };

    settings = {
      monitor = [
        "eDP-2, 2560x1600@165, 0x0, 1, vrr, 1"
        "eDP-1, 2560x1600@165, 0x0, 1, vrr, 1"
        ", preferred, auto, 1, #mirror, eDP-2" # HDMI on FM
      ];
      general = {
        gaps_in = 3;
        gaps_out = 2;
        border_size = 2;
        layout = "dwindle";
      };
      decoration = {
        rounding = 10;
        active_opacity = 0.99;
        inactive_opacity = 0.87;
        blur = {
          enabled = true;
          size = 5;
          passes = 4;
          new_optimizations = true;
          ignore_opacity = true;
        };
      };
      animations = {
        enabled = "yes";
      };
      dwindle = {
        preserve_split = "yes";
      };
      gesture = [
        "3, horizontal, workspace"
      ];
      misc = {
        vfr = true;
        vrr = 1;
        force_default_wallpaper = 0;
      };
      input = {
        kb_layout = "us";
        kb_options = "caps:swapescape";
        follow_mouse = 1;
        touchpad.natural_scroll = "yes";
        sensitivity = 0.15;
      };

      # smart gaps
      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];
      windowrule = [
        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
      ];
      bind = let
        uwsm = lib.getExe pkgs.uwsm;
        uwsm-app = lib.concatStrings [uwsm " app --"];
        browser = lib.concatStrings [uwsm-app (lib.getExe pkgs.brave)];
        notify-send = lib.getExe' pkgs.libnotify "nofity-send";
        wpctl = lib.getExe' pkgs.wireplumber "wpctl";
        grimblast = lib.getExe pkgs.grimblast;
        brightnessctl = lib.getExe pkgs.brightnessctl;
        screenshot-script = ./screenshot-script.sh;
        defaultApp = type: "${uwsm-app} ${lib.getExe pkgs.handlr-regex} launch ${type}";
      in
        [
          # Lauch Terminal
          "SUPER, T, exec, ${defaultApp "x-scheme-handler/terminal"}"

          # Launch Browser
          "SUPER, B, exec, ${browser}"

          # Brightness Control
          ", XF86MonBrightnessUp, exec, ${brightnessctl} set 5%+"
          ", XF86MonBrightnessDown, exec, ${brightnessctl} set 5%-"

          # Volume Control
          ", XF86AudioRaiseVolume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"

          # Screenshotting
          "$mainMod,      P, exec, nix-shell ${screenshot-script} s # drag to snip an area / click on a window to print it"
          "$mainMod Ctrl, P, exec, nix-shell ${screenshot-script} sf # frozen screen, drag to snip an area / click on a window to print it"
          "$mainMod Alt,  P, exec, nix-shell ${screenshot-script} m # print focused monitor"
          ", Print, exec, nix-shell ${screenshot-script} p # print all monitor outputs"

          # Quit apps
          "SUPER, Q, killactive"
          "SUPERALTSHIFT, Q, exec, ${uwsm} stop"
        ]
        ++ (
          let
            playerctl = lib.getExe' config.services.playerctld.package "playerctl";
            playerctld = lib.getExe' config.services.playerctld.package "playerctld";
          in
            lib.optionals config.services.playerctld.enable [
              # Media control
              ",XF86AudioNext,exec,${playerctl} next"
              ",XF86AudioPrev,exec,${playerctl} previous"
              ",XF86AudioPlay,exec,${playerctl} play-pause"
              ",XF86AudioStop,exec,${playerctl} stop"
              "ALT,XF86AudioNext,exec,${playerctld} shift"
              "ALT,XF86AudioPrev,exec,${playerctld} unshift"
              "ALT,XF86AudioPlay,exec,systemctl --user restart playerctld"
            ]
        )
        ++
        # Notification manager
        (
          let
            makoctl = lib.getExe' config.services.mako.package "makoctl";
          in
            lib.optionals config.services.mako.enable [
              "SUPERSHIFT,w,exec,${makoctl} restore"
            ]
        )
        # App launcher
        ++ (
          let
            wofi = lib.getExe config.programs.wofi.package;
            ags-launcher = "${asztal}/bin/asztal -b hypr -t launcher";
          in
            # lib.optionals config.programs.wofi.enable [
            #   "SUPER,A,exec,${wofi} -S drun -W 25% -H 60%"
            # ]
            lib.optionals config.programs.ags.enable [
              "SUPER, A, exec, ${ags-launcher}"
            ]
        );
    };

    extraConfig = ''
      exec-once = [workspace 1] ${browser}
      exec-once = [workspace 2 silent] ${term} --hold sh -c "tmux -u attach"
      # exec-once = [workspace 3 silent] ${proton-vpn}
      exec-once = ${nm-applet}
    '';
  };
}
