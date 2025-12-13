{pkgs, ...}: {

  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        backend = "pipe";
        bitrate = 320;
      };
    };
  };

  # services.easyeffects.enable = true; # requires program.dconf.enable=true in nixos config
  # home.packages = with pkgs; [
  #   calf
  #   lsp-plugins
  # ];
  #
  # xdg.configFile."easyeffects/output/cab-fw.json".source = builtins.fetchurl {
  #   url = "https://raw.githubusercontent.com/schuelermine/configuration/refs/heads/b0/source/cab-fw.json";
  #   sha256 = "0spw5nhhwwywhgfkadihwqzs933c9nzp6lrirmg8sbw24fp4zvpy";
  # };
}
