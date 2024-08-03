{pkgs, ...}: {
  services.ollama = {
    package = pkgs.stable.ollama;
    enable = true;
    acceleration = "rocm";
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "30s";
    };
  };
}
