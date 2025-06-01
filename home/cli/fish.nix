{pkgs, ...}: {
  programs.fish = {
    enable = true;
    preferAbbrs = true;
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
      clear = "command clear; commandline -f clear-screen"; 
    };

    shellInit = ''
      fish_vi_key_bindings

      set -Ux fifc_editor nvim

      set -Ux MANPAGER 'sh -c "col -bx | bat -l man -p"'
      set -Ux MANROFFOPT "-c";

      set -U fish_greeting
    '';

    interactiveShellInit = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
        # ${pkgs.any-nix-shell}/bin/any-nix-shell fish | source

      # fix starship add_newline issue https://github.com/starship/starship/issues/560
      function prompt_newline --on-event fish_postexec
        echo
      end
    '';

    functions = {
      fzf-bcd-widget = {
        description = "cd backwards";
        body = ''
          pwd | awk -v RS=/ '/\n/ {exit} {p=p $0 "/"; print p}' | tac | eval (__fzfcmd) +m --select-1 --exit-0 $FZF_BCD_OPTS | read -l result
          [ "$result" ]; and cd $result
          commandline -f repaint
        '';
      };

      fzf-cdhist-widget = {
        description = "cd to one of the previously visited locations";
        body = ''
          # Clear non-existent folders from cdhist.
           set -l buf
           for i in (seq 1 (count $dirprev))
             set -l dir $dirprev[$i]
             if test -d $dir
               set buf $buf $dir
             end
           end
           set dirprev $buf
           string join \n $dirprev | tac | sed 1d | eval (__fzfcmd) +m --tiebreak=index --toggle-sort=ctrl-r $FZF_CDHIST_OPTS | read -l result
           [ "$result" ]; and cd $result
           commandline -f repaint
        '';
      };

      fzf-complete = {
        description = "fzf completion and print selection back to commandline";
        body = ''
          # As of 2.6, fish's "complete" function does not understand
          # subcommands. Instead, we use the same hack as __fish_complete_subcommand and
          # extract the subcommand manually.
          set -l cmd (commandline -co) (commandline -ct)
          switch $cmd[1]
            case env sudo
              for i in (seq 2 (count $cmd))
                switch $cmd[$i]
                  case '-*'
                  case '*=*'
                  case '*'
                    set cmd $cmd[$i..-1]
                    break
                end
              end
          end
          set cmd (string join -- ' ' $cmd)

          set -l complist (complete -C$cmd)
          set -l result
          string join -- \n $complist | sort | eval (__fzfcmd) -m --select-1 --exit-0 --header '(commandline)' | cut -f1 | while read -l r; set result $result $r; end

          set prefix (string sub -s 1 -l 1 -- (commandline -t))
          for i in (seq (count $result))
            set -l r $result[$i]
            switch $prefix
              case "'"
                commandline -t -- (string escape -- $r)
              case '"'
                if string match '*"*' -- $r >/dev/null
                  commandline -t --  (string escape -- $r)
                else
                  commandline -t -- '"'$r'"'
                end
              case '~'
                commandline -t -- (string sub -s 2 (string escape -n -- $r))
              case '*'
                commandline -t -- (string escape -n -- $r)
            end
            [ $i -lt (count $result) ]; and commandline -i ' '
          end

          commandline -f repaint
        '';
      };

      fco = {
        description = "Fuzzy-find and checkout a branch";
        body = "git branch --all | grep -v HEAD | string trim | fzf | read -l result; and git checkout \"$result\"";
      };

      fco1 = {
        description = "Use `fzf` to choose which branch to check out";
        body = ''
          set -q branch[1]; or set branch '''
          git for-each-ref --format='%(refname:short)' refs/heads | fzf --height 10% --layout=reverse --border --query=$branch --select-1 | xargs git checkout
        '';
      };

      fcoc = {
        description = "Fuzzy-find and checkout a commit";
        body = "git log --pretty=oneline --abbrev-commit --reverse | fzf --tac +s -e | awk '{print $1;}' | read -l result; and git checkout \"$result\"";
      };

      snag = {
        description = "Pick desired files from a chosen branch";
        body = ''
          # use fzf to choose source branch to snag files FROM
          set branch (git for-each-ref --format='%(refname:short)' refs/heads | fzf --height 20% --layout=reverse --border)
          # avoid doing work if branch isn't set
          if test -n "$branch"
            # use fzf to choose files that differ from current branch
            set files (git diff --name-only $branch | fzf --height 20% --layout=reverse --border --multi)
          end
          # avoid checking out branch if files aren't specified
          if test -n "$files"
            git checkout $branch $files
          end
        '';
      };

      fzum = {
        description = "View all unmerged commits across all local branches";
        body = ''
          set viewUnmergedCommits "echo {} | head -1 | xargs -I BRANCH sh -c 'git log master..BRANCH --no-merges --color --format="%C(auto)%h - %C(green)%ad%Creset - %s" --date=format:\'%b %d %Y\'''"

          git branch --no-merged master --format "%(refname:short)" | fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$viewUnmergedCommits"
        '';
      };

      fssh = {
        description = "Fuzzy-find ssh host via ag and ssh into it";
        body = "ag --ignore-case '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf | read -l result; and ssh \"$result\"";
      };

      fs = {
        description = "Switch tumx session";
        body = "tmux list-sessions -F \"#{session_name}\" | fzf | read -l result; and tmux switch-client -t \"$result\"";
      };

      pathclean = {
        description = "Clean up PATH variable";
        body = "set PATH (printf \"%s\" \"$PATH\" | awk -v RS=':' '!a[$1]++ { if (NR > 1) printf RS; printf $1 }')";
      };

      # Fix starship new line on empty terminal https://github.com/starship/starship/issues/560
      prompt_newline = {
        onEvent = "fish_postexec";
        body = "echo";
      };
    };

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
