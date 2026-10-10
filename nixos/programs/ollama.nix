# Not a service: run `ollama serve` when needed.
{
  config,
  lib,
  pkgs,
  ...
}: let
  # The Vulkan build picks up the 7700S on its own. Forcing
  # OLLAMA_LLM_LIBRARY=rocm sent it to the CPU, as this build has no ROCm
  # backend, so the HSA/HIP overrides are not needed either.
  ollama = pkgs.symlinkJoin {
    name = "ollama";
    paths = [pkgs.ollama-vulkan];
    nativeBuildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/ollama --set-default OLLAMA_KEEP_ALIVE 30s
    '';
    meta.mainProgram = "ollama";
  };
in {
  options.mine.programs.ollama.enable = lib.mkEnableOption "ollama";

  config = lib.mkIf config.mine.programs.ollama.enable {
    environment.systemPackages = [ollama];
  };
}
