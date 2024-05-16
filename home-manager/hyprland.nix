{
	inputs,
	lib,
	config,
	pkgs,
	...
} : {
	imports = [];

	xdg.portal = let
		hyprland = config.wayland.windowManager.hyprland.package;
		xdph = pkgs.xdg-desktop-portal-hyprland.override { inherit hyprland; };
	in {
		extraPortals = [ xdph ];
		configPackages = [ hyprland ];
	};

	home.packages = with pkgs; [
		hyprpicker
	];

	wayland.windowManager.hyprland = {
		enable = true;
		systemd = {
			enable = true;
			variables = ["--all"];
		};

		settings = let
			# active = "0xaa${lib.removePrefix "#" config.colorscheme.colors.primary}";
			# inactive = "0xaa${lib.removePrefix "#" config.colorscheme.colors.surface_bright}";
		in {
			general = {
				cursor_inactive_timeout = 4;
				gaps_in = 5;
				gaps_out = 5;
				border_size = 2;
				# "col.border_active" = active;
				# "col.border_inactive" = inactive;
				layout = "dwindle";
			};
			decoration = {
				rounding = 10;
				blur = {
					enabled = true;
					size = 10;
					passes = 1;
				};
			};
			animations = {
				enabled = "yes";
			};
			dwindle = {
				preserve_split = "yes";
			};
			gestures = {
				workspace_swipe = "on";
			};
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
				sensitivity = 0.2;
			};
			bind = let
				defaultApp = type: "${lib.getExe pkgs.handlr-regex} launch ${type}";
				notify-send = lib.getExe' pkgs.libnotify "nofity-send";
				wpctl = lib.getExe' pkgs.wireplumber "wpctl";
				grimblast = lib.getExe inputs.hyprland-contrib.packages.${pkgs.system}.grimblast;
			in [
				# Lauch Terminal
				"$mainMod, T, exec, ${defaultApp "x-scheme-handler/terminal"}"

				# Brightness Control
				", XF86BrightnessUp, exec, brightnessctl set 5%+"
				", XF86BrightnessDown, exec, birghtnessctl set 5%-"

				# Volume Control
				", XF86AudioRaiseVolume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%+"
				", XF86AudioLowerVolume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
				", XF86AudioMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"

				# Screenshotting
				", Print, exec, ${grimblast} --notify --copy output"
				"$mainMod, P, exec, ${grimblast} --notify --copy area"
			];
		};

	};
}
