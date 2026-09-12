# Snapshot of tabosa's disko.nix from the old (replaced) hardware: LVM +
# ext4, VG/LV identifiers renamed to the SSPX-bishop scheme used elsewhere
# in this repo (tizil's VG is "sspx", LVs galarreta/anchieta/econe — this
# reuses the other three 1988 SSPX bishops: fellay/tissier/williamson).
# The live hosts/tabosa/disko.nix now targets different, smaller-SSD
# hardware with btrfs+LUKS instead — kept here for reference only, not
# imported anywhere.
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
              vg = "fellay";
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
              vg = "fellay";
            };
          };
        };
      };
    };
  };

  lvm_vg = {
    fellay = {
      type = "lvm_vg";
      lvs = {
        # `/` is created first (priority) so the %FREE math below is deterministic.
        # It holds the whole Nix store, so it gets the largest slice — NOT a token 15%.
        tissier = {
          priority = 100;
          size = "40%FREE"; # ~40% of the VG
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
            mountOptions = [ "defaults" "noatime" ];
          };
        };

        williamson = {
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
        # copy-on-write reserve LVM snapshots grow into (see the paired
        # backup/tabosa-snapshots-lvm.nix, which still uses the pre-rename
        # tabosaVG/root/home names since it was never actually updated live).
        # If you ever want more usable space, `lvextend` home into the reserve.
      };
    };
  };
};
}
