{
  config,
  pkgs,
  lib,
  ...
}:
# Automatic LVM (thick) snapshots for tabosa — a stand-in for the ZFS auto-snapshots
# we dropped. Snapshots of `/` and `/home` are taken on a timer and rotated per tier.
#
# Why this is "stable-prone":
#   * `/` and `/home` are plain LVs, never thin — the live filesystem is always safe.
#   * Each snapshot starts with a small CoW area and auto-extends (dmeventd) into the
#     ~24% of the VG left unallocated in ./disko.nix, so idle snapshots stay cheap.
#   * If that reserve ever fills, LVM simply drops the fullest *snapshot*; the live
#     filesystem keeps writing. A snapshot failure never endangers real data.
#
# Roll back a snapshot (offline, e.g. from the installer / another generation):
#   lvconvert --merge tabosaVG/<snapshot-name>   # merges on next activation of the LV
# Inspect / mount a snapshot read-only to grab files:
#   mount -o ro /dev/tabosaVG/<snapshot-name> /mnt/snap
let
  vg = "tabosaVG";
  lvs = [ "root" "home" ]; # LV names from ./disko.nix

  # How many snapshots to keep per tier. Bump these if you have spare VG reserve;
  # lower them if the disk is small. Total per LV = sum of these.
  retention = {
    weekly = 4; # last month
  };

  initialCow = "2G"; # initial CoW size; auto-extends via dmeventd as churn requires

  snapshotTool = pkgs.writeShellApplication {
    name = "lvm-auto-snapshot";
    runtimeInputs = [
      pkgs.lvm2
      pkgs.gnugrep
      pkgs.coreutils
    ];
    text = ''
      # usage: lvm-auto-snapshot <vg> <tag> <keep> <lv> [<lv> ...]
      vg="$1"; tag="$2"; keep="$3"; shift 3
      init_cow="${initialCow}"
      ts="$(date +%Y%m%d-%H%M%S)"

      for lv in "$@"; do
        snap="snap_''${tag}_''${lv}_''${ts}"

        # Take the snapshot (skip if a same-second name somehow already exists).
        if ! lvs "''${vg}/''${snap}" >/dev/null 2>&1; then
          lvcreate --quiet --snapshot --name "$snap" --size "$init_cow" "''${vg}/''${lv}"
        fi

        # Prune: keep only the newest $keep snapshots for this lv+tag.
        # Names sort chronologically, so reverse-lexical == newest-first.
        mapfile -t snaps < <(
          lvs --noheadings -o lv_name "$vg" 2>/dev/null \
            | tr -d ' ' \
            | grep -E "^snap_''${tag}_''${lv}_[0-9]" \
            | sort -r || true
        )
        if (( ''${#snaps[@]} > keep )); then
          for old in "''${snaps[@]:keep}"; do
            lvremove --quiet --yes "''${vg}/''${old}" || true
          done
        fi
      done
    '';
  };

  onCalendar = {
    weekly = "weekly";
  };

  mkService = tag: keep: {
    name = "lvm-snapshot-${tag}";
    value = {
      description = "LVM ${tag} auto-snapshot of ${lib.concatStringsSep ", " lvs}";
      serviceConfig = {
        Type = "oneshot";
        ExecStart =
          "${snapshotTool}/bin/lvm-auto-snapshot "
          + lib.concatStringsSep " " ([ vg tag (toString keep) ] ++ lvs);
      };
    };
  };

  mkTimer = tag: _keep: {
    name = "lvm-snapshot-${tag}";
    value = {
      description = "Schedule LVM ${tag} auto-snapshots";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = onCalendar.${tag};
        Persistent = true; # catch up missed runs after suspend/poweroff
        RandomizedDelaySec = "2m";
      };
    };
  };
in
{
  # dmeventd must run for snapshot auto-extend to actually happen.
  services.lvm.dmeventd.enable = true;

  # Grow a snapshot's CoW area when it passes 80% full, in 20% steps, from the
  # unallocated VG reserve. Merged into the module's /etc/lvm/lvm.conf (type = lines).
  environment.etc."lvm/lvm.conf".text = ''
    activation/snapshot_autoextend_threshold = 80
    activation/snapshot_autoextend_percent = 20
  '';

  systemd.services = lib.listToAttrs (lib.mapAttrsToList mkService retention);
  systemd.timers = lib.listToAttrs (lib.mapAttrsToList mkTimer retention);
}
