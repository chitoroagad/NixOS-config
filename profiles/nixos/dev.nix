{
  config,
  lib,
  ...
}: {
  options.mine.profiles.dev.enable = lib.mkEnableOption "development";

  config = lib.mkIf config.mine.profiles.dev.enable {
    mine.services.docker.enable = lib.mkDefault true;
    mine.programs = {
      nix-ld.enable = lib.mkDefault true;
      man.enable = lib.mkDefault true;
      virtualisation.enable = lib.mkDefault true;
    };
  };
}
