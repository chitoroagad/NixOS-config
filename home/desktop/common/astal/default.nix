{
  pkgs,
  astal,
  agsv2,
}: let
  ags = agsv2;
in {
  packages.${pkgs.system}.default = pkgs.stdenvNoCC.mkDerivation rec {
    name = "way-shell";
    src = ./.;

    nativeBuildInputs = [
      ags.packages.${pkgs.system}.default
      pkgs.wrapGAppsHook
      pkgs.gobject-introspection
    ];

    buildInputs = with astal.packages.${pkgs.system}; [
      astal4
      io
      apps
      auth
      battery
      bluetooth
      hyprland
      mpris
      network
      notifd
      powerprofiles
      wireplumber
    ];

    installPhase = ''
      mkdir -p $out/bin
      ags bundle app.ts $out/bin/${name}
    '';
  };
}
