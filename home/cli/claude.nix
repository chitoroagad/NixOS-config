{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.cli.claude.enable = lib.mkEnableOption "claude";

  config = lib.mkIf config.mine.cli.claude.enable {
    programs.claude-code = let
      officialPlugins = pkgs.fetchFromGitHub {
        owner = "anthropics";
        repo = "claude-plugins-official";
        rev = "f359d43b406057f1a8cdbc4ea93b827642c162e6";
        hash = "sha256-f5mnVFXVkaMoahQv5pu5fS0gGV1uaowi/mpJM0gm/I8=";
      };
      caveman = pkgs.fetchFromGitHub {
        owner = "JuliusBrussee";
        repo = "caveman";
        rev = "v3.2.0";
        hash = "sha256-GfC8e+EGL7kotZQfZ9kD7ZEWJfhmXujHOHpMxeU3bEo=";
      };

      # Git branch, caveman badge and ponytail badge.
      statusline = pkgs.writeShellApplication {
        name = "claude-statusline";
        runtimeInputs = with pkgs; [coreutils git jq];
        text = ''
          input=$(cat)
          dir=$(jq -r '.workspace.current_dir // .cwd // empty' <<<"$input")
          project=$(jq -r '.workspace.project_dir // empty' <<<"$input")
          cfg="''${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
          parts=()

          if [ -n "$dir" ] && branch=$(
            git -C "$dir" --no-optional-locks symbolic-ref --short -q HEAD 2>/dev/null ||
              git -C "$dir" --no-optional-locks rev-parse --short HEAD 2>/dev/null
          ); then
            parts+=("$(printf '\033[38;5;110m%s\033[0m' "$branch")")
          fi

          badge=$(${lib.getExe pkgs.bash} ${caveman}/src/hooks/caveman-statusline.sh <<<"$input")
          [ -n "$badge" ] && parts+=("$badge")

          # ponytail is not managed here; it keeps its mode per project under
          # ponytail-modes/<sha256 of project dir>. Its shared .ponytail-active
          # flag leaks into unrelated projects, so it is not read.
          if [ -n "$project" ]; then
            flag="$cfg/ponytail-modes/$(printf '%s' "$project" | sha256sum | cut -d' ' -f1)"
            if [ -f "$flag" ] && [ ! -L "$flag" ]; then
              mode=$(head -c 64 "$flag" | tr -cd 'a-z0-9-')
              case "$mode" in
                "" | off) ;;
                full) parts+=("$(printf '\033[38;5;108m[PONYTAIL]\033[0m')") ;;
                ultra) parts+=("$(printf '\033[38;5;173m[PONYTAIL:ULTRA]\033[0m')") ;;
                *) parts+=("$(printf '\033[38;5;108m[PONYTAIL:%s]\033[0m' "''${mode^^}")") ;;
              esac
            fi
          fi

          printf '%s' "''${parts[*]}"
        '';
      };
    in {
      enable = true;
      # Merge into the writable settings.json so in-app changes keep working.
      mutableSettings = true;
      settings = {
        editorMode = "vim";
        statusLine = {
          type = "command";
          command = lib.getExe statusline;
        };
      };
      plugins = {
        inherit caveman;
        frontend-design = "${officialPlugins}/plugins/frontend-design";
      };
    };

    # caveman's hooks run under node and silently skip when it is missing.
    home.packages = [pkgs.nodejs-slim];
  };
}
