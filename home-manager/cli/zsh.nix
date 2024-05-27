{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.zsh = {
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
