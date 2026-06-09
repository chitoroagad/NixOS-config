{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
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
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    config = {
      hyprland.default = ["hyprland" "gtk"];
      common.default = ["gtk"];
    };
    configPackages = [hyprland];
  };

  services.hyprpolkitagent.enable = true;

  wayland.windowManager.hyprland = let
    exe = lib.getExe;
    exe' = lib.getExe';
    uwsm = exe pkgs.uwsm;
    uwsmWrap = app: "${uwsm} app -- ${app}";
    defaultApp = type: uwsmWrap "${exe pkgs.handlr-regex} launch ${type}";
    screenshot = import ./screenshot-script.nix {inherit pkgs lib;};
    browser = uwsmWrap (exe pkgs.brave);
    hyprlock = uwsmWrap (exe pkgs.hyprlock);
    hyprlauncher = uwsmWrap (exe pkgs.hyprlauncher);
    term = uwsmWrap (exe config.programs.kitty.package);
    vpn = uwsmWrap (exe pkgs.proton-vpn);
    dms = exe' inputs.dankMaterialShell.packages.${pkgs.stdenv.hostPlatform.system}.default "dms";
  in {
    enable = true;
    configType = "lua";
    systemd. enable = false;
    extraConfig = ''
      hl.monitor({ output = "eDP-2", mode = "2560x1600@165", position = "0x0", scale = 1, vrr = 1 })
      hl.monitor({ output = "eDP-1", mode = "2560x1600@165", position = "0x0", scale = 1, vrr = 1 })
      hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

      hl.config({
        general = { gaps_in = 1, gaps_out = 1, border_size = 0, layout = "dwindle" },
        decoration = {
          rounding = 2,
          active_opacity = 1.0,
          inactive_opacity = 0.87,
          blur = { enabled = true, size = 5, passes = 4, new_optimizations = true, ignore_opacity = true },
        },
        animations = { enabled = true },
        dwindle = { preserve_split = true },
        misc = { vrr = 1, force_default_wallpaper = 0 },
        input = {
          kb_layout = "us",
          kb_options = "caps:swapescape",
          follow_mouse = 1,
          touchpad = { natural_scroll = true },
          sensitivity = 0.15,
        },
      })

      hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

      hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
      hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })

      hl.window_rule({ name = "windowrule-1", match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
      hl.window_rule({ name = "windowrule-2", match = { float = false, workspace = "f[1]" }, border_size = 0, rounding = 0 })
      hl.window_rule({ name = "windowrule-3", match = { class = "^(org.quickshell)$" }, float = true })
      hl.window_rule({ name = "windowrule-portal-float", match = { class = "^(xdg-desktop-portal)(.*)$" }, float = true })
      hl.window_rule({ name = "windowrule-portal-gtk-float", match = { title = "^(Open File|Open Folder|Save File|Select File)(.*)$" }, float = true })

      hl.layer_rule({ name = "layerrule-1", match = { namespace = "^(dms)$" }, no_anim = true })

      -- Audio
      hl.bind("XF86AudioRaiseVolume",   hl.dsp.exec_cmd("${dms} ipc call audio increment 3"), { repeating = true, locked = true })
      hl.bind("XF86AudioLowerVolume",   hl.dsp.exec_cmd("${dms} ipc call audio decrement 3"), { repeating = true, locked = true })
      hl.bind("XF86AudioMute",          hl.dsp.exec_cmd("${dms} ipc call audio mute"),        { repeating = true, locked = true })

      -- Brightness
      hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("${dms} ipc call brightness increment 5 backlight:amdgpu_bl2"), { repeating = true, locked = true })
      hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("${dms} ipc call brightness decrement 5 backlight:amdgpu_bl2"), { repeating = true, locked = true })

      -- Apps
      hl.bind("SUPER + space", hl.dsp.exec_cmd("${hyprlauncher}"))
      hl.bind("SUPER + TAB",   hl.dsp.exec_cmd("${dms} ipc call hypr toggleOverview"))
      hl.bind("SUPER + L",     hl.dsp.exec_cmd("${hyprlock}"))
      hl.bind("SUPER + T",     hl.dsp.exec_cmd("${defaultApp "x-scheme-handler/terminal"}"))
      hl.bind("SUPER + B",     hl.dsp.exec_cmd("${browser}"))

      -- Screenshots
      hl.bind("SUPER + P",         hl.dsp.exec_cmd("${screenshot} s"))
      hl.bind("SUPER + CTRL + P",  hl.dsp.exec_cmd("${screenshot} sf"))
      hl.bind("SUPER + ALT + P",   hl.dsp.exec_cmd("${screenshot} m"))
      hl.bind("Print",             hl.dsp.exec_cmd("${screenshot} p"))

      -- Window management
      hl.bind("SUPER + Q",               hl.dsp.window.close())
      hl.bind("SUPER + ALT + SHIFT + Q", hl.dsp.exec_cmd("${uwsm} stop"))
      hl.bind("SUPER + ALT + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
      hl.bind("SUPER + V",               hl.dsp.window.float({ action = "toggle" }))
      hl.bind("SUPER + F11",             hl.dsp.window.fullscreen())

      -- Focus (direction)
      hl.bind("SUPER + N",     hl.dsp.focus({ direction = "left" }))
      hl.bind("SUPER + left",  hl.dsp.focus({ direction = "left" }))
      hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
      hl.bind("SUPER + up",    hl.dsp.focus({ direction = "up" }))
      hl.bind("SUPER + down",  hl.dsp.focus({ direction = "down" }))

      -- Focus (workspace relative)
      hl.bind("SUPER + J", hl.dsp.focus({ workspace = "-1" }))
      hl.bind("SUPER + K", hl.dsp.focus({ workspace = "+1" }))

      -- Workspaces 1-10
      ${lib.concatMapStrings (i: let
        key =
          if i == 10
          then "0"
          else toString i;
      in ''
        hl.bind("SUPER + ${key}",         hl.dsp.focus({ workspace = ${toString i} }))
        hl.bind("SUPER + SHIFT + ${key}", hl.dsp.window.move({ workspace = ${toString i} }))
      '') (lib.range 1 10)}

      -- Mouse / drag
      hl.bind("SUPER + Z",         hl.dsp.window.drag(),   { mouse = true })
      hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
      hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

      -- Media
      hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("${dms} ipc call mpris next"))
      hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("${dms} ipc call mpris previous"))
      hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("${dms} ipc call mpris playPause"))
      hl.bind("XF86AudioStop",  hl.dsp.exec_cmd("${dms} ipc call mpris stop"))

      -- Autostart
      hl.on("hyprland.start", function()
        hl.exec_cmd("${browser}")
        hl.exec_cmd("${term} --hold sh -c 'tmux -u attach'", {workspace = "2"})
        hl.exec_cmd("${vpn}")
      end)
    '';
  };
}
