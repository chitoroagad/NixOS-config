{pkgs, ...}: {
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "30s";
    };
  };
}
