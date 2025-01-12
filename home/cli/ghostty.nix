{
  pkgs,
  inputs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages.${pkgs.system}.ghostty;
    enableZshIntegration = true;
    enableBashIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
  };
}
