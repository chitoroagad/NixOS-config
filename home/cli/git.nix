{...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    signing = {
      key = "D3DB98147AF40F5ECCE75E54FEAC7C9776796F2C";
      signByDefault = true;
    };
    settings = {
      user.name = "chitoroagad";
      user.email = "darius.chitoroaga@pm.me";
      color.ui = true;
      core.editor = "nvim";
      credential.helper = "store";
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
      safe.directory = ["/home/darius/.sshfs/*"];
    };
  };
}
