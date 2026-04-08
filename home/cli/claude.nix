{
  pkgs,
  lib,
  ...
}: {
  programs.claude-code = let
    notify = lib.getExe' pkgs.libnotify "notify-send";
  in {
    enable = true;
    hooks = {
      PermissionRequest = ''
        #!/usr/bin/env bash
        ${notify} 'Claude Code' 'Needs your input'
      '';
      Stop = ''
        #!/usr/bin/env bash
        ${notify} 'Claude Code' 'Task completed'
      '';
    };
  };
}
