# Settings for darius that hold on every host.
# Consumed by flake.nix: `system` feeds nixosConfigurations, `home` feeds
# homeConfigurations.
{
  system = {
    pkgs,
    config,
    ...
  }: let
    ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  in {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.darius = {
      isNormalUser = true;
      description = "darius";
      shell = pkgs.fish;
      extraGroups =
        [
          "networkmanager"
          "wheel"
          "video"
          "cdrom"
          "audio"
        ]
        ++ ifTheyExist [
          "git"
          "network"
          "docker"
          "podman"
          "libvirtd"
          "seat"
          "render"
        ];
    };

    # Log in on the console with the LUKS passphrase typed at boot.
    mine.system.luks-autologin = {
      enable = true;
      user = "darius";
    };
    programs.fish.enable = true;
  };

  home = {
    home = {
      username = "darius";
      homeDirectory = "/home/darius";
      stateVersion = "23.11";
    };
  };
}
