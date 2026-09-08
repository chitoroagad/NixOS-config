{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.programs.virtualisation.enable = lib.mkEnableOption "virtualisation";

  config = lib.mkIf config.mine.programs.virtualisation.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu.vhostUserPackages = [pkgs.virtiofsd];
    };
    programs.virt-manager.enable = true;

    users.users.darius.extraGroups = ["libvirtd"];
  };
}
