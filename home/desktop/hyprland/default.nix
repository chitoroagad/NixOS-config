{
  lib,
  config,
  pkgs,
  asztal,
  inputs,
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

  services.hyprpolkitagent.enable = true;

  wayland.windowManager.hyprland = let
    exe = lib.getExe;
    exe' = lib.getExe';
    uwsm = exe pkgs.uwsm;
    uwsmWrap = exe: "${uwsm} app -- ${exe}";
    defaultApp = type: uwsmWrap "${exe pkgs.handlr-regex} launch ${type}";
    screenshot-script = import ./screenshot-script.nix {inherit pkgs lib;};
    browser = uwsmWrap (exe pkgs.brave);
    hyprlock = uwsmWrap (exe pkgs.hyprlock);
    hyprlauncher = uwsmWrap (exe pkgs.hyprlauncher);
    term = uwsmWrap (exe config.programs.kitty.package);
    proton-vpn = uwsmWrap (exe pkgs.protonvpn-gui);
    dms = exe' inputs.dankMaterialShell.packages.${pkgs.system}.default "dms";
    wl-paste = uwsmWrap (exe' pkgs.wl-clipboard "wl-paste");
    bash = uwsmWrap (exe pkgs.bash);
    cliphist = uwsmWrap (exe pkgs.cliphist);
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
        gaps_in = 1;
        gaps_out = 1;
        border_size = 0;
        layout = "dwindle";
      };
      decoration = {
        rounding = 2;
        active_opacity = 1.0;
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
      bindel = [
        # Audio controls
        ", XF86AudioRaiseVolume, exec, ${dms} ipc call audio increment 3"
        ", XF86AudioLowerVolume, exec, ${dms} ipc call audio decrement 3"
        ", XF86AudioMute, exec, ${dms} ipc call audio mute"

        # Brightness controls  (probs a better way to find the device)
        ", XF86MonBrightnessUp, exec, ${dms} ipc call brightness increment 5 backlight:amdgpu_bl2"
        ", XF86MonBrightnessDown, exec, ${dms} ipc call brightness decrement 5 backlight:amdgpu_bl2"
      ];
      bind = [
        # Spotlight
        "SUPER, space, exec, ${hyprlauncher}"
        "SUPER, TAB, exec, ${dms} ipc call hypr toggleOverview"

        # Lock Screen
        "SUPER, L, exec, ${hyprlock}"

        # Lauch Terminal
        "SUPER, T, exec, ${defaultApp "x-scheme-handler/terminal"}"

        # Launch Browser
        "SUPER, B, exec, ${browser}"

        # Screenshotting
        "$mainMod,      P, exec, ${screenshot-script} s # drag to snip an area / click on a window to print it"
        "$mainMod Ctrl, P, exec, ${screenshot-script} sf # frozen screen, drag to snip an area / click on a window to print it"
        "$mainMod Alt,  P, exec, ${screenshot-script} m # print focused monitor"
        ", Print, exec, nix-shell ${screenshot-script} p # print all monitor outputs"

        # Quit apps
        "SUPER, Q, killactive"
        "SUPERALTSHIFT, Q, exec, ${uwsm} stop"

        # mpris controls
        ",XF86AudioNext,exec,${dms} ipc call mpris next"
        ",XF86AudioPrev,exec,${dms} ipc call mpris previous"
        ",XF86AudioPlay,exec,${dms} ipc call mpris playPause"
        ",XF86AudioStop,exec,${dms} ipc call mpris stop"
      ];
    };

    extraConfig = ''
      exec-once = ${bash} -c "${wl-paste} --watch ${cliphist} store &"
      exec-once = [workspace 1] ${browser}
      exec-once = [workspace 2 silent] ${term} --hold sh -c "tmux -u attach"
      exec-once = [workspace 3 silent] ${proton-vpn}
      layerrule = noanim, ^(dms)$
      windowrulev2 = float, class:^(org.quickshell)$
    '';
  };
}
