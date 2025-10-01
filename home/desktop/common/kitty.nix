{
  pkgs,
  config,
  ...
}: {
  xdg.mimeApps = {
    associations.added = {
      "x-scheme-handler/terminal" = "kitty.desktop";
    };
    defaultApplications = {
      "x-scheme-handler/terminal" = "kitty.desktop";
    };
  };

  programs.kitty = let
    latest_kitty_no_fish = pkgs.kitty.overrideAttrs (old: rec {
      version = "0.43.1";
      src = pkgs.fetchFromGitHub {
        owner = "kovidgoyal";
        repo = "kitty";
        rev = "v${version}";
        hash = "sha256-YDfKYzj5LRx1XaKUpBKo97CMW4jPhVQq0aXx/Qfcdzo=";
      };

      # ignore broken test
      preCheck = ''
        substituteInPlace kitty_tests/shell_integration.py \
          --replace test_fish_integration no_test_fish_integration
      '';
    });
  in {
    enable = true;
    package = latest_kitty_no_fish;
    font = {
      name = config.fontProfiles.monospace.family;
      size = 20;
      package = config.fontProfiles.monospace.package;
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
      clipboard_control = "write-primary write-clipboard no-append";
    };
  };
}
