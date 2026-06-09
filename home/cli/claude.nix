{
  pkgs,
  lib,
  ...
}: {
  programs.claude-code = let
    node = lib.getExe' pkgs.nodejs-slim "node";
    notify = lib.getExe' pkgs.libnotify "notify-send";
    caveman =
      pkgs.fetchFromGitHub
      {
        owner = "JuliusBrussee";
        repo = "caveman";
        rev = "v1.8.2";
        sha256 = "sha256-Jlfas2MPoQx3pOw+yKCta8kYlOEY27SP5NXJtSL+GGI=";
      };
  in {
    enable = true;
    plugins = [
      caveman
    ];
    settings = {
      statusLine = {
        type = "command";
        command = "bash ${caveman}/src/hooks/caveman-statusline.sh";
      };

      hooks = {
        Notification = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "${notify} -u normal 'Claude Code' 'Attention needed'";
              }
            ];
          }
        ];
        SessionStart = [
          {
            hooks = [
              {
                type = "command";
                command = "${node} ${caveman}/src/hooks/caveman-activate.js";
                timeout = 5;
                statusMessage = "Loading caveman mode...";
              }
            ];
          }
        ];
        UserPromptSubmit = [
          {
            hooks = [
              {
                type = "command";
                command = "${node} ${caveman}/src/hooks/caveman-mode-tracker.js";
                timeout = 5;
                statusMessage = "Tracking caveman mode...";
              }
            ];
          }
        ];
      };
    };
  };
}
