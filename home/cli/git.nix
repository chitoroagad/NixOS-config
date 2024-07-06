{...}: {
  programs.git = {
    enable = true;
    userName = "DariusChit";
    userEmail = "darius.chitoroaga@proton.me";
    lfs.enable = true;
    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
      credential.helper = "store";
      push.autoSetupRemote = true;
    };
  };
}
