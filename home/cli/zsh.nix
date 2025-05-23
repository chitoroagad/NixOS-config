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
      ignoreSpace = true;
      path = "$ZDOTDIR/.zsh_history";
      save = 1000000;
      size = 1000000;
      share = true;
    };

    initContent = lib.mkMerge [
      ''
        # autoSuggestions config

        unsetopt correct # autocorrect commands

        setopt inc_append_history # save history entries as soon as they are entered

        # auto complete options
        # setopt auto_list # automatically list choices on ambiguous completion
        # setopt auto_menu # automatically use menu completion
        zstyle ':completion:*' group-name "" # group results by category
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # completions not case sensitive
        zstyle ':completion:*' list-colors "$\{(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

        # Extra history options
        setopt hist_find_no_dups
        bindkey '^p' history-search-backwards
        bindkey '^n' history-search-forwards
      ''
    ];

    shellAliases = {
      cat = "bat";
      cd = "z";
      cdi = "zi";
      tp = "trash-put";
      open = "xdg-open";
      git-tree = "git log --graph --pretty=oneline --abbrev-commit";
    };

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
      {
        name = "zsh-fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
        file = "fzf-tab.zsh";
      }
      # {
      #   name = "fzf-zsh";
      #   src = "${pkgs.fzf-zsh}/share/fzf-zsh";
      #   file = "fzf.zsh";
      # }
    ];
  };
}
