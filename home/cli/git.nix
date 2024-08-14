{...}: {
  programs.git = {
    enable = true;
    userName = "chitoroagad";
    userEmail = "darius.chitoroaga@pm.me";
    lfs.enable = true;
    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
      credential.helper = "store";
      push.autoSetupRemote = true;
    };
  };
}
