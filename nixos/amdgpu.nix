{
  pkgs,
  config,
  ...
}: {
  hardware = {
    graphics.extraPackages = with pkgs; [
      rocmPackages.clr
      rocmPackages.clr.icd # opencl
      rocmPackages.rocblas
      rocmPackages.rpp
      mesa
    ];
    amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
    };
  };

  # LACT (Linux AMDGPU Controller) GUI
  environment.systemPackages = with pkgs; [lact];
  systemd.packages = with pkgs; [lact];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  # HIP libs https://wiki.nixos.org/wiki/AMD_GPU#HIP
  systemd.tmpfiles.rules = let
    rocmEnv = pkgs.symlinkJoin {
      name = "rocm-combined";
      paths = with pkgs.rocmPackages; [
        rocblas
        hipblas
        clr
      ];
    };
  in [
    "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
  ];

  environment.variables = {
    ROCM_PATH = "/opt/rocm";
    HSA_OVERRIDE_GFX_VERSION = "11.0.0"; # Adjust based on your GPU (e.g., gfx1010)
    HIP_VISIBLE_DEVICES = "0";
    ROCM_VISIBLE_DEVICES = "0";
  };

  nixpkgs.config.rocmSupport = true;
  boot.initrd.kernelModules = ["amdgpu"];
}
