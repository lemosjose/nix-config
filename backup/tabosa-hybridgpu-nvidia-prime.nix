# Hybrid Intel+NVIDIA PRIME setup from the OLD tabosa (Samsung) hardware.
# Retired: the replacement machine is a Ryzen 7 7735HS (Radeon 680M iGPU,
# no discrete NVIDIA), so the proprietary driver, nouveau blacklist and the
# hardcoded PRIME bus IDs below (PCI:0:2:0 / PCI:1:0:0 — the Samsung's PCI
# topology) do not apply and would leave X/Wayland with no usable driver.
# Kept for reference only — not imported anywhere.
{
  lib,
  config,
  ...
}:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;

    powerManagement.enable = true;

    prime = {
      sync.enable = true;

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  boot.blacklistedKernelModules = [ "nouveau" ];

  boot.kernelParams = lib.mkAfter [ "nvidia-drm.modeset=1" ];

  services.xserver.enable = true;
  services.xserver.videoDrivers = [
    "nvidia"
    "modesetting"
  ];
}
