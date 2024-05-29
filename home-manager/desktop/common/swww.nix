{pkgs, ...}: {
  home.packages = [
    pkgs.swww
  ];
  programs.zsh.loginShellInit = ''

  '';
}
