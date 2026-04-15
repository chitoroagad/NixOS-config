{
  pkgs,
  lib,
  ...
}: {
  programs.claude-code = let
    notify = lib.getExe' pkgs.libnotify "notify-send";
  in {
    enable = true;
    plugins = [
      (pkgs.fetchFromGitHub
      {
        owner = "JuliusBrussee";
        repo = "caveman";
        rev = "v1.6.0";
        sha256 = "sha256-m7HhCW4fXU5pIYRWVP6cvSYUkDHt8R90D9UI3tT7euk=";
      })
    ];
    settings = {
      hooks = {
        Notification = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "${notify} -u 'Claude Code' 'Attention needed'";
              }
            ];
          }
        ];
      };
    };
  };
}
