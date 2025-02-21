{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    historyLimit = 5000;
    keyMode = "vi";
    mouse = true;
    clock24 = true;
    newSession = true;
    prefix = "C-a";
    sensibleOnTop = true;
    terminal = "tmux-256color";
    disableConfirmationPrompt = true;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = yank;
        extraConfig = ''
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
        '';
      }
      {
        plugin = vim-tmux-navigator;
      }
      # {
      #   plugin = resurrect;
      #   extraConfig = ''
      #     resurrect_dir="$HOME/.tmux/resurrect"
      #     set -g @resurrect-dir $resurrect_dir
      #     set -g @resurrect-hook-post-save-all 'target=$(readlink -f $resurrect_dir/last); sed "s| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g; s|/home/$USER/.nix-profile/bin/||g" $target | sponge $target'
      #
      #     set -g @resurrect-capture-pane-contents 'on' # allow tmux-resurrect to capture pane contents
      #     set -g @resurrect-strategy-nvim 'session'
      #   '';
      # }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on' # enable tmux-continuum functionality
          set -g @continuum-boot 'on'  # starts tmux server on boot
        '';
      }
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
          set -g @catppuccin_status_modules_right "directory date_time"
          set -g @catppuccin_status_modules_left "session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator " "
          set -g @catppuccin_status_right_separator_inverse "no"
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_directory_text "#{b:pane_current_path}"
          set -g @catppuccin_date_time_text "%H:%M"
        '';
      }
    ];
    extraConfig = ''
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
      set -g escape-time 0
      set -g renumber-windows on
      set -g set-clipboard on
      set -g status-position top
    '';
  };
}
