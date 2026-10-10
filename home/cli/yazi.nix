{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.cli.yazi.enable = lib.mkEnableOption "yazi";

  config = lib.mkIf config.mine.cli.yazi.enable {
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
      package = pkgs.yazi;
      shellWrapperName = "yy";
      # recents.yazi shells out to xmlstarlet to edit recently-used.xbel
      extraPackages = [pkgs.xmlstarlet];
      plugins.recents = pkgs.fetchFromGitHub {
        owner = "nmetschke";
        repo = "recents.yazi";
        rev = "c21466b751daac464bef519c67b4ea0266ec1743";
        hash = "sha256-y8qoiz+mPOgEfQSkWTVTDXLyKYttcijK2r3EBIAe+P4=";
      };
      vfs.recents."*" = {
        kind = "hub";
        run = "recents";
      };
      keymap.mgr.prepend_keymap = [
        {
          on = ["g" "r"];
          run = ["plugin recents" "sort mtime --reverse=yes" "linemode mtime"];
          desc = "Go to recently used";
        }
        {
          on = ["o"];
          run = ["plugin recents modify" "open"];
          desc = "Open selected files and add to recently used";
        }
      ];
      settings = {
        plugin = {
          prepend_fetchers = [
            {
              group = "mime";
              prio = "high";
              run = "recents";
              url = "recents://*";
            }
          ];
          prepend_preloaders = [
            {
              mime = "recents/**";
              run = "recents";
            }
          ];
          prepend_previewers = [
            {
              mime = "recents/**";
              run = "recents";
            }
          ];
        };
        opener = {
          edit = [
            {
              run = lib.getExe pkgs.neovim + " %s";
              block = true;
              for = "unix";
              desc = "Edit file";
            }
          ];
          play = [
            {
              run = lib.getExe pkgs.vlc + " %s";
              orphan = true;
              for = "unix";
              desc = "Play file";
            }
          ];
          open = [
            {
              run = (lib.getExe' pkgs.xdg-utils "xdg-open") + " %s";
              orphan = true;
              for = "unix";
              desc = "Open";
            }
          ];
        };
      };
    };
  };
}
