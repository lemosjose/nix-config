# tabosa on its replacement hardware: smaller 256G SSD, so btrfs (zstd
# compression, no fixed-percentage preallocation like the old LVM setup —
# subvolumes just share the pool) behind a single LUKS2 container for
# full-disk encryption (laptop).
#
# `device` below is confirmed as /dev/nvme0n1 on this machine. Re-check with
# `lsblk` if the hardware ever changes — disko WILL wipe whatever it points at.
#
# LUKS prompts interactively (twice, with confirmation) when disko creates
# it. Nothing extra is needed in default.nix: the disko module already
# generates boot.initrd.luks.devices.lefebvre pointing at
# /dev/disk/by-partlabel/disk-main-luks, so initrd prompts to unlock at
# every boot. Don't redefine it by hand.
#
# No dedicated swap partition here (deliberate, given the smaller disk) —
# no hibernate support as a result. Add a swapfile subvolume or a small
# LUKS swap partition later if you want it back.
#
# Identifiers continue the SSPX/Catholic naming used elsewhere in this repo
# (tizil: VG "sspx", LVs galarreta/anchieta/econe; the old tabosa hardware,
# now in backup/: fellay/tissier/williamson) with four more names not used
# yet: lefebvre (SSPX's founder, for the LUKS container — same role "sspx"
# plays on tizil), castromayer (the Brazilian bishop present at the 1988
# consecrations, for /), menzingen (SSPX's general house, for /home), and
# zaitzkofen (SSPX's German seminary, for /nix).
{
disko.devices = {
  disk = {
    main = {
      type = "disk";
      device = "/dev/nvme0n1"; # VERIFY with `lsblk` before running disko
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            # 2G to match tizil/the old tabosa layout. systemd-boot keeps a
            # kernel+initrd per generation here and configurationLimit is
            # unset (unlimited), so a 1G ESP fills after ~10-15 rebuilds.
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

          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "lefebvre";
              settings = {
                allowDiscards = true; # SSD TRIM through the encrypted layer
              };
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/@castromayer" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "/@menzingen" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "/@zaitzkofen" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  # 8G swapfile, matching the machine's 8G of RAM (~6G usable
                  # after the iGPU carve-out). Lives inside the LUKS container,
                  # so it's encrypted without a second passphrase prompt.
                  # No compress= here: `btrfs filesystem mkswapfile` marks the
                  # file NOCOW, and swap must not be compressed.
                  "/@flavigny" = {
                    mountpoint = "/swap";
                    mountOptions = [ "noatime" ];
                    swap.swapfile.size = "8G";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
};
}
