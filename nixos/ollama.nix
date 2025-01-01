{pkgs, ...}: {
  services.ollama = {
    package = pkgs.stable.ollama;
    enable = true;
    acceleration = "rocm";
    rocmOverrideGfx = "11.0.1";
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "30s";
      OLLAMA_LLM_LIBRARY = "rocm";
    };
  };
}
