{
  pkgs,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;
    enableTransience = true;
    settings = {
      format = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_status"

        "$fill"

        "$jobs"
        "$bun"
        "$c"
        "$cpp"
        "$python"
        "$rust"
        "$nix_shell"
        "$direnv"
        "$line_break"
        "$character"
      ];

      add_newline = false;

      right_format = lib.concatStrings [
        "$cmd_duration"
      ];

      fill = {
        symbol = " ";
      };

      directory = {
        style = "bold blue";
        truncation_length = 4;
        read_only = " ";
      };

      git_branch = {
        format = "[$symbol$branch(:$remote_branch)]($style) ";
        style = "bold green";
      };

      git_commit = {
        format = "@[$hash]($style) ";
        style = "purple";
        commit_hash_length = 5;
      };

      git_state = {
        format = "[$state( $progress_current/$progress_total)]($style) ";
        style = "red";
      };

      git_status = {
        format = "([$all_status$ahead_behind]($style) )";
        conflicted = "=$count";
        ahead = "[⇡$count](bold green) ";
        behind = "[⇣$count](bold green) ";
        diverged = "[⇣⇡$count](bold green) ";
        untracked = "[?$count](bold blue) ";
        stashed = "[*$count](bold green) ";
        modified = "[!$count](bold #f5a97f) ";
        staged = "[+$count](bold yellow) ";
        deleted = "$count ";
      };

      bun = {
        format = "[$symbol($version )]($style) ";
        symbol = " ";
      };

      c = {
        format = "[$symbol($version(-$name) )]($style) ";
        symbol = " ";
      };

      cpp = {
        format = "[$symbol($version(-$name) )]($style) ";
        symbol = " ";
      };

      python = {
        format = "[$symbol$pyenv_prefix($version )(($virtualenv) )]($style) ";
        symbol = " ";
      };

      rust = {
        format = "[$symbol($version )]($style) ";
        symbol = " ";
      };

      cmd_duration = {
        format = "[$duration]($style) ";
        style = "dimmed white";
      };

      direnv = {
        format = "[$symbol]($style) ";
        symbol = " ";
        disabled = false;
      };

      jobs = {
        style = "bold green";
        symbol = "";
      };

      nix_shell = {
        format = "[$symbol$state]($style) ";
        symbol = "󱄅 ";
        # heuristic = true;
      };
    };
  };
}
