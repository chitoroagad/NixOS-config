{
  pkgs,
  lib,
  ...
}: {
  programs.claude-code = let
    notify = lib.getExe' pkgs.libnotify "notify-send";
    caveman =
      pkgs.fetchFromGitHub
      {
        owner = "JuliusBrussee";
        repo = "caveman";
        rev = "v1.6.0";
        sha256 = "sha256-m7HhCW4fXU5pIYRWVP6cvSYUkDHt8R90D9UI3tT7euk=";
      };
  in {
    enable = true;
    plugins = [
      caveman
    ];
    settings = {
      statusLine = {
        type = "command";
        command = "bash ${caveman}/hooks/caveman-statusline.sh";
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
      };
    };
  };
}
