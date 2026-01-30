{

services.radarr = {
  enable = true;  
  user = "ensinador"; 
  group = "users";
  dataDir = "/home/ensinador/data/radarr";
  openFirewall = true;
};

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
    };
  };
};

services.sonarr = { 
  enable = true; 
  openFirewall = true;
  user = "ensinador";
  group = "users";
  dataDir = "/home/ensinador/data/sonarr";
};

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
