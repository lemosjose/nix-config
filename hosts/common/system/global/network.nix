{
networking = {
  networkmanager = {
    enable = true;
    wifi = {
      backend = "wpa_supplicant";
      #just to remember me iwd didn't go well
    }; 
  };
  firewall = { 
    enable = true;
	  allowedTCPPorts = [
      8080
	    9090
      1234
      8000
      80
      27017
    ];
  };
};

time.timeZone = "America/Sao_Paulo";
}

