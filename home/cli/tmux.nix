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
    terminal = "screen-256color";
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
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on' # enable tmux-continuum functionality
        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on' # allow tmux-ressurect to capture pane contents
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
