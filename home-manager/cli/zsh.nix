{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
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
      if! pgrep -f Hyprland > /dev/null; then
          Hyprland
      fi
    '';
    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-autosuggestions"
      ];
    };
  };
}
