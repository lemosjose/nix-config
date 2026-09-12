# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal Nix flake providing NixOS system configs and home-manager configs for three physical machines plus one standalone home-manager profile. Layout style is based on Misterio77's example configs. Hostnames are named after "Garras da Patrulha" characters:

- **tizil** — main desktop, full AMD (CPU+GPU), gaming-oriented (`hosts/tizil/gaming/`), LVM-on-disko.
- **tabosa** — Samsung laptop, hybrid GPU, power-saving tuned, btrfs snapshots.
- **revende** — old HP laptop repurposed as a local media server (Jellyfin + Radarr/Sonarr/Prowlarr/Bazarr/qBittorrent/Flaresolverr under user `ensinador`), static LAN IP, sleep/suspend disabled.
- **lemos** (`homeConfigurations.lemos`) — standalone home-manager profile (no NixOS) for WSL2 or other distros.

## Commands

Build/switch a host (run on that host, as the config references host-specific hardware/disko files):
```
sudo nixos-rebuild switch --flake .#tizil
sudo nixos-rebuild switch --flake .#tabosa
sudo nixos-rebuild switch --flake .#revende
```
Dry-build without switching (safe to run anywhere to check evaluation, though hardware-specific hosts may still fail off-target):
```
nixos-rebuild build --flake .#<host>
```
Standalone home-manager profile (`lemos`, e.g. WSL2):
```
home-manager switch --flake .#lemos
```
Ad hoc dev shells (not part of flake outputs; invoke directly):
```
nix-shell shells/fullstack.nix
nix-shell shells/haskell.nix
nix-shell shells/python.nix
nix-shell shells/robo.nix
```
Format/check flake:
```
nix flake check
```

There is no test suite, linter, or CI in this repo — validation is `nixos-rebuild build`/`switch` succeeding on the target host.

## Repo etiquette

**Never run `git commit` or `git push` in this repo, under any circumstances — not even on an explicit-sounding request like "sync the repo" or "commit this."** This repo is manually synced across three machines (tizil/tabosa/revende); the user wants full manual control over what enters history and when. Stage and prepare changes, leave the working tree ready, and tell the user exactly what's ready — they run the commit/push themselves. (This is enforced technically too, via a `permissions.deny` rule in `.claude/settings.json` blocking `git commit`/`git push`, in addition to this instruction — the deny rule is the backstop, this note is the reason.)

**`flake.lock` is intentionally not committed** — do not `git add` it or re-track it unless explicitly asked; inputs are meant to float rather than be pinned in git.

## Architecture

### Composition pattern
Each host's `hosts/<host>/default.nix` is a thin composition root: it imports hardware-specific files (`hardware-configuration.nix`, `disko.nix`), shared system modules, and the users that should exist on that host. Nearly all real configuration lives in the shared modules under `hosts/common/`, not in the host files themselves.

- `hosts/common/system/global/` — modules imported by **every** NixOS host unconditionally (boot, flatpak, fonts, hardware, network, pkgs, programs, services, xdg), wired together via `hosts/common/system/global/default.nix`.
- `hosts/common/system/` (top-level `default.nix`) — cross-host baseline: enables the home-manager NixOS module (`useGlobalPkgs`/`useUserPackages`), raises `nofile` limits for `@wheel`, enables flakes, sets `vm.swappiness`.
- `hosts/common/system/misc/` — **optional** modules (cosmic, gnome, plasma, ollama, podman, hybridGPU) that hosts opt into individually via their own import list — not auto-included.
- `hosts/common/users/<user>/default.nix` — defines the NixOS user account (groups, subuid/subgid ranges, hashed password) and wires `home-manager.users.<user>` to `home/<user>/${config.networking.hostName}.nix`. This means **each user's home-manager config file is selected dynamically by hostname** — adding a user to a new host requires creating `home/<user>/<hostname>.nix`.
- `hosts/servers/` — role modules for server hosts (currently only `revende` uses these): `media/` (Jellyfin), `sparrow/` (the *arr stack: Radarr/Sonarr/Prowlarr/Bazarr/qBittorrent/Flaresolverr), `ssh.nix`.

### Home-manager side
`home/common/` holds modules shared across all users/hosts (firefox, git, pkgs, vscode, zsh), imported via `home/common/default.nix`. Per-user, per-host files (e.g. `home/Joseph/tizil.nix`, `home/lemos/tabosa.nix`) layer host-specific home-manager config (e.g. `home/common/tabosa/{gnome,plasma}.nix`, `home/common/tizil/{default,gnome-extra}.nix`) on top of the shared common modules.

### Disk layout
Disko (`hosts/<host>/disko.nix`) is the current approach for all three NixOS hosts. tizil uses an LVM volume group (`sspx`) on top of a GPT/ESP layout; zfs was removed from active use (see `backup/zfs.nix` / `backup/btrfs.nix`, kept only as reference, not imported anywhere).

### Flake inputs worth knowing
`nixpkgs` tracks `nixos-unstable`; `home-manager` tracks `master`; other inputs (`nix-flatpak`, `firefox-addons` via NUR, `jovian`, `hardware` = nixos-hardware, `plasma-manager`, `disko`) mostly `follows` the same `nixpkgs`. `jovian` is present as an input but not currently wired into any visible host config.
