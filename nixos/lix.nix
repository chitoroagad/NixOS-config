{
  pkgs,
  outputs,
  ...
}: {
  nixpkgs.overlays = [outputs.overlays.nix_lix];
  nix.package = pkgs.lixPackageSets.latest.lix;
}
