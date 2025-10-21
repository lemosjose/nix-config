{ config, lib, pkgs, modulesPath, ... }:


{
  hardware = { 
	  bluetooth = { 
	    enable = true; 
	    powerOnBoot = true;
	  };
	};


	services = { 
	  #waking up my laptop from the usb hub with devices
	  udev.extraRules = ''
	         ACTION=="add", SUBSYSTEM=="usb", DRIVER=="usb", ATTR{power/wakeup}="enabled", ATTR{bInterfaceClass}=="03"
		 ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TAG+="mutter-device-preferred-primary"
	     '';

	  blueman.enable = true;

	};

	specialisation = { 
	  nvidia.configuration = { 
	    # Nvidia Configuration 
		  services.xserver.videoDrivers = [ "nvidia" ]; 
		  hardware.graphics.enable = true; 
	    
	    # Optionally, you may need to select the appropriate driver version for your specific GPU. 
	    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable; 
	    hardware.nvidia.open = false; 
	    hardware.nvidia.prime = { 
		    sync.enable = lib.mkForce true; 
		    
		    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA 
		    nvidiaBusId = "PCI:1:0:0"; 
		    
		    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA 
		    intelBusId = "PCI:0:2:0"; 
	    };
	  };



};

} 


