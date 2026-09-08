{
  config,
  lib,
  ...
}: {
  options.mine.desktop.theme.enable = lib.mkEnableOption "theme" // {default = true;};

  config = lib.mkIf config.mine.desktop.theme.enable {
    catppuccin = {
      enable = true;
      autoEnable = true;
      flavor = "mocha";
      accent = "sapphire";
      tty.enable = true;
    };
  };
}
