{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = lib.mkAfter [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
}
