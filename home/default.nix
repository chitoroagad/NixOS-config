# This is your home-manager configuration aile
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  outputs,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports =
    [
      # If you want to use modules your own flake exports (from modules/home-manager):
      # outputs.homeManagerModules.example

      # Or modules exported from other flakes (such as nix-colors):
      # inputs.nix-colors.homeManagerModules.default
      # You can also split up your configuration and import pieces of it here:
      # ./nvim.nix

      ./desktop/common
      ./desktop/hyprland

      ./cli
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.stable-packages
      outputs.overlays.master-packages
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.nix_lix

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix.package = pkgs.lixPackageSets.latest.lix;

  home = {
    username = "darius";
    homeDirectory = "/home/darius";
    packages = with pkgs; [
      fastfetch

      # archives
      zip
      unzip
      xz

      # utils
      ripgrep
      jq
      eza
      fzf
      file

      # misc
      which
      trash-cli
      tldr
      cachix

      # sys tools
      pciutils
      usbutils
      nmap

      # Browser
      brave
      google-chrome
      firefox

      # Other
      stable.spotify
      stable.libreoffice
      slack
      proton-vpn
      proton-pass
      discord
      webcord
      vlc
      pavucontrol
      obs-studio
      zoom-us
      gimp
    ];
  };
  news.display = "show";

  # Colorscheme
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "sapphire";

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
