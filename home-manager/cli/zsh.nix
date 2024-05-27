{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.zsh = let
    zsh-plugins = import ./zsh-plugins.nix {inherit pkgs;};
  in {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    dotDir = ".config/zsh";
    history = {
      ignoreAllDups = true;
      path = "$ZSHDOTDIR/.zsh_history";
      save = 1000000;
      size = 10000000;
    };
    historySubstringSearch = {
      enable = true;
    };
    loginExtra = ''
      if ! pgrep -f Hyprland >/dev/null; then
          Hyprland
      fi
    '';
    plugins = [
      {
        name = "nix-shell";
        src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
      }
      {
        name = "you should use";
        src = "${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use";
      }
      {
        name = "zsh-vi-mode";
        src = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";
      }
      {
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
    ];

    # loginExtra = ''
    #   if! pgrep -f Hyprland > /dev/null;
    #       Hyprland
    #   fi
    # '';
    # "zsh-users/zsh-autosuggestions"
    # "zsh-users/zsh-syntax-highlighting"
    # "none9632/zsh-sudo"
    # "jeffreytse/zsh-vi-mode"
    # "MenkeTechnologies/zsh-cargo-completion"
    # "greymd/docker-zsh-completion"
    # "https://github.com/romkatv/powerlevel10k"
  };
}
