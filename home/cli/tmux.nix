{
  pkgs,
  config,
  ...
}: let
  resurrect_dir_path = "${config.xdg.dataHome}/tmux/resurrect";
in {
  catppuccin.tmux.enable = false; # let me do my own config

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    historyLimit = 50000;
    keyMode = "vi";
    mouse = true;
    clock24 = true;
    prefix = "C-a";
    sensibleOnTop = true;
    terminal = "tmux-256color";
    disableConfirmationPrompt = true;
    # secureSocket = false;
    newSession = true;
    focusEvents = true;
    escapeTime = 0;
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour '${config.catppuccin.flavor}'
          set -g @catppuccin_window_status_style "rounded"
          set -g @catppuccin_status_fill "icon"
          # set -g @catppuccin_status_background "none"
        '';
      }
      cpu
      # {
      #   plugin = resurrect;
      #   extraConfig = ''
      #     set -g @resurrect-strategy-nvim 'session'
      #     set -g @resurrect-strategy-vim 'session'
      #     set -g @resurrect-capture-pane-contents 'on'
      #
      #     set -g @resurrect-dir ${resurrect_dir_path}
      #     set -g @resurrect-hook-post-save-all 'sed -i -E "s|(pane.*nvim\s*:)[^;]+;.*\s([^ ]+)$|\1nvim \2|" ${resurrect_dir_path}/last'
      #   '';
      # }
      vim-tmux-navigator
      {
        plugin = yank;
        extraConfig = ''
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
          unbind -T copy-mode-vi MouseDragEnd1Pane # don't exit copy mode after dragging with mouse
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on' # enable tmux-continuum functionality
          set -g @continuum-save-interval '10'
        '';
      }
    ];
    extraConfig = ''
      # Extra display config
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left "#{E:@catppuccin_status_session}"
      set -g status-right "#{E:@catppuccin_status_application}"
      set -agF status-right "#{E:@catppuccin_status_cpu}"

      set-option -g detach-on-destroy off

      # binding to max min pane
      bind -r m resize-pane -Z

      # bindings for resizing windows
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5

      # bindings for splitting windows in currect dir
      unbind %
      bind | split-window -h -c "#{pane_current_path}"
      unbind '"'
      bind - split-window -v -c "#{pane_current_path}"

      # set termguicolors to work
      set-option -sa terminal-overrides ",xterm*:Tc"

      # misc
      set -g renumber-windows on
      set -g set-clipboard on
      set -g status-position top
    '';
  };
}
