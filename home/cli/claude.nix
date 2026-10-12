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
    in {
      enable = true;
      plugins = {
        caveman = pkgs.fetchFromGitHub {
          owner = "JuliusBrussee";
          repo = "caveman";
          rev = "v3.2.0";
          hash = "sha256-GfC8e+EGL7kotZQfZ9kD7ZEWJfhmXujHOHpMxeU3bEo=";
        };
        frontend-design = "${officialPlugins}/plugins/frontend-design";
      };
    };

    # caveman's hooks run under node and silently skip when it is missing.
    home.packages = [pkgs.nodejs-slim];
  };
}
