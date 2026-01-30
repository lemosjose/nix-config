{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gcc
    alacritty
    sway
    qbittorrent
    docker-compose
  ];
}
