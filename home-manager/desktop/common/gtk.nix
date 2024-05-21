{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit
    (builtins)
    hashString
    toJson
    ;
  rendersvg = pkgs.runCommand "rendersvg" {} ''
    mkdir -p $out/bin
    ln -s ${pkgs.resvg}/bin/resvg $out/bin/rendersvg
  '';
  candyTheme = name: colours:
    pkgs.stdenv.mkDerivation {
      name = "generated-gtk-theme";
      src = pkgs.fetchFromGitHub {
        owner = "EliverLara";
        repo = "Nordic";
        rev = "c30a0e8f107b641ed6c648466829345d2601e2d2";
        hash = "";
      };
    };
in {
  ting = true;
}
