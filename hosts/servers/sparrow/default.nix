{ lib, ... }:

{

services.radarr = {
  enable = true;
  user = "ensinador";
  group = "users";
  dataDir = "/var/lib/radarr";
  openFirewall = true;
};

systemd.services.radarr.serviceConfig.ProtectHome = lib.mkForce false;

services.qbittorrent = {
  enable = true;
  user = "ensinador";
  group = "users";
  openFirewall = true;
  serverConfig = {
    Preferences = {
      WebUI = {
        LocalHostAuth = true;
        Username = "ensinador";
        Password_PBKDF2 = "@ByteArray(MW55BgONCsTmdL8p3r50iw==:zrDy4vj5F3dnE23bS6VMmAjTiQE7AVIuRRSCIx503zU+FyljvaaL0pH92G9kniZJ7ds61w7EJs7zPYTrx2wN3Q==)";
      };
      Downloads = {
        SavePath = "/home/ensinador/media/downloads";
      };
    };
  };
};

systemd.services.qbittorrent.serviceConfig.ProtectHome = lib.mkForce false;

services.sonarr = {
  enable = true;
  openFirewall = true;
  user = "ensinador";
  group = "users";
  dataDir = "/var/lib/sonarr";
};

systemd.services.sonarr.serviceConfig.ProtectHome = lib.mkForce false;

services.flaresolverr = {
  enable = true;
  openFirewall = true;
};

services.prowlarr = {
  enable = true;
  openFirewall = true;
  dataDir = "/home/ensinador/data/prowlarr";
};

services.bazarr = {
  enable = true;
  openFirewall = true;
  dataDir = "/home/ensinador/data/bazarr";
  user = "ensinador";
  group = "users";
};

}
