{ config, ... }: 
{

	xdg.mimeApps = {
		associations.added = {
			"x-scheme-handler/terminal" = "kitty.desktop";
		};
		defaultApplications = {
			"x-scheme-handler/terminal" = "kitty.desktop";
		};
	};

	programs.kitty = {
		enable = true;
		theme = "Catppuccin-Mocha";
		font = {
			name = config.fontProfiles.monospace.family;
			size = 12;
		};
		settings = {
			scrollback_lines = 100000;
			window_padding_width = 2;
			window_padding_height = 5;
			background_opacity = "0.95";
			background_blur = 30;
			confirm_os_window_close = 0;
			enable_audio_bell = "no";
			allow_remote_control = "yes";
		};
	};
}
