{

boot = {
  loader.systemd-boot = { 
    enable = true; 
	  memtest86.enable = true;
  };

  loader.efi.canTouchEfiVariables = true;

  plymouth.enable = true; 

  supportedFilesystems = ["ntfs"];  
};
}
