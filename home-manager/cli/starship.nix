{...}: {
  programs.starship = {
    enable = true;
    settings = {
      format = let
        git = "$git_branch$git_commit$git_state$git_status";
        cloud = "$aws$gcloud$openstack";
      in ''
        $username$hostname($shlvl)($cmd_duration) $fill ($nix_shell)$custom
        $directory(${git})(${cloud}) $fill $time
        $jobs$character
      '';

      fill = {
        symbol = " ";
        disabled = false;
      };
    };
  };
}
