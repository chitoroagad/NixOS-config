{
  pkgs,
  pkgs-stable,
  ...
}: {
  services.ollama = {
    package = pkgs-stable.${pkgs.system}.ollama;
    enable = true;
    acceleration = "rocm";
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "30s";
    };
  };
}
