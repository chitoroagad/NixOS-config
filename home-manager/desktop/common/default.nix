{ 
	lib,
	pkgs,
	config,
	...
}: {
	imports = [
		./kitty.nix
		./font.nix
		./playerctl.nix
		./mako.nix
	];

	home.packages = with pkgs; [
		libnotify
		wl-clipboard
	];

	dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

	xdg = {
		portal.enable = true;
		mimeApps.enable = true;
		configFile."mimeapps.list".force = true;
	};

}
