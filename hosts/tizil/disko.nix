{
disko.devices = {
  disk = {
    type = "disk";
    device = "/dev/nvme0n1";
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
            vg = "sspx";
          };
        };
      };
    };
  };

  lvm_vg = { 
    sspx = { 
      type = "lvm_vg";
      lvs = { 
        anchieta = { 
          size = "15% FREE";
          content = { 
            type = "filesystem";
            format = "xfs";
            mountpoint = "/";
            mountOptions = [ "defaults" "noatime" ];
          };
        };

        econe = { 
          size = "65% FREE";
          content = { 
            type = "filesystem";
            format = "ext4";
            mountpoint = "/home";
            mountOptions = [ "defaults" "noatime" ];
          };
        };

        

        galarreta = {
          size = "16G"; 
          content = {
            type = "swap";
            resumeDevice = true;
          };
        };
      };
    };
  };
};

