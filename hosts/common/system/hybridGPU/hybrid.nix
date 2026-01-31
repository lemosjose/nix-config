{
  lib,
  ...
}: {
hardware.nvidia = { 
  open = false;
	modesetting.enable = true;
	nvidiaSettings = false;

  powerManagement.enable = true;
  
	prime = {
    sync.enable = true;
    
	  intelBusId = "PCI:0:2:0";
	  nvidiaBusId = "PCI:1:0:0";
	};
};

boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

boot.kernelParams = lib.mkAfter [ "modprobe.backlist=nouveau" "nvidia-drm.modeset=1" ];

services.xserver.videoDrivers = [ "nvidia" "modesetting" ];

services.displayManager.gdm.wayland = true; 

}
