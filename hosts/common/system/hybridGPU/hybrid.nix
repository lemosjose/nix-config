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
