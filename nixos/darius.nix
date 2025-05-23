{
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
        "libvirtd"
        "seat"
      ];
    # packages = with pkgs; [];
  };
  # Enable automatic login for the user.
  services.getty.autologinUser = "darius";
  programs.fish.enable = true;
}
