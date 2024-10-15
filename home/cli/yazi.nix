{
  pkgs,
  lib,
  ...
}: {
  # xdg.desktopEntries.yazi = {
  #   name = "Yazi";
  #   genericName = "File Manager";
  #   icon = "yazi";
  #   comment = "Blazing fast terminal file manager written in Rust, based on async I/O";
  #   terminal = true;
  #   exec = "kitty -e yazi";
  #   type = "Application";
  #   mimeType = ["inode/directory"];
  #   categories = ["Utility" "Core" "System" "FileTools" "FileManager" "ConsoleOnly"];
  #   settings = {
  #     Keywords = "File;Manager;Explorer;Browser;Launcher";
  #     TryExec = "yazi";
  #   };
  # };

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
