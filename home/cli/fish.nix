{pkgs, ...}: {
  programs.fish = {
    enable = true;
    # preferAbbrs = true;
    shellAbbrs = {
      cat = "bat";
      tp = "trash-put";
      open = "xdg-open";
      l = "eza -alh";
    };
    shellAliases = {
      cd = "z";
      cdi = "zi";
      git-tree = "git log --graph --pretty=oneline --abbrev-commit";
    };

    shellInit = ''
      fish_vi_key_bindings

      set -Ux fifc_editor nvim

      set -Ux MANPAGER 'sh -c "col -bx | bat -l man -p"'
      set -Ux MANROFFOPT "-c";

      set -U fish_greeting
    '';

    interactiveShellInit = ''
      # ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish | source
    '';

    plugins = with pkgs.fishPlugins; [
      {
        name = "sponge";
        src = sponge;
      }
      {
        name = "git-abbr";
        src = git-abbr;
      }
      {
        name = "puffer";
        src = puffer;
      }
      {
        name = "fifc";
        src = pkgs.fetchFromGitHub {
          owner = "gazorby";
          repo = "fifc";
          rev = "a01650cd432becdc6e36feeff5e8d657bd7ee84a";
          sha256 = "sha256-Ynb0Yd5EMoz7tXwqF8NNKqCGbzTZn/CwLsZRQXIAVp4=";
        };
      }
    ];
  };
}
