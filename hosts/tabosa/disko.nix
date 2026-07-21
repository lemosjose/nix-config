{
disko.devices = {
  disk = {
    sata = {
      type = "disk";
      device = "/dev/sda";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "2048M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          swap = {
            size = "16G";
            content = {
              type = "swap";
              discardPolicy = "both";
              resumeDevice = true;
            };
          };
          primary = {
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "tabosaVG";
            };
          };
        };
      };
    };
    nvme = {
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {
          primary = {
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "tabosaVG";
            };
          };
        };
      };
    };
  };

  lvm_vg = {
    tabosaVG = {
      type = "lvm_vg";
      lvs = {
        # `/` is created first (priority) so the %FREE math below is deterministic.
        # It holds the whole Nix store, so it gets the largest slice — NOT a token 15%.
        root = {
          priority = 100;
          size = "40%FREE"; # ~40% of the VG
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
            mountOptions = [ "defaults" "noatime" ];
          };
        };

        home = {
          priority = 200;
          size = "60%FREE"; # 60% of the remaining 60% ≈ 36% of the VG
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/home";
            mountOptions = [ "defaults" "noatime" ];
          };
        };

        # ~24% of the VG is intentionally left UNALLOCATED. That free space is the
        # copy-on-write reserve LVM snapshots grow into (see ./snapshots.nix).
        # If you ever want more usable space, `lvextend` home into the reserve.
      };
    };
  };
};
}
