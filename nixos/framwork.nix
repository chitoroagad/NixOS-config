{config, ...}: {
  hardware.framework.enableKmod = false;
  boot = {
    kernelModules = ["cros_ec" "cros_ec_lpcs"];
    extraModulePackages = with config.boot.kernelPackages; [
      framework-laptop-kmod
    ];
  };
}
