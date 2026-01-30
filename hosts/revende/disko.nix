{
disko.devices = {
  disk = {
    main = {
	    type = "disk";
	    device = "/dev/sda";
	    content = {
	      type = "gpt";
	      partitions = {
		      ESP = {
		        name = "ESP";
		        size = "2G";
		        type = "EF00";
		        content = {
		          type = "filesystem";
		          format = "vfat";
		          mountpoint = "/boot";
		          mountOptions = [ "umask=0077" ];
		        };
		      };

		      primary = {
		        size = "100%"; 
		        content = { 
		          type = "lvm_pv"; 
		          vg = "phantoms";
		        };
		      };
	      };
	    };
    };
  };

  lvm_vg = { 
    phantoms = { 
      type = "lvm_vg";
      lvs = { 
        yusuke = {
          size = "16G"; 
          content = {
            type = "swap";
            resumeDevice = true;
          };
        };
        
        joker = { 
          size = "15%FREE";
          content = { 
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
            mountOptions = [ "defaults" "noatime" ];
          };
        };

        sojiro = { 
          size = "65%FREE";
          content = { 
            type = "filesystem";
            format = "ext4";
            mountpoint = "/home";
            mountOptions = [ "defaults" "noatime" ];
          };
        };    
      };
    };
  };
};
}
