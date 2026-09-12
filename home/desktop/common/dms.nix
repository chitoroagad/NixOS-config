{
  config,
  lib,
  ...
}: let
  cfg = config.mine.desktop.dms;
in {
  options.mine.desktop.dms = {
    enable = lib.mkEnableOption "dms";
    island.enable = lib.mkEnableOption "the DankMaterialShell 1.6 Dank Island";
  };

  config = lib.mkIf cfg.enable {
    programs.dank-material-shell = {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
      enableSystemMonitoring = true;
      enableVPN = false;
      enableDynamicTheming = false;
      enableAudioWavelength = false;
      enableCalendarEvents = false;
      enableClipboardPaste = true;

      # Owns settings.json outright, so the in-shell Settings GUI is read-only.
      settings =
        {
          # Pinned so DMS does not replay migrations over this file.
          configVersion = 17;

          currentThemeName = "custom";
          currentThemeCategory = "registry";
          customThemeFile = "${config.home.homeDirectory}/.config/DankMaterialShell/themes/catppuccin/theme.json";
          cornerRadius = 13;
          clockFormat = "24h";
          animationSpeed = 4;
          customAnimationDuration = 100;
          barElevationEnabled = false;
          controlCenterShowVpnIcon = false;
          runningAppsCurrentWorkspace = false;
          useAutoLocation = true;
          networkPreference = "wifi";

          cursorSettings = {
            theme = "System Default";
            size = 24;
            niri = {
              hideWhenTyping = false;
              hideAfterInactiveMs = 0;
            };
            hyprland = {
              hideOnKeyPress = false;
              hideOnTouch = false;
              inactiveTimeout = 0;
            };
            dwl.cursorHideTimeout = 0;
          };

          launcherLogoMode = "os";
          fontFamily = "Fira Sans";
          monoFontFamily = "JetBrainsMono Nerd Font";
          fontWeight = 500;
          fontScale = 1.09;
          soundsEnabled = false;
          acSuspendBehavior = 2;
          lockBeforeSuspend = true;
          loginctlLockIntegration = false;
          fadeToLockEnabled = false;
          launchPrefix = "uwsm-app -- ";
          matugenTemplateNeovim = true;
          lockScreenShowPowerActions = false;
          maxFprintTries = 3;
          osdPosition = 7;
          osdPowerProfileEnabled = true;
          powerActionHoldDuration = 0;
          powerMenuActions = [
            "reboot"
            "logout"
            "poweroff"
            "lock"
            "suspend"
            "restart"
            "hibernate"
          ];
          powerMenuDefaultAction = "poweroff";
          screenPreferences.wallpaper = [];

          barConfigs = [
            {
              id = "default";
              name = "Main Bar";
              enabled = true;
              position = 0; # Top
              screenPreferences = ["all"];
              showOnLastDisplay = true;
              leftWidgets = [
                "launcherButton"
                "workspaceSwitcher"
                "focusedWindow"
                {
                  id = "runningApps";
                  enabled = true;
                }
              ];
              centerWidgets = [
                {
                  id = "music";
                  enabled = true;
                }
                {
                  id = "clock";
                  enabled = true;
                  clockCompactMode = false;
                }
                "weather"
              ];
              rightWidgets = [
                {
                  id = "systemTray";
                  enabled = true;
                }
                {
                  id = "idleInhibitor";
                  enabled = true;
                }
                {
                  id = "clipboard";
                  enabled = true;
                }
                {
                  id = "memUsage";
                  enabled = true;
                }
                {
                  id = "cpuUsage";
                  enabled = true;
                }
                {
                  id = "network_speed_monitor";
                  enabled = true;
                }
                {
                  id = "notificationButton";
                  enabled = true;
                }
                {
                  id = "battery";
                  enabled = true;
                }
                {
                  id = "controlCenterButton";
                  enabled = true;
                }

                # Suggestions, uncomment to add:
                # { id = "privacyIndicator"; enabled = true; }
                # { id = "cpuTemp"; enabled = true; }
                # { id = "gpuTemp"; enabled = true; }
                # { id = "diskUsage"; enabled = true; }
                # { id = "notepadButton"; enabled = true; }
                # { id = "colorPicker"; enabled = true; }
                # { id = "powerMenuButton"; enabled = true; }
                # { id = "separator"; enabled = true; }
              ];
              spacing = 0;
              innerPadding = 13;
              bottomGap = -4;
              transparency = 0;
              widgetTransparency = 1;
              squareCorners = false;
              noBackground = true;
              gothCornersEnabled = false;
              gothCornerRadiusOverride = false;
              gothCornerRadiusValue = 12;
              borderEnabled = false;
              borderColor = "surfaceText";
              borderOpacity = 1;
              borderThickness = 1;
              widgetOutlineEnabled = false;
              widgetOutlineColor = "primary";
              widgetOutlineOpacity = 1;
              widgetOutlineThickness = 1;
              fontScale = 1.4;
              autoHide = false;
              autoHideDelay = 250;
              openOnOverview = false;
              visible = true;
              popupGapsAuto = true;
              popupGapsManual = 4;
              maximizeDetection = true;
              widgetPadding = 5;
            }
          ];
        }
        // lib.optionalAttrs cfg.island.enable {
          # Mutually exclusive with dankIslandBarId; a generated file bypasses the set() guard.
          frameEnabled = false;
          # Renders the "default" bar as the island; its left/right widgets become satellites.
          dankIslandBarId = "default";

          # Floating would zero the exclusive zone and let windows tile under the island.
          dankIslandFloating = false;

          # 2 + 52 + 2 = 56 keeps the pill and satellites aligned with equal 2px margins.
          dankIslandCompactHeight = 48;
          dankIslandOuterGap = 2;
          dankIslandReserveHeight = 56;

          # Top layer, so the island does not cover fullscreen windows.
          dankIslandUseOverlayLayer = false;
          dankIslandInteractionMode = "hybrid"; # or "click"
          dankIslandPalette = "default";

          # Alpha, not transparency: 1 is opaque, 0 fully see-through.
          dankIslandTransparency = 0.75;

          # High contrast would override the transparency above.
          dankIslandHighContrast = false;
          dankIslandCornerRadius = 34;
          dankIslandSatellitesEnabled = true;
          # The island ignores centerWidgets and renders these slots instead.
          dankIslandHomeLayout = [
            {
              id = "media";
              enabled = true;
            }
            {
              id = "clock";
              enabled = true;
            }
            {
              id = "weather";
              enabled = true;
            }
            {
              id = "status";
              enabled = false;
            }
            {
              id = "volume";
              enabled = false;
            }
            {
              id = "brightness";
              enabled = false;
            }
            {
              id = "notifications";
              enabled = true;
            }
          ];
        };
    };
  };
}
