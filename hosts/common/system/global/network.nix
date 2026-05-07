{ pkgs,
  ...
}: {
networking = {
  networkmanager = {
    enable = true;
    wifi = {
      backend = "wpa_supplicant";
      #just to remember me iwd didn't go well
    };
    dns = "systemd-resolved"; 
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

systemd.services.pritunl-client = {
    description = "Pritunl Client Daemon";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    
    # Notice: the raw string is gone. NixOS only accepts package derivations here.
    path = [ 
      pkgs.systemd 
      pkgs.iproute2 
      pkgs.openvpn 
    ];
    
    serviceConfig = {
      # Notice: The empty string "" flushes out any ghost configurations
      ExecStart = [
        ""
        "${pkgs.pritunl-client}/bin/pritunl-client-service"
      ];
      Restart = "always";
    };
};

time.timeZone = "America/Sao_Paulo";
}

