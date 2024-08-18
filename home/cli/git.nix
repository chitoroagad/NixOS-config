{...}: {
  programs.git = {
    enable = true;
    userName = "chitoroagad";
    userEmail = "darius.chitoroaga@pm.me";
    lfs.enable = true;
    signing = {
      key = "D3DB98147AF40F5ECCE75E54FEAC7C9776796F2C";
      signByDefault = true;
    };
    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
      credential.helper = "store";
      push.autoSetupRemote = true;
    };
  };
}
