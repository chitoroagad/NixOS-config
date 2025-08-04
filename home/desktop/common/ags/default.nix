{
  inputs,
  writeShellScript,
  system,
  stdenv,
  cage,
  swww,
  esbuild,
  dart-sass,
  fd,
  fzf,
  brightnessctl,
  accountsservice,
  slurp,
  wf-recorder,
  wl-clipboard,
  wayshot,
  swappy,
  hyprpicker,
  pavucontrol,
  networkmanager,
  gtk3,
  which,
}: let
  name = "asztal";

  ags = inputs.ags.packages.${system}.default.override {
    extraPackages = [stable.accountsservice];
  };

  # requires nixpkgs-stable as in input in flake.nix
  stable = import inputs.nixpkgs-stable {inherit system;};

  dependencies = [
    which
    dart-sass
    fd
    fzf
    brightnessctl
    swww
    inputs.matugen.packages.${system}.default
    slurp
    wf-recorder
    wl-clipboard
    wayshot
    swappy
    hyprpicker
    pavucontrol
    networkmanager
    gtk3
    system
  ];

  pinnedPackages = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/dab3a6e781554f965bde3def0aa2fda4eb8f1708";
    sha256 = "sha256-lFNVsu/mHLq3q11MuGkMhUUoSXEdQjCHvpReaGP1S2k=";
  }) {inherit system;};

  addBins = list: builtins.concatStringsSep ":" (builtins.map (p: "${p}/bin") list);

  desktop = writeShellScript name ''
    export PATH=$PATH:${addBins dependencies}
    ${ags}/bin/ags -b ${name} -c ${config}/config.js $@
  '';

  config = stdenv.mkDerivation {
    inherit name;
    src = ./.;

    buildPhase = ''
      ${stable.esbuild}/bin/esbuild \
        --bundle ./main.ts \
        --outfile=main.js \
        --format=esm \
        --external:resource://\* \
        --external:gi://\* \
    '';

    installPhase = ''
      mkdir -p $out
      cp -r assets $out
      cp -r style $out
      cp -r widget $out
      cp -f main.js $out/config.js
    '';
  };
in
  stdenv.mkDerivation {
    inherit name;
    src = config;

    installPhase = ''
      mkdir -p $out/bin
      cp -r . $out
      cp ${desktop} $out/bin/${name}
    '';
  }
