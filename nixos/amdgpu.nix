{pkgs, ...}: {
  hardware = {
    graphics.extraPackages = with pkgs; [
      amdvlk
      rocmPackages.clr.icd # opencl
    ];
    amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
      amdvlk.enable = true;
    };
  };

  # LACT (Linux AMDGPU Controller) GUI
  environment.systemPackages = with pkgs; [lact];
  systemd.packages = with pkgs; [lact];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  # HIP libs
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
}
