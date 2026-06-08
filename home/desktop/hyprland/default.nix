{
  lib,
  config,
  pkgs,
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
    hyprpwcenter
  ];

  home.file.".config/brave-flags.conf".text = ''
    --enable-features=WebRTCPipeWireCapturer
  '';

  xdg.portal = let
    hyprland = config.wayland.windowManager.hyprland.package;
  in {
    enable = true;
    extraPortals = [
      # Extra portals for desktop sharing
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    config = {
      hyprland = {
        default = ["hyprland" "gtk"];
      };
      common = {
        default = ["gtk"];
      };
    };

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
    proton-vpn = uwsmWrap (exe pkgs.proton-vpn);
    dms = exe' inputs.dankMaterialShell.packages.${pkgs.stdenv.hostPlatform.system}.default "dms";

    # Lua config helpers: each `settings.<name>` renders to `hl.<name>(...)`.
    inherit (lib.generators) mkLuaInline;
    exec = cmd: mkLuaInline ''hl.dsp.exec_cmd("${cmd}")'';
    bindExec = keys: cmd: {_args = [keys (exec cmd)];};
    bindelExec = keys: cmd: {
      _args = [
        keys
        (exec cmd)
        {
          repeating = true;
          locked = true;
        }
      ];
    };
  in {
    enable = true;

    package = pkgs.hyprland;

    # New Hyprland Lua config format (hl.* API).
    configType = "lua";

    systemd = {
      enable = false;
      variables = ["--all"];
    };

    settings = {
      # hl.monitor({...}) per entry
      monitor = [
        {
          output = "eDP-2";
          mode = "2560x1600@165";
          position = "0x0";
          scale = 1;
          vrr = 1;
        }
        {
          output = "eDP-1";
          mode = "2560x1600@165";
          position = "0x0";
          scale = 1;
          vrr = 1;
        }
        # HDMI on Framework. Mirror of eDP-2 left disabled (as before).
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1;
        }
      ];

      # hl.config({...}) — single grouped call
      config = {
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
        animations.enabled = true;
        dwindle.preserve_split = true;
        misc = {
          vrr = 1;
          force_default_wallpaper = 0;
        };
        input = {
          kb_layout = "us";
          kb_options = "caps:swapescape";
          follow_mouse = 1;
          touchpad.natural_scroll = true;
          sensitivity = 0.15;
        };
      };

      gesture = {
        fingers = 3;
        direction = "horizontal";
        action = "workspace";
      };

      # smart gaps
      workspace_rule = [
        {
          workspace = "w[tv1]";
          gaps_out = 0;
          gaps_in = 0;
        }
        {
          workspace = "f[1]";
          gaps_out = 0;
          gaps_in = 0;
        }
      ];

      bind = [
        # Audio controls (repeating + locked, formerly bindel)
        (bindelExec "XF86AudioRaiseVolume" "${dms} ipc call audio increment 3")
        (bindelExec "XF86AudioLowerVolume" "${dms} ipc call audio decrement 3")
        (bindelExec "XF86AudioMute" "${dms} ipc call audio mute")

        # Brightness controls (probs a better way to find the device)
        (bindelExec "XF86MonBrightnessUp" "${dms} ipc call brightness increment 5 backlight:amdgpu_bl2")
        (bindelExec "XF86MonBrightnessDown" "${dms} ipc call brightness decrement 5 backlight:amdgpu_bl2")

        # Spotlight
        (bindExec "SUPER + space" hyprlauncher)
        (bindExec "SUPER + TAB" "${dms} ipc call hypr toggleOverview")

        # Lock Screen
        (bindExec "SUPER + L" hyprlock)

        # Launch Terminal
        (bindExec "SUPER + T" (defaultApp "x-scheme-handler/terminal"))

        # Launch Browser
        (bindExec "SUPER + B" browser)

        # Screenshotting (drag to snip / click a window / monitor / all outputs)
        (bindExec "SUPER + P" "${screenshot-script} s")
        (bindExec "SUPER + CTRL + P" "${screenshot-script} sf")
        (bindExec "SUPER + ALT + P" "${screenshot-script} m")
        (bindExec "Print" "nix-shell ${screenshot-script} p")

        # Quit apps
        {_args = ["SUPER + Q" (mkLuaInline "hl.dsp.window.close()")];}
        (bindExec "SUPER + ALT + SHIFT + Q" "${uwsm} stop")

        # mpris controls
        (bindExec "XF86AudioNext" "${dms} ipc call mpris next")
        (bindExec "XF86AudioPrev" "${dms} ipc call mpris previous")
        (bindExec "XF86AudioPlay" "${dms} ipc call mpris playPause")
        (bindExec "XF86AudioStop" "${dms} ipc call mpris stop")
      ];

      # hl.window_rule({...}) per entry
      window_rule = [
        {
          name = "windowrule-1";
          match = {
            float = false;
            workspace = "w[tv1]";
          };
          border_size = 0;
          rounding = 0;
        }
        {
          name = "windowrule-2";
          match = {
            float = false;
            workspace = "f[1]";
          };
          border_size = 0;
          rounding = 0;
        }
        {
          name = "windowrule-3";
          match.class = "^(org.quickshell)$";
          float = true;
        }
        {
          name = "windowrule-portal-float";
          match.class = "^(xdg-desktop-portal)(.*)$";
          float = true;
        }
        {
          name = "windowrule-portal-gtk-float";
          match.title = "^(Open File|Open Folder|Save File|Select File)(.*)$";
          float = true;
        }
      ];

      layer_rule = {
        name = "layerrule-1";
        match.namespace = "^(dms)$";
        no_anim = true;
      };

      # Autostart: hl.on("hyprland.start", function() ... end)
      # exec_cmd keeps the [workspace ...] execution-rule prefix.
      on._args = [
        "hyprland.start"
        (mkLuaInline ''
          function()
            hl.exec_cmd([[[workspace 1] ${browser}]])
            hl.exec_cmd([[[workspace 2 silent] ${term} --hold sh -c "tmux -u attach"]])
            hl.exec_cmd([[[workspace 3 silent] ${proton-vpn}]])
          end'')
      ];
    };
  };
}
