{
  imports = [
    ./pkgs.nix
  ];
  services.jellyfin.enable = true;
  services.jellyfin.openFirewall = true;
  services.jellyfin.hardwareAcceleration.enable = true;
  services.jellyfin.hardwareAcceleration.device = "/dev/dri/renderD128";

  services.jellyfin.user = "ensinador";

  systemd.services.jellyfin = {
    serviceConfig = {
      PrivateNetwork = false;
      BindReadOnlyPaths = ["/etc/resolv.conf"];
    };
    
    environment = {
      DOTNET_SYSTEM_NET_DISABLEIPV6 = "1";
    };
  };
  
}
