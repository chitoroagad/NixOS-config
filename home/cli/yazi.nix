{
  pkgs,
  lib,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      opener = {
        edit = [
          {
            run = "${lib.getExe pkgs.neovim} \"$@\"";
            block = true;
            for = "unix";
            desc = "Edit file";
          }
        ];
        play = [
          {
            run = "${lib.getExe' pkgs.vlc "vlc"} \"$@\"";
            orphan = true;
            for = "unix";
            desc = "Play file";
          }
        ];
        open = [
          {
            run = "${lib.getExe' pkgs.xdg-utils "xdg-open"} \"$@\"";
            orphan = true;
            for = "unix";
            desc = "Open";
          }
        ];
      };
    };
  };
}
