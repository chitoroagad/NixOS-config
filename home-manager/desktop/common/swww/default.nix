{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [inputs.swww.packages.${pkgs.system}.swww];
}
