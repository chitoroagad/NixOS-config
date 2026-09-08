{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mine.services.ollama.enable = lib.mkEnableOption "ollama";

  config = lib.mkIf config.mine.services.ollama.enable {
    services.ollama = {
      package = pkgs.ollama-vulkan;
      enable = true;
      rocmOverrideGfx = "11.0.2";
      environmentVariables = {
        OLLAMA_KEEP_ALIVE = "30s";
        OLLAMA_LLM_LIBRARY = "rocm";
        HIP_VISIBLE_DEVICES = "0"; # make sure it uses 7700S on FM16
      };
    };
  };
}
