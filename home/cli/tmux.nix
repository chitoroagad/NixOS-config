{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.cli.tmux.enable = lib.mkEnableOption "tmux";

  config = lib.mkIf config.mine.cli.tmux.enable {
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
      shell = lib.getExe pkgs.fish; # TODO: make this dynamic
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

    # tmux server as a user unit. Sources hm-session-vars.sh rather than using
    # a login shell, so ~/.zshrc is not loaded; add -l to bash if that is ever
    # needed. Sourcing it is also what puts TMUX_TMPDIR on the server, so it
    # listens on the same socket an interactive shell looks for.
    systemd.user.services.tmux = {
      Unit.Description = "tmux server";

      Service = {
        Type = "forking";
        Restart = "always";
        ExecStart = "${lib.getExe pkgs.bash} -c 'source ${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh; exec ${lib.getExe config.programs.tmux.package} start-server'";
        ExecStop = "${lib.getExe config.programs.tmux.package} kill-server";
      };

      Install.WantedBy = ["default.target"];
    };
  };
}
